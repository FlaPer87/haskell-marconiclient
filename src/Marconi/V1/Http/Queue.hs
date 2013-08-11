{-# LANGUAGE OverloadedStrings #-}

module Marconi.V1.Http.Queue
(
    getQueue
) where


import System.IO.Streams (InputStream, OutputStream, stdout)
import Data.ByteString (ByteString)
import qualified System.IO.Streams as Streams
import Network.Http.Client
import Marconi.Common.Http

getQueue :: ByteString -> String -> String -> IO ByteString
getQueue s q p = do
    get s statusHandler