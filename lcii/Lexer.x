{
module Lexer where
}

%wrapper "posn"
$digit = [0-9]
$alpha = [a-zA-Z]
$lower = [a-z]
$upper = [A-Z]
$newline = [\n\r]

tokens :-

$white+			    ;

"("             { \pos _ -> LPar }
")"             { \pos _ -> RPar }
"["             { \pos _ -> LSBracket }
"]"             { \pos _ -> RSBracket }
"{"             { \pos _ -> LBrace }
"}"             { \pos _ -> RBrace }

"."             { \pos _ -> TDot }
","             { \pos _ -> TCom }
":"             { \pos _ -> TCol }
"->"            { \pos _ -> TArrow }
"=>"            { \pos _ -> TLArrow }
"+"             { \pos _ -> TPlus }
"-"             { \pos _ -> TMinus }
"∀"            { \pos _ -> TAll }

"INT"           { \pos _ -> TINT }
"int"           { \pos _ -> TINT }
"BOOL"          { \pos _ -> TBOOL }
"bool"          { \pos _ -> TBOOL }

"UNIT"          { \pos _ -> TUNIT }
"unit"          { \pos _ -> TUNIT }

"case"          { \pos _ -> TCase }
"<"             { \pos _ -> LAngle }
">"             { \pos _ -> RAngle }
"="             { \pos _ -> TEqual }
"of"            { \pos _ -> TOf }

"Empty"         { \pos _ -> Empty }

"succ"          { \pos _ -> TSucc }
"pred"          { \pos _ -> TPred }
"true"          { \pos _ -> TTrue }
"false"         { \pos _ -> TFalse }

[\λ \\]         { \pos _ -> TLam }
[\Λ \&]         { \pos _ -> TLLam }

$digit+         { \pos s -> Num (read s) }

[$lower \_ \- \%] [$alpha $digit \_ \^ \' \* ! \% \/]* 	{ \pos s -> ID s }
[$upper \_ \- \%] [$alpha $digit \_ \^ \' \* ! \% \/]* 	{ \pos s -> TyID s }

{
data Token = LPar | RPar | LSBracket | RSBracket | LBrace | RBrace
     | Empty | TPlus | TMinus | TLLam
     | TINT | TBOOL | TUNIT | TAll
     | TLam | TDot | TCom | TCol | TArrow | TLArrow
     | TCase | LAngle | RAngle | TEqual | TOf
     | Num Int | ID String | TyID String
     | TSucc | TPred | TTrue | TFalse
     deriving (Show,Eq)

prettyAlexPosn (AlexPn _ line col) = 
  "at line " ++ show line ++ ", col " ++ show col
}