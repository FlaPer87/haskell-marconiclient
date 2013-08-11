{-# LANGUAGE OverloadedStrings #-}

module Json
(
    jsonTests
) where

import Test.HUnit
import Data.Aeson
import qualified Data.Aeson.Types as AT

import qualified Data.Text as T
import qualified Data.HashMap.Strict as HM

import qualified Marconi.Common.Json as J

jsonTests = TestList [TestLabel "messageType" messageType]

messageType = TestCase $ do
    case decode "{\"href\": \"test\", \"ttl\": 2, \"age\": 2, \"body\": {}}" :: Maybe J.Message of
        Just msg -> assertBool "Message Decoded" True
        _      -> error "Nothing decoded"