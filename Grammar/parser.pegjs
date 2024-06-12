Init
  = _ Section* _

Section
  = "." "global"i _ Label _ StatementBlock* _
  / "." ("data"i / "bss"i / "rodata"i) _ VariableBlock* _

StatementBlock
  = Label _ ":" _ Statement* _

Statement
  = Instruction _ Value ( _ "," _ Value _)* _
  / "ret"i

Instruction
  = "ldrb"i
  / "ldr"i
  / "ldp"i
  / "strb"i
  / "str"i
  / "stp"i
  / "mov"i
  / "fmov"i
  / "svc"i
  / "mrs"i
  / "msr"i
  / "psp"i
  / "cmp"i
  / "bne"i
  / "beq"i
  / "bgt"i
  / "blt"i
  / "bl"i
  / "b"i
  / "add"i
  / "sub"i
  / "mul"i
  / "udiv"i
  / "sdiv"i
  / "and"i
  / "orr"i
  / "eor"i
  / "mvn"i
  / "lsl"i
  / "lsr"i
  
dataType
  = "word"i
  / "ascii"i
  / "asciz"i
  / "space"i
  / "half"i
  / "byte"i
  / "skip"i
  / "float"i
  
VariableBlock
  = Variable ":" _ "." (dataType) _ Value _
  
Value
  = Character
  / HexNumber
  / Record
  / "[" Record "]"
  / Number
  / "SP"
  / "[" "SP" "]"
  / Label
  / CallVariable
  / stringValue

Whitespace
  = [ \t\n\r]+

SingleLineComment = "//" (![\r\n] .)*

MultiLineComment = "/" (!"/" .)* "*/"

_
  = (Whitespace / SingleLineComment / MultiLineComment )*

Label = [_a-zA-Z]+
Character = "#" "'" [a-zA-Z] "'"
Number = "#"?  [0-9]+ ("." [0-9]+)?
HexNumber = "#" [0-9a-f]i+
Record = ( "x"i / "w"i ) [0-9]+
stringValue = "\"" [^\"]* "\""
Variable = [_a-zA-Z]+
CallVariable = "=" [_a-zA-Z]+