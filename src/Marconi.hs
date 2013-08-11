{-# LANGUAGE OverloadedStrings #-}

module Marconi
(
    main
) where

import Marconi.Common.Json
import Marconi.V1.Http.Queue


main :: IO ()
main = do
    x <- getQueue "http://blog.flaper87.org" "queue" "project"
    putStr $ show x