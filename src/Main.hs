{-# LANGUAGE OverloadedStrings #-}

module Main
(
    main
) where

import Marconi.V1.Http.Queue

main :: IO ()
main = do
    x <- getQueue "http://166.78.254.33:8888/v1/" "queue" "project"
    putStr $ show x