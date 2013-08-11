
import System.IO
import System.Exit

import Test.HUnit

import Json

main :: IO ()
main = do
    counts <- runTestTT (test [jsonTests])
    if (errors counts + failures counts == 0)
        then exitSuccess
        else exitFailure