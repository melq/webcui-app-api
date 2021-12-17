module Eval where

import Data.List
import Data.Maybe
import Data.Bifunctor

import Typing
import DataType
import Coloring
import Parser

-------------------------------------------------------------------------------
-- One step reduction
-------------------------------------------------------------------------------
reduction t pos = eval t [] pos (getFV t)

eval :: Expr -> [Int] -> [Int] -> [Id] -> Expr
eval (A (L x tau m1) m2) cPos rPos bv =
    if cPos == rPos
        then assign m1 x m2 bv
        else A (eval (L x tau m1) (cPos ++ [1]) rPos bv) (eval m2 (cPos ++ [2]) rPos bv)
eval (A m1 m2)    cPos rPos bv = A (eval m1 (cPos ++ [1]) rPos bv) (eval m2 (cPos ++ [2]) rPos bv)
eval (L x tau m)  cPos rPos bv = L x tau $ eval m (cPos ++ [1]) rPos (x:bv)
eval (T ms)       cPos rPos bv = T $ [ eval (ms !! (i-1)) (cPos ++ [i]) rPos bv | i <- [1..length ms] ]
eval (P (T ms) i) cPos rPos bv =
    if cPos == rPos
        then ms !! (i-1)
        else P (eval (T ms) (cPos ++ [1]) rPos bv) i
eval (P m i)       cPos rPos bv = P (eval m (cPos ++ [1]) rPos bv) i
eval (R ms)        cPos rPos bv = R [ (fst (ms !! (i-1)), eval (snd (ms !! (i-1))) (cPos ++ [i]) rPos bv) | i <- [1..length ms] ]
eval (F (R ms) s)  cPos rPos bv =
    if cPos == rPos
        then caseFind ms s
        else F (eval (R ms) (cPos ++ [1]) rPos bv) s
eval (F m s)       cPos rPos bv = F (eval m (cPos ++ [1]) rPos bv) s
eval (Inj s m tau) cPos rPos bv = Inj s (eval m (cPos ++ [1]) rPos bv) tau
eval (Case (Inj s m tau) ms) cPos rPos bv =
    if cPos == rPos
        then A (caseFind ms s) m
        else Case (eval (Inj s m tau) (cPos ++ [1]) rPos bv) [ (fst (ms !! (i-1)), eval (snd (ms !! (i-1))) (cPos ++ [2] ++ [i]) rPos bv) | i <- [1..length ms] ]
eval (Case m ms) cPos rPos bv = Case (eval m (cPos ++ [1]) rPos bv) [ (fst (ms !! (i-1)), eval (snd (ms !! (i-1))) (cPos ++ [2] ++ [i]) rPos bv) | i <- [1..length ms] ]
eval (TyL t m)   cPos rPos bv = TyL t $ eval m (cPos ++ [1]) rPos bv
eval (TyA (TyL t m) tau) cPos rPos bv =
    if cPos == rPos
        then tySubst m t tau []
        else TyA (eval (TyL t m) (cPos ++ [1]) rPos bv) tau
eval (TyA m tau)   cPos rPos bv = TyA (eval m (cPos ++ [1]) rPos bv) tau
eval t cPos rPos bv = t

caseFind :: [(String, Expr)] -> String -> Expr
caseFind ((s, m):[]) s' = if s == s' then m else U
caseFind ((s, m):ss) s' = if s == s' then m else caseFind ss s'

assign :: Expr -> String -> Expr -> [Id] -> Expr
assign (C x tau)   name am bv = C x tau
assign (V x)       name am bv = if x == name then am else V x
assign (A m1 m2)   name am bv = A (assign m1 name am bv) (assign m2 name am bv)
assign (L x tau m) name am bv
  | x /= name && notElem x (getFV am) = L x tau $ assign m name am (x:bv)
  | x /= name && elem x (getFV am) = L new tau (assign (assign m x (V new) bv) name am (new:bv))
  | otherwise = L x tau m
  where
      fresh = filter (\ x -> notElem x (getFV m ++ getFV am)) bound
      new = (filter (\ x -> notElem x bv) fresh) !! 0
assign (T ms)      name am bv = T $ map (\x -> assign x name am bv) ms
assign (P m i)     name am bv = P (assign m name am bv) i
assign (R ms)      name am bv = R (map (\(s,m') -> (s, assign m' name am bv)) ms)
assign (F m s)     name am bv = F (assign m name am bv) s
assign (Inj s m tau) name am bv = Inj s (assign m name am bv) tau
assign (Case m ms) name am bv = Case (assign m name am bv) (map (\(s,m') -> (s, assign m' name am bv)) ms)
assign (TyL t m)   name am bv = TyL t $ assign m name am bv
assign (TyA m t)   name am bv = TyA (assign m name am bv) t
assign e           name am bv = e

getFV :: Expr -> [Id]
getFV (C x tau)     = []
getFV (V x)         = [x]
getFV (A m1 m2)     = getFV m1 ++ getFV m2
getFV (L x tau m)   = filter (/= x) $ getFV m
getFV (T ms)        = concatMap getFV ms
getFV (P m i)       = getFV m
getFV (R ms)        = concatMap (getFV . snd) ms
getFV (F m s)       = getFV m
getFV (Inj s m tau) = getFV m
getFV (Case m ms)   = getFV m ++ concatMap (getFV . snd) ms
getFV (TyL t m)     = getFV m
getFV (TyA m t)     = getFV m
getFV m             = []

-------------------------------------------------------------------------------
-- α-conversion
-------------------------------------------------------------------------------
getAlpha :: Expr -> [Int] -> [Int] -> [Id] -> [String]
getAlpha (C x tau) cPos rPos bv = []
getAlpha (V x)     cPos rPos bv = []
getAlpha (A (L x tau t1) t2) cPos rPos bv =
    if cPos == rPos
        then getA t1 x t2 bv
        else getAlpha (L x tau t1) (cPos ++ [1]) rPos bv ++ getAlpha t2 (cPos ++ [2]) rPos bv
getAlpha (A t1 t2)    cPos rPos bv = getAlpha t1 (cPos ++ [1]) rPos bv ++ getAlpha t2 (cPos ++ [2]) rPos bv
getAlpha (L x tau t)  cPos rPos bv = getAlpha t (cPos ++ [1]) rPos (x:bv)
getAlpha (T ts)       cPos rPos bv = concat [ getAlpha (ts !! (i-1)) (cPos ++ [i]) rPos bv | i <- [1..length ts] ]
getAlpha (P (T ts) i) cPos rPos bv =
    if cPos == rPos
        then []
        else getAlpha (T ts) (cPos ++ [1]) rPos bv
getAlpha (P m i)       cPos rPos bv = getAlpha m (cPos ++ [1]) rPos bv
getAlpha (R ms)        cPos rPos bv =
    if cPos == rPos
        then []
        else concat [ getAlpha (snd (ms !! (i-1))) (cPos ++ [i]) rPos bv | i <- [1..length ms] ]
getAlpha (F m s)       cPos rPos bv = getAlpha m (cPos ++ [1]) rPos bv
getAlpha (Inj s m tau) cPos rPos bv = getAlpha m (cPos ++ [1]) rPos bv
getAlpha (Case m ms)   cPos rPos bv =
    if cPos == rPos
        then []
        else getAlpha m (cPos ++ [1]) rPos bv ++ concat [ getAlpha (snd (ms !! (i-1))) (cPos ++ [2] ++ [i]) rPos bv | i <- [1..length ms] ]
getAlpha t             cPos rPos bv = []

getA :: Expr -> String -> Expr -> [Id] -> [String]
getA (A m1 m2)   name t bv = getA m1 name t bv ++ getA m2 name t bv
getA (L x tau m) name t bv
  | x /= name && notElem x (getFV t) = []
  | x /= name && elem x (getFV t) = [x ++ " -> " ++ new]
  | otherwise = []
  where
      fresh = filter (\ x -> notElem x (getFV m ++ getFV t)) bound
      new = (filter (\ x -> notElem x bv) fresh) !! 0
getA (T ms)        name t bv = concatMap (\x -> getA x name t bv) ms
getA (P m i)       name t bv = getA m name t bv
getA (R ms)        name t bv = concatMap (\(s,m') -> getA m' name t bv) ms
getA (F m s)       name t bv = getA m name t bv
getA (Inj s m tau) name t bv = getA m name t bv
getA (Case m ms)   name t bv = getA m name t bv ++ concatMap (\(s,m') -> getA m' name t bv) ms
getA m             name t bv = []

-------------------------------------------------------------------------------
-- Numbers to Lambda Term
-------------------------------------------------------------------------------
n2l :: Expr -> Expr
n2l (A m1 m2) = A (n2l m1) (n2l m2)
n2l (L x tau m) = L x tau (n2l m)
n2l (T ms) = T (map n2l ms)
n2l (P m i) = P (n2l m) i
n2l (R rs) = R (map (second n2l) rs)
n2l (F m s) = F (n2l m) s
n2l (Inj s m tau) = Inj s (n2l m) tau
n2l (Case m ms) = Case (n2l m) (map (second n2l) ms)
n2l (TyL s m) = TyL s (n2l m)
n2l (TyA m tau) = TyA (n2l m) tau
n2l (N i) = L "f" Unit $ L "x" Unit $ encN i
n2l m = m

encN :: Int -> Expr
encN 0 = V "x"
encN i = A (V "f") (encN (i-1))

succ = parseExp "λn:UNIT.λf:UNIT.λx:UNIT.f (n f x)"

-------------------------------------------------------------------------------
-- Show
-------------------------------------------------------------------------------
showRedexes :: Bool -> Expr -> IO ()
showRedexes isU t = do
    let loop i | i < length redexes = do
            putStrLn $ coloring (Just i) $ show (i + 1) ++ ". " ++ pRCshow isU (redexes !! i)
            loop $ i + 1
        loop _ = return ()
    loop 0
    where
        pos = getRedexPos t []
        redexes = map (head . getExpr t []) pos

-- print redex with color
printWithColor :: Bool -> Expr -> IO ()
printWithColor isU t = putStrLn $ pRC isU t (getRedexPos t []) [] []

pRC :: Bool -> Expr -> Pos -> [Int] -> [Int] -> String
pRC isU (C x tau) pos cPos rPos = coloring (elemIndex rPos pos) $ pRCshow isU (C x tau)
pRC isU (V x)     pos cPos rPos = coloring (elemIndex rPos pos) $ pRCshow isU (V x)
pRC isU (A (L x tau t1) t2) pos cPos rPos = coloring (elemIndex cPos pos) "(" ++ pRC isU (L x tau t1) pos (cPos ++ [1]) cPos ++ coloring (elemIndex cPos pos) ") " ++ exprM2
    where
        exprM2 = case t2 of
                    A m1 m2   -> coloring (elemIndex cPos pos) "(" ++ pRC isU (A m1 m2) pos (cPos ++ [2]) cPos ++ coloring (elemIndex cPos pos) ")"
                    L x tau t -> coloring (elemIndex cPos pos) "(" ++ pRC isU (L x tau t) pos (cPos ++ [2]) cPos ++ coloring (elemIndex cPos pos) ")"
                    TyL t m   -> coloring (elemIndex cPos pos) "(" ++ pRC isU (TyL t m) pos (cPos ++ [2]) cPos ++ coloring (elemIndex cPos pos) ")"
                    m         -> pRC isU m pos (cPos ++ [2]) cPos
pRC isU (A t1 t2) pos cPos rPos = exprL ++ " " ++ exprR
    where
        exprL = case t1 of
                    L x tau t -> coloring (elemIndex rPos pos) "(" ++ pRC isU (L x tau t) pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) ")"
                    TyL t m   -> coloring (elemIndex rPos pos) "(" ++ pRC isU (TyL t m) pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) ")"
                    m         -> pRC isU m pos (cPos ++ [1]) rPos
        exprR = case t2 of
                    A m1 m2   -> coloring (elemIndex rPos pos) "(" ++ pRC isU (A m1 m2) pos (cPos ++ [2]) rPos ++ coloring (elemIndex rPos pos) ")"
                    L x tau t -> coloring (elemIndex rPos pos) "(" ++ pRC isU (L x tau t) pos (cPos ++ [2]) rPos ++ coloring (elemIndex rPos pos) ")"
                    TyL t m   -> coloring (elemIndex rPos pos) "(" ++ pRC isU (TyL t m) pos (cPos ++ [2]) rPos ++ coloring (elemIndex rPos pos) ")"
                    m         -> pRC isU m pos (cPos ++ [2]) rPos
pRC isU (L x tau t) pos cPos rPos = coloring (elemIndex rPos pos) "λ" ++ coloring (elemIndex rPos pos) x ++ (if isU then "" else coloring (elemIndex rPos pos) ":" ++ coloring (elemIndex rPos pos) (show tau)) ++ coloring (elemIndex rPos pos) "." ++ pRC isU t pos (cPos ++ [1]) rPos
pRC isU (T ts)      pos cPos rPos = coloring (elemIndex rPos pos) "(" ++ pRCT ts pos cPos rPos 1 ++ coloring (elemIndex rPos pos) ")"
    where
        pRCT [] pos cPos rPos idx = " **Error: The term's list in this Tuple is empty.** "
        pRCT (t:[]) pos cPos rPos idx = pRC isU t pos (cPos ++ [idx]) rPos
        pRCT (t:ts) pos cPos rPos idx = pRC isU t pos (cPos ++ [idx]) rPos ++ coloring (elemIndex rPos pos) ", " ++ pRCT ts pos cPos rPos (idx + 1)
pRC isU (P (T ts) i)  pos cPos rPos = pRC isU (T ts) pos (cPos ++ [1]) cPos ++ coloring (elemIndex cPos pos) ("." ++ show i)
pRC isU (P m i)       pos cPos rPos = pRC isU m pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) "." ++ coloring (elemIndex rPos pos) (show i)
pRC isU (R ms)        pos cPos rPos = coloring (elemIndex rPos pos) "{" ++ pRCT ms pos cPos rPos 1 ++ coloring (elemIndex rPos pos) "}"
    where
        pRCT [] pos cPos rPos idx = " **Error: The list in the Rec is empty.** "
        pRCT ((s,m):[]) pos cPos rPos idx = coloring (elemIndex rPos pos) (s ++ " = ") ++ pRC isU m pos (cPos ++ [idx]) rPos
        pRCT ((s,m):ms) pos cPos rPos idx = coloring (elemIndex rPos pos) (s ++ " = ") ++ pRC isU m pos (cPos ++ [idx]) rPos ++ coloring (elemIndex rPos pos) ", " ++ pRCT ms pos cPos rPos (idx + 1)
pRC isU (F (R ms) s)  pos cPos rPos = pRC isU (R ms) pos (cPos ++ [1]) cPos ++ coloring (elemIndex cPos pos) ("." ++ s)
pRC isU (F m s)       pos cPos rPos = pRC isU m pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) "." ++ coloring (elemIndex rPos pos) s
pRC isU (Inj s m (Var taus)) pos cPos rPos = coloring (elemIndex rPos pos) ("(<" ++ s ++ " = ") ++ pRC isU m pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) (">:" ++ show (Var taus) ++ ")")
pRC isU (Case (Inj s m t) ms) pos cPos rPos = coloring (elemIndex cPos pos) "case " ++ pRC isU (Inj s m t) pos (cPos ++ [1]) cPos ++ coloring (elemIndex cPos pos) " of " ++ pRCT ms pos (cPos ++ [2]) cPos 1
    where
        pRCT [] pos cPos rPos idx = " **Error: The list in the Case is empty.** "
        pRCT ((s,m):[]) pos cPos rPos idx = coloring (elemIndex rPos pos) (s ++ " => ") ++ pRC isU m pos (cPos ++ [idx]) rPos
        pRCT ((s,m):ms) pos cPos rPos idx = coloring (elemIndex rPos pos) (s ++ " => ")++ pRC isU m pos (cPos ++ [idx]) rPos ++ coloring (elemIndex rPos pos) ", " ++ pRCT ms pos cPos rPos (idx + 1)
pRC isU (Case m ms) pos cPos rPos = coloring (elemIndex rPos pos) "case " ++ pRC isU m pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) " of " ++ pRCT ms pos (cPos ++ [2]) rPos 1
    where
        pRCT [] pos cPos rPos idx = " **Error: The list in the Case is empty.** "
        pRCT ((s,m):[]) pos cPos rPos idx = coloring (elemIndex rPos pos) (s ++ " => ") ++ pRC isU m pos (cPos ++ [idx]) rPos
        pRCT ((s,m):ms) pos cPos rPos idx = coloring (elemIndex rPos pos) (s ++ " => ") ++ pRC isU m pos (cPos ++ [idx]) rPos ++ coloring (elemIndex rPos pos) ", " ++ pRCT ms pos cPos rPos (idx + 1)
pRC isU (TyL t m) pos cPos rPos = coloring (elemIndex rPos pos) ("Λ" ++ t ++ ".") ++ pRC isU m pos (cPos ++ [1]) rPos
pRC isU (TyA (TyL t m) tau) pos cPos rPos = coloring (elemIndex cPos pos) "(" ++ pRC isU (TyL t m) pos (cPos ++ [1]) cPos ++ coloring (elemIndex cPos pos) ")" ++ " " ++ exprR
    where
        exprR = case tau of
                    t1 :=> t2  -> coloring (elemIndex cPos pos) $ "(" ++ showType (t1 :=> t2) ++ ")"
                    Poly t tau -> coloring (elemIndex cPos pos) $ "(" ++ showType (Poly t tau) ++ ")"
                    tau        -> coloring (elemIndex cPos pos) $ showType tau
pRC isU (TyA m tau) pos cPos rPos = exprL ++ " " ++ exprR
    where
        exprL = case m of
                    A m1 m2   -> coloring (elemIndex rPos pos) "(" ++ pRC isU (A m1 m2) pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) ")"
                    L x tau m -> coloring (elemIndex rPos pos) "(" ++ pRC isU (L x tau m) pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) ")"
                    TyL t m   -> coloring (elemIndex rPos pos) "(" ++ pRC isU (TyL t m) pos (cPos ++ [1]) rPos ++ coloring (elemIndex rPos pos) ")"
                    m         -> pRC isU m pos (cPos ++ [1]) rPos
        exprR = case tau of
                    t1 :=> t2  -> coloring (elemIndex rPos pos) $ "(" ++ showType (t1 :=> t2) ++ ")"
                    Poly t tau -> coloring (elemIndex rPos pos) $ "(" ++ showType (Poly t tau) ++ ")"
                    tau        -> coloring (elemIndex rPos pos) $ showType tau
pRC isU m pos cPos rPos = coloring (elemIndex rPos pos) $ pRCshow isU m

pRCshow :: Bool -> Expr -> String
pRCshow isU m = if isU then showTerm m else show m

-------------------------------------------------------------------------------
-- Position
-------------------------------------------------------------------------------
pos :: Expr -> Pos
pos (C x tau)     = [ [] ]
pos (V x)         = [ [] ]
pos (A m1 m2)     = [] : [ 1 : ps | ps <- pos m1] ++ [ 2 : ps | ps <- pos m2]
pos (L x tau m)   = [] : [ 1 : ps | ps <- pos m]
pos (T ms)        = [] : [ i : ps | i <- [1..length ms], ps <- pos (ms !! (i-1))]
pos (P m i)       = [] : [ 1 : ps | ps <- pos m]
pos (R ms)        = [] : [ i : ps | i <- [1..length ms], ps <- pos (snd (ms !! (i-1)))]
pos (F m s)       = [] : [ 1 : ps | ps <- pos m]
pos (Inj s m tau) = [] : [ 1 : ps | ps <- pos m]
pos (Case m ms)   = [] : [ 1 : ps | ps <- pos m] ++ [ 2 : i : ps | i <- [1..length ms], ps <- pos (snd (ms !! (i-1)))]
pos (TyL t m)     = [] : [ 1 : ps | ps <- pos m]
pos (TyA m tau)   = [] : [ 1 : ps | ps <- pos m]
pos t             = [ [] ]

getExpr :: Expr -> [Int] -> [Int] -> [Expr]
getExpr (A t1 t2)     cPos target = targetPos cPos target (A t1 t2) (getExpr t1 (cPos ++ [1]) target ++ getExpr t2 (cPos ++ [2]) target)
getExpr (L x tau m)   cPos target = targetPos cPos target (L x tau m) (getExpr m (cPos ++ [1]) target)
getExpr (T ms)        cPos target = targetPos cPos target (T ms) (concat [ getExpr (ms !! (i-1)) (cPos ++ [i]) target | i <- [1..length ms] ])
getExpr (P m i)       cPos target = targetPos cPos target (P m i) (getExpr m (cPos ++ [1]) target)
getExpr (R ms)        cPos target = targetPos cPos target (R ms) (concat [ getExpr (snd (ms !! (i-1))) (cPos ++ [i]) target | i <- [1..length ms] ])
getExpr (F m s)       cPos target = targetPos cPos target (F m s) (getExpr m (cPos ++ [1]) target)
getExpr (Inj s m tau) cPos target = targetPos cPos target (Inj s m tau) (getExpr m (cPos ++ [1]) target)
getExpr (Case m ms)   cPos target = targetPos cPos target (Case m ms) (getExpr m (cPos ++ [1]) target ++ concat [ getExpr (snd (ms !! (i-1))) (cPos ++ [2] ++ [i]) target | i <- [1..length ms] ])
getExpr (TyL t m)     cPos target = targetPos cPos target (TyL t m) (getExpr m (cPos ++ [1]) target)
getExpr (TyA m t)     cPos target = targetPos cPos target (TyA m t) (getExpr m (cPos ++ [1]) target)
getExpr m             cPos target = targetPos cPos target m []

targetPos cPos target t ts = if cPos == target then [t] else ts

getRedexPos :: Expr -> [Int] -> Pos
getRedexPos (A (L x tau t1) t2) cPos = cPos : getRedexPos (L x tau t1) (cPos ++ [1]) ++ getRedexPos t2 (cPos ++ [2])
getRedexPos (A t1 t2)     cPos = getRedexPos t1 (cPos ++ [1]) ++ getRedexPos t2 (cPos ++ [2])
getRedexPos (L x tau m)   cPos = getRedexPos m (cPos ++ [1])
getRedexPos (T ms)        cPos = concat [ getRedexPos (ms !! (i-1)) (cPos ++ [i]) | i <- [1..length ms] ]
getRedexPos (P (T ms) i)  cPos = cPos : getRedexPos (T ms) (cPos ++ [1])
getRedexPos (P m i)       cPos = getRedexPos m (cPos ++ [1])
getRedexPos (R ms)        cPos = concat [ getRedexPos (snd (ms !! (i-1))) (cPos ++ [i]) | i <- [1..length ms] ]
getRedexPos (F (R ms) s)  cPos = cPos : getRedexPos (R ms) (cPos ++ [1])
getRedexPos (F m s)       cPos = getRedexPos m (cPos ++ [1])
getRedexPos (Inj s m tau) cPos = getRedexPos m (cPos ++ [1])
getRedexPos (Case (Inj s m tau) ms) cPos = cPos : getRedexPos (Inj s m tau) (cPos ++ [1]) ++ concat [ getRedexPos (snd (ms !! (i-1))) (cPos ++ [2] ++ [i]) | i <- [1..length ms] ]
getRedexPos (Case m ms) cPos = getRedexPos m (cPos ++ [1]) ++ concat [ getRedexPos (snd (ms !! (i-1))) (cPos ++ [2] ++ [i]) | i <- [1..length ms] ]
getRedexPos (TyL t m)   cPos = getRedexPos m (cPos ++ [1])
getRedexPos (TyA (TyL t m) tau) cPos = cPos : getRedexPos (TyL t m) (cPos ++ [1])
getRedexPos (TyA m tau) cPos = getRedexPos m (cPos ++ [1])
getRedexPos m cPos = []
