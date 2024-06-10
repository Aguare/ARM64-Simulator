Init
  = _ Body _
  
Body
  = dot globalToken _ Label _ Section* _

Section
  = dot sectionToken _ dot textToken _ StatementBlock* _
  / dot sectionToken _ dot dataToken _ VariableBlock* _
  / dot sectionToken _ dot roDataToken _ ReadOnlyBlock* _

StatementBlock
  = Label _ colon _ Statement* _

Statement
  = Instruction _ Value ( _ comma _ Value _)* _
  / retToken

Instruction
  = ldrbToken
  / ldrToken
  / ldpToken
  / strbToken
  / strToken
  / stpToken
  / movToken
  / fmovToken
  / svcToken
  / mrsToken
  / msrToken
  / pspToken
  / cmpToken
  / beqToken
  / bgtToken
  / bltToken
  / blToken
  / bToken
  / addToken
  / subToken
  / mulToken
  / udivToken
  / sdivToken
  / andToken
  / orrToken
  / eorToken
  / mvnToken
  / lslToken
  / lsrToken
  
VariableBlock
  = Variable colon _ dot (wordToken / asciiToken / ascizToken) _ Value _
 
ReadOnlyBlock
  = Label colon _ dot ( asciiToken / ascizToken / stringToken) _ stringValue _
  
Value
  = HexNumber
  / Record
  / Number
  / Label
  / CallVariable
  / stringValue

Whitespace
  = [ \t\n\r]+

Comment = ( "//" / ";" ) (![\r\n] .)*

_
  = (Whitespace / Comment )*

// TOKENS
colon		= ":"
comma		= ","
dot			= "."
ldrToken	= "ldr"i
ldrbToken	= "ldrb"i
ldpToken	= "ldp"i
strToken	= "str"i
strbToken	= "strb"i
stpToken	= "stp"i
movToken	= "mov"i
fmovToken	= "fmov"i
retToken	= "ret"i
svcToken	= "svc"i
globalToken	= "global"i
sectionToken	= "section"i
dataToken	= "data"i
roDataToken	= "rodata"i
textToken	= "text"i
wordToken	= "word"i
asciiToken	= "ascii"i
ascizToken	= "asciz"i
stringToken	= "string"i
mrsToken	= "mrs"i
pspToken	= "psp"i
msrToken	= "msr"i
cmpToken	= "cmp"i
bToken		= "b"i
blToken		= "bl"i
beqToken	= "beq"i
bneToken	= "bne"i
bgtToken	= "bgt"i
bltToken	= "blt"i
addToken	= "add"i
subToken	= "sub"i
mulToken	= "mul"i
udivToken	= "udiv"i
sdivToken	= "sdiv"i
andToken	= "and"i
orrToken	= "orr"i
eorToken	= "eor"i
mvnToken	= "mvn"i
lslToken	= "lsl"i
lsrToken	= "lsr"i

Label = [_a-zA-Z]+
Number = "#" [0-9]+ (dot [0-9]+)?
HexNumber = "#" [0-9a-f]i+
Record = (( "x"i / "d"i ) [0-9]+ / "[" ( "x" / "d" ) [0-9]+ "]")
stringValue = "\"" [^\"]* "\""
Variable = [_a-zA-Z]+
CallVariable = "=" [_a-zA-Z]+
