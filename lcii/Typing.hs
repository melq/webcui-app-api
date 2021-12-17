module Typing where
import DataType

-------------------------------------------------------------------------------
-- Typing
-------------------------------------------------------------------------------
typing :: [String] -> [Decl] -> Expr -> Type
typing xi ga m = let tau = typing' xi ga m
                   in if typeTyping xi tau then tau else Failure

-- TyL "T1" (TyL "T2" (TyL "T3" (L "n" (((TyVar "T1") :=> (TyVar "T2")) :=> ((TyVar "T3") :=> (TyVar "T1"))) (L "f" ((TyVar "T1") :=> (TyVar "T2")) (L "x" (TyVar "T3") (A (V "f") (A (A (V "n") (V "f")) (V "x"))))))))

typing' :: [String] -> [Decl] -> Expr -> Type
typing' xi ga U         = Unit
typing' xi ga (C c tau) = tau
typing' xi ga (V x)     = if elem x (dom ga) then lkup ga x
                                             else Failure

typing' xi ga (L x tau1 m) = let tau2 = typing' xi ((x,tau1):ga) m
                              in tau1 :=> tau2

typing' xi ga (A m1 m2) = let tau1 = typing' xi ga m1
                              tau2 = typing' xi ga m2
                            in if isArrowType tau1 && source tau1 == tau2
                               then target tau1 else Failure

typing' xi ga (T ms) = let taus = map (typing' xi ga) ms
                        in Prod taus

typing' xi ga (P m i) = let tau = typing' xi ga m
                         in if isProdType tau
                         then (prodTypes tau)!!(i-1)
                         else Failure

typing' xi ga (R ms) = let taus = map (\(s,m) -> (s, typing' xi ga m)) ms
                        in Rec taus

typing' xi ga (F m s) = let tau = typing' xi ga m
                        in if isRecType tau
                           then caseTypeFind (recList tau) s else Failure

typing' xi ga (Inj s m t) = let tau = typing' xi ga m
                            in case t of
                              Var taus -> if tau == caseTypeFind taus s
                                            then Var taus else Failure
                              t' -> Failure

typing' xi ga (Case m ms) = let tau = typing' xi ga m
                            in if isVarType tau
                               then caseType xi ga ms (varList tau) (target (typing' xi ga (snd (ms !! 0)))) else Failure

typing' xi ga (TyL a m) = let tau = typing' (a:xi) ga m
                           in Poly a tau

typing' xi ga (TyA m sig) = let tau = typing' xi ga m
                             in if isPolyType tau && typeTyping xi sig
                                then tyAssign (polyTau tau) (polyTV tau) sig xi
                                else Failure

typeTyping :: [String] -> Type -> Bool
typeTyping xi (tau1 :=> tau2) = typeTyping xi tau1 && typeTyping xi tau2
typeTyping xi (Prod taus)     = all (typeTyping xi) taus
typeTyping xi (Rec taus)      = all (typeTyping xi . snd) taus
typeTyping xi (Var taus)      = all (typeTyping xi . snd) taus
typeTyping xi (TyVar a)       = elem a xi
typeTyping xi (Poly a tau)    = typeTyping (a:xi) tau
typeTyping xi tau             = True

-------------------------------------------------------------------------------
-- For Polymorphic Type
-------------------------------------------------------------------------------
-- ここでのbvは型変数のbv(getFTVが初期値)
tySubst :: Expr -> String -> Type -> [String] -> Expr
tySubst (C x tau)     name tau' bv = C x (tyAssign tau name tau' bv)
tySubst (A m1 m2)     name tau' bv = A (tySubst m1 name tau' bv) (tySubst m2 name tau' bv)
tySubst (L x tau m)   name tau' bv = L x (tyAssign tau name tau' bv) (tySubst m name tau' bv)
tySubst (T ms)        name tau' bv = T $ map (\m -> tySubst m name tau' bv) ms
tySubst (P m i)       name tau' bv = P (tySubst m name tau' bv) i
tySubst (R rs)        name tau' bv = R $ map (\(l,m) -> (l,tySubst m name tau' bv)) rs
tySubst (F m l)       name tau' bv = F (tySubst m name tau' bv) l
tySubst (Inj l m tau) name tau' bv = Inj l (tySubst m name tau' bv) (tyAssign tau name tau' bv)
tySubst (Case m rs)   name tau' bv = Case (tySubst m name tau' bv) $ map (\(l,m) -> (l,tySubst m name tau' bv)) rs
tySubst (TyL t m)     name tau' bv = TyL t (tySubst m name tau' (t:bv))
tySubst (TyA m tau)   name tau' bv = TyA (tySubst m name tau' bv) (tyAssign tau name tau' bv)
tySubst m             name tau' bv = m

tyAssign :: Type -> String -> Type -> [String] -> Type
tyAssign (TyVar x)    name tau' bv = if x == name then tau' else TyVar x
tyAssign (Poly x tau) name tau' bv
  | x /= name && notElem x (getFTV tau') = Poly x $ tyAssign tau name tau' (x:bv)
  | x /= name && elem x (getFTV tau') = Poly new $ tyAssign (tyAssign tau x (TyVar new) bv) name tau' (new:bv)
  | otherwise = Poly x tau
  where
      fresh
        = filter (\ x -> notElem x (getFTV tau ++ getFTV tau')) tyBound
      new = (filter (\ x -> notElem x bv) fresh) !! 0
tyAssign (tau1 :=> tau2) name tau' bv = (tyAssign tau1 name tau' bv) :=> (tyAssign tau2 name tau' bv)
tyAssign (Prod taus) name tau' bv = Prod (map (\x -> tyAssign x name tau' bv) taus)
tyAssign (Rec taus) name tau' bv = Rec (map (\(s,x) -> (s,tyAssign x name tau' bv)) taus)
tyAssign (Var taus) name tau' bv = Var (map (\(s,x) -> (s,tyAssign x name tau' bv)) taus)
tyAssign tau name tau' bv = tau

getFTV :: Type -> [Id]
getFTV (TyVar tau)     = [tau]
getFTV (tau1 :=> tau2) = getFTV tau1 ++ getFTV tau2
getFTV (Poly t s)      = filter (/= t) $ getFTV s
getFTV tau             = []

-------------------------------------------------------------------------------
-- Check Typing Error
-------------------------------------------------------------------------------
hasFailure :: Type -> Bool
hasFailure (tau1 :=> tau2) = hasFailure tau1 || hasFailure tau2
hasFailure (Prod taus)     = any hasFailure taus
hasFailure (Rec taus)      = any (\(s,t) -> hasFailure t) taus
hasFailure (Var taus)      = any (\(s,t) -> hasFailure t) taus
hasFailure (Poly s tau)    = hasFailure tau
hasFailure Failure         = True
hasFailure _               = False

-------------------------------------------------------------------------------
-- Utility
-------------------------------------------------------------------------------
dom :: [Decl] -> [Id]
dom = map fst

lkup :: [Decl] -> Id -> Type
lkup []           x = Failure
lkup ((y,tau):ga) x = if y == x then tau else lkup ga x

isArrowType (tau1 :=> tau2) = True
isArrowType tau             = False

source (tau1 :=> tau2) = tau1

target (tau1 :=> tau2) = tau2

isProdType (Prod taus)      = True
isProdType tau              = False

prodTypes (Prod taus) = taus

isVarType (Var taus) = True
isVarType tau        = False

isRecType (Rec taus) = True
isRecType tau        = False

varList (Var taus) = taus

recList (Rec taus) = taus

isPolyType (Poly a tau) = True
isPolyType tau          = False

polyTV (Poly a tau) = a
polyTau (Poly a tau) = tau

caseType :: [String] -> [Decl] -> [(String, Expr)] -> [(String, Type)] -> Type -> Type
caseType xi ga [] [] res   = res
caseType xi ga [] taus res = Failure
caseType xi ga ms [] res   = Failure
caseType xi ga ((s, m):ms) ((s',tau):taus) res =
   if source (typing' xi ga m) == tau && target (typing' xi ga m) == res
      then caseType xi ga ms taus res
      else Failure

caseTypeFind :: [(String, Type)] -> String -> Type
caseTypeFind ((s, t):[]) s' = if s == s' then t else Failure
caseTypeFind ((s, t):ss) s' = if s == s' then t else caseTypeFind ss s'