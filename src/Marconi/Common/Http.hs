module Marconi.Common.Http
(
    statusHandler
) where

import System.IO.Streams (InputStream, OutputStream, stdout)
import Data.ByteString (ByteString)
import Network.Http.Client
import qualified Marconi.Common.Json

statusHandler :: Response -> InputStream ByteString -> IO ByteString
statusHandler p i = do
    case getStatusCode p of
        200 -> concatHandler p i
        _   -> error "ERROR!!!!!!"

