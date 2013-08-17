{-# LANGUAGE OverloadedStrings  #-}
{-# OPTIONS -fno-warn-orphans  #-}

module Marconi.Common.Http
(
    statusHandler,
    get,
    buildRequest
) where

import Data.ByteString (ByteString)
import Network.URI (URI (..), URIAuth (..), parseURI)
import System.IO.Streams (InputStream, OutputStream, stdout)

import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Network.Http.Client as C
import Network.Http.Client (Request (..))
import qualified Marconi.Common.Json


statusHandler :: C.Response -> InputStream ByteString -> IO ByteString
statusHandler p i = do
    case C.getStatusCode p of
        200 -> C.concatHandler p i
        _   -> error "ERROR!!!!!!"

{-
    Account for bug where "http://www.example.com" is parsed with no
    path element, resulting in an illegal HTTP request line.
-}
path :: URI -> ByteString
path u = case url of
            ""  -> "/"
            _   -> url
  where
    url = T.encodeUtf8 $! T.pack
                      $! concat [uriPath u, uriQuery u, uriFragment u]

parseURL :: C.URL -> URI
parseURL r' =
    case parseURI r of
        Just u  -> u
        Nothing -> error ("Can't parse URI " ++ r)
    where
        r = T.unpack $ T.decodeUtf8 r'

buildRequest :: C.Method -> C.URL -> ByteString -> IO C.Request
buildRequest m r p = do
    let u = parseURL r
    C.buildRequest $ do
            C.http m (path u)
            C.setAccept "application/json"
            C.setHeader "X-PROJECT-ID" p

get :: C.URL
    -- FIXME: Really Nasty. There's no way
    -- to get the request port from C.Request.
    -> Request
    -- ^ Resource to GET from.
    -> (C.Response -> InputStream ByteString -> IO ByteString)
    -- ^ Handler function to receive the response from the server.
    -> IO ByteString
get u r' handler = do
    c <- C.establishConnection u
    C.sendRequest c r' C.emptyBody
    C.receiveResponse c statusHandler