module LintSpec where

import Language.Haskell.GhcMod
import Test.Hspec
import TestUtils

spec :: Spec
spec = do
    describe "lint" $ do
        it "can detect a redundant import" $ do
            res <- runD $ lint "test/data/hlint.hs"
            res `shouldBe` "test/data/hlint.hs:4:8: Error: Redundant do\NULFound:\NUL  do putStrLn \"Hello, world!\"\NULWhy not:\NUL  putStrLn \"Hello, world!\"\n"

        context "when no suggestions are given" $ do
            it "doesn't output an empty line" $ do
                res <- runD $ lint "test/data/ghc-mod-check/Data/Foo.hs"
                res `shouldBe` ""
