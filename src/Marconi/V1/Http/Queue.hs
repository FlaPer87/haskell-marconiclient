{-# LANGUAGE OverloadedStrings #-}

module Marconi.V1.Http.Queue
(
    getQueue
) where


import System.IO.Streams (InputStream, OutputStream, stdout)
import qualified Data.ByteString.Char8 as B
import qualified System.IO.Streams as Streams
import qualified Network.Http.Client as C
import Marconi.Common.Http

getQueue :: B.ByteString -> B.ByteString -> B.ByteString -> IO B.ByteString
getQueue s q p = do
    --q <- buildRequest $ do
    --     http POST "/api/v1/messages"
    --     setContentType "application/json"
    --     setHostname "clue.example.com" 80
    --     setAccept "text/html"
    --     setHeader "X-WhoDoneIt" "The Butler"
    let x = s `B.append` q
    --putStr $ show x
    r <- buildRequest C.GET s p
    get s r statusHandler