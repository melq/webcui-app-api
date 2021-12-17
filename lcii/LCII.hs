module LCII where

import Data.List
import Data.Char

import Eval
import Typing
import DataType
import Coloring
import Parser

-------------------------------------------------------------------------------
-- Lambda Calculus Interactive Intepreter
-------------------------------------------------------------------------------
lcii :: IO ()
lcii = do
    putStrLn ""
    putStrLn "*****************************************************"
    putStrLn "    LCII: Lambda Calculus Interactive Interpreter    "
    putStrLn "*****************************************************"
    putStrLn ""
    putStrLn ":typed   :t   Use typed lambda calculus"
    putStrLn ":untyped :u   Use untyped lambda calculus"
    putStrLn ":quit    :q   Quit LCII"

    let loop = do
        putStrLn ""
        putStrLn "* Input a command *"
        putStr "LCII > "
        cmd  <- getLine
        res <- lciiCmd cmd
        if res == 0
        then do loop
        else do return ()
    loop


lciiCmd :: String -> IO Int
lciiCmd cmd = do
    if cmd == ":typed" || cmd == ":t" then do
        putStrLn "* Input typed lambda term *"
        putStr "LCII > "
        t  <- getLine
        putStrLn "* Input type environment *"
        putStr "LCII > "
        ga <- getLine
        if ga == ""
        then ii [] [] (parseExp t)
        else ii [] (parseEnv ga) (parseExp t)
        return 0
    else if cmd == ":untyped" || cmd == ":u" then do
        putStrLn "* Input untyped lambda term *"
        putStr "LCII > "
        t  <- getLine
        iiUntyped (parseExp t)
        return 0
    else if cmd == ":quit" || cmd == ":q" then do
        putStrLn "* Quit LCII *"
        return 1
    else do
        putStrLn "* Error *"
        return 0

ii :: [String] -> [Decl] -> Expr -> IO ()
ii xi ga t = do
    let occ = getRedexPos t []
    putStrLn ""
    printWithColor False t
    if hasFailure $ typing xi ga t
    then do
        putStrLn "Typing Error"
    else do
        if null occ
        then do
            showGa ga
        else do
            showRedexes False t
            putStr "Redex: "
            num <- getLine
            if not $ all isDigit num
            then do
                putStrLn "Invalid input"
                ii xi ga t
            else do
                let idx = (read num :: Int) - 1
                if idx > length occ - 1
                then do
                    putStrLn $ "The maximum redex number is " ++ show (length occ)
                    ii xi ga t
                else do
                    let alpha = getAlpha t [] (occ !! idx) (getFV t)
                    if null alpha
                    then do putStr ""
                    else do
                        putStrLn ""
                        putStr $ ansi' Reverse $ "α: " ++ intercalate ", " alpha
                        putStrLn ""
                    ii xi ga $ reduction t (occ !! idx)

iiUntyped :: Expr -> IO ()
iiUntyped term = do
    let t = n2l term
    let occ = getRedexPos t []
    putStrLn ""
    printWithColor True t
    if null occ
    then do
        putStr ""
    else do
        showRedexes True t
        putStr "Redex: "
        num <- getLine
        if not $ all isDigit num
        then do
            putStrLn "Invalid input"
            iiUntyped t
        else do
            let idx = (read num :: Int) - 1
            if idx > length occ - 1
            then do
                putStrLn $ "The maximum redex number is " ++ show (length occ)
                iiUntyped t
            else do
                let alpha = getAlpha t [] (occ !! idx) (getFV t)
                if null alpha
                then do putStr ""
                else do
                    putStrLn ""
                    putStr $ ansi' Reverse $ "α: " ++ intercalate ", " alpha
                    putStrLn ""
                iiUntyped $ reduction t (occ !! idx)
