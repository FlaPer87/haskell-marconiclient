{-# LANGUAGE DeriveGeneric, OverloadedStrings #-}

module Marconi.Common.Json
(
    Queue,
    Message
) where

import Control.Applicative ((<$>), (<*>), empty)
import Data.ByteString (ByteString)
import qualified Data.Map as Map
import qualified Data.Text as Text

import Data.Aeson ((.:))
import qualified Data.Aeson as A
import qualified Data.Aeson.Types as AT
import qualified Data.Aeson.Generic as AG
import qualified Data.HashMap.Strict as H

import Data.Aeson ((.=), object)
import GHC.Generics (Generic)

-- Queues have no attributes, just metadata, therefore
-- it just accepts an Aeson Object.
data Queue = Queue A.Object deriving (Show, Generic)

-- Message
data Message = Message
    { href :: String
    , ttl :: Int
    , age :: Int
    , body :: A.Object
    } deriving (Show)

-- A ToJSON instance allows us to encode a value as JSON.

instance A.ToJSON Message where
  toJSON (Message hrefV ttlV ageV bodyV) = object [ "href" .= hrefV,
                                                    "ttl"  .= ttlV,
                                                    "age"  .= ageV,
                                                    "body" .= bodyV]

-- A FromJSON instance allows us to decode a value from JSON.  This
-- should match the format used by the ToJSON instance.

instance A.FromJSON Message where
  parseJSON (A.Object v) = Message <$>
                         v .: "href" <*>
                         v .: "ttl"  <*>
                         v .: "age"  <*>
                         v .: "body"
  parseJSON _          = empty