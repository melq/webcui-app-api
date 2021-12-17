{
module Parser where
import Lexer
import DataType
}

%name happyParseExp exp
%name happyParseTypeContext typeContext
%name happyParseEnv env
%name happyParseTerm term

%tokentype { Token }
%error { parseError }

%token
'('     { LPar }
')'     { RPar }
'['     { LSBracket }
']'     { RSBracket }
'{'     { LBrace }
'}'     { RBrace }

'.'     { TDot }
','     { TCom }
'λ'     { TLam }
'Λ'     { TLLam }
':'     { TCol }
'->'    { TArrow }
'=>'    { TLArrow }
'+'     { TPlus }
'-'     { TMinus }
'∀'    { TAll }

INT     { TINT }
BOOL    { TBOOL }

UNIT    { TUNIT }

'case'  { TCase }
'<'     { LAngle }
'>'     { RAngle }
'='     { TEqual }
'of'    { TOf }

'Empty' { Empty }

'succ'  { TSucc }
'pred'  { TPred }
'true'  { TTrue }
'false' { TFalse }

NUM     { Num $$ }
ID      { ID $$ }
TyID    { TyID $$ }

%nonassoc ID NUM '(' '{' 'λ' 'Λ' 'case'
%nonassoc APP

%%
Start:  exp		{ $1 }

-- exp

exps:   exp             { [$1] }
 |      exp ',' exps    { $1 : $3 }

recExps: ID '=' exp               { [($1, $3)] }
 |       ID '=' exp ',' recExps   { ($1, $3) : $5 }

caseExps: ID '=>' exp               { [($1, $3)] }
 |        ID '=>' exp ',' caseExps  { ($1, $3) : $5 }

inj:    '(' '<' ID '=' exp '>' ':' type ')'  { Inj $3 $5 $8 }

exp:    '(' ')'                       { U }
 |      '(' exp ')'                   { $2 }
 |      ID ':' type                   { C $1 $3 }
 |      ID ':' ID                     { C $1 (TyVar $3) }
 |      ID                            { V $1 }
 |      NUM                           { N $1 }
 |      'λ' ID ':' type '.' exp       { L $2 $4 $6 }
 |      '(' exp ',' exps ')'          { T ($2 : $4) }
 |      exp '.' NUM                   { P $1 $3 }
 |      exp exp %prec APP             { A $1 $2 }
 |      '{' recExps '}'               { R $2 }
 |      exp '.' ID                    { F $1 $3 }
 |      inj                           { $1 }
 |      'case' exp 'of' caseExps      { Case $2 $4 }
 |      'Λ' TyID '.' exp              { TyL $2 $4 }
 |      exp type                      { TyA $1 $2 }
 |      'succ'                        { TyL "T1" (TyL "T2" (TyL "T3" (L "n" (((TyVar "T1") :=> (TyVar "T2")) :=> ((TyVar "T3") :=> (TyVar "T1"))) (L "f" ((TyVar "T1") :=> (TyVar "T2")) (L "x" (TyVar "T3") (A (V "f") (A (A (V "n") (V "f")) (V "x")))))))) }

-- type

prod:   type            { [$1] }
 |      type ',' prod   { $1 : $3 }

sum:    ID ':' type            { [($1, $3)] }
 |      ID ':' type ',' sum    { ($1, $3) : $5 }

type:   '(' type ')'           { $2 }
 |      INT                    { INT }
 |      BOOL                   { BOOL }
 |      TyID                   { TyVar $1 }
 |      type '->' type         { $1 :=> $3 }
 |      '(' type ',' prod ')'  { Prod ($2 : $4) }
 |      '{' sum '}'            { Rec $2 }
 |      '<' sum '>'            { Var $2 }
 |      '∀' TyID '.' type     { Poly $2 $4 }
 |      UNIT                   { Unit }

-- type context

typeContext:
    TyID                  { [$1] }
 |  TyID ',' typeContext  { $1 : $3 }
 |  'Empty'               { [] }

-- term context

env:    decl            { [$1] }
 |      decl ',' env    { $1 : $3 }
 |      'Empty'         { [] }

decl:   ID ':' type     { ($1,$3) }

-- term

terms:  term             { [$1] }
 |      term ',' terms   { $1 : $3 }

recTerms: ID '=' term                { [($1, $3)] }
 |        ID '=' term ',' recTerms   { ($1, $3) : $5 }

caseTerms: ID '=>' term                { [($1, $3)] }
 |         ID '=>' term ',' caseTerms  { ($1, $3) : $5 }

term:   '(' ')'                     { U }
 |      '(' term ')'                { $2 }
 |      ID                          { V $1 }
 |      NUM                         { N $1 }
 |      'λ' ID '.' term             { L $2 Unit $4 }
 |      '(' term ',' terms ')'      { T ($2 : $4) }
 |      term '.' NUM                { P $1 $3 }
 |      term term %prec APP         { A $1 $2 }
 |      '{' recTerms '}'            { R $2 }
 |      term '.' ID                 { F $1 $3 }
 |      '(' '<' ID '=' term '>' ')' { Inj $3 $5 Unit }
 |      'case' term 'of' caseTerms  { Case $2 $4 }
 |      'succ'                      { L "n" Unit (L "f" Unit (L "x" Unit (A (V "f") (A (A (V "n") (V "f")) (V "x"))))) }
 |      'pred'                      { L "n" Unit (L "f" Unit (L "x" Unit (A (A (A (V "n") (L "g" Unit (L "h" Unit (A (V "h") (A (V "g") (V "f")))))) (L "u" Unit (V "x"))) (L "u" Unit (V "u"))))) }
 |      term '+' term               { A (A (L "m" Unit (L "n" Unit (A (A (V "m") (L "n" Unit (L "f" Unit (L "x" Unit (A (V "f") (A (A (V "n") (V "f")) (V "x"))))))) (V "n")))) $1) $3 }
 |      term '-' term               { A (A (L "m" Unit (L "n" Unit (A (A (V "n") ((L "n" Unit (L "f" Unit (L "x" Unit (A (A (A (V "n") (L "g" Unit (L "h" Unit (A (V "h") (A (V "g") (V "f")))))) (L "u" Unit (V "x"))) (L "u" Unit (V "u")))))))) (V "m")))) $1) $3 }
 |      'true'                      { (L "x" Unit (L "y" Unit (V "x"))) }
 |      'false'                     { (L "x" Unit (L "y" Unit (V "y"))) }

{
parseError :: [Token] -> a
parseError [] = error "Parse error at EOF"
parseError (t:ts) = error $ "Parse error: " ++ show t

parseExp         = happyParseExp . alexScanTokens
parseTypeContext = happyParseTypeContext . alexScanTokens
parseEnv         = happyParseEnv . alexScanTokens
parseTerm        = happyParseTerm . alexScanTokens
}
