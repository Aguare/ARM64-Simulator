/* 
    Description: This file contains the Quadruple and Operator classes
    that are used to represent the quadruples and operators in the
    intermediate code.
*/
class Quadruple{
    constructor(op, op1, op2, op3, result){
        this.op = op;
        this.op1 = op1;
        this.op2 = op2;
        this.op3 = op3;
        this.result = result;
    }
    setOp(op){
        this.op = op;
    }
    setOp1(op1){
        this.op1 = op1;
    }
    setOp2(op2){
        this.op2 = op2;
    }
    setOp3(op3){
        this.op3 = op3;
    }
    setResult(result){
        this.result = result;
    }
    getOp(){
        return this.op;
    }
    getOp1(){
        return this.op1;
    }
    getOp2(){
        return this.op2;
    }
    getOp3(){
        return this.op3;
    }
    getResult(){
        return this.result;
    }
    // Get the dot representation of the quadruple in Graphviz dot language
    getDot(){
        return `<td>${this.op.getOperator().toString().toUpperCase()}</td>\n<td>${this.op1}</td>\n<td>${this.op2}</td>\n<td>${this.op3}</td>\n<td>${this.result}</td></tr>\n`;
    }
    toString(){
        return `${this.op} ${this.op1} ${this.op2} ${this.op3} ${this.op4} ${this.result}`;
    
    }

}

class Operator{
    constructor(operator, cc, q){
        this.operator = operator;
        this.cc = cc;
        this.q = q;
    }
    setOperator(operator){
        this.operator = operator;
    }
    setCC(cc){
        this.cc = cc;
    }
    setQ(q){
        this.q = q;
    }
    getOperator(){
        return this.operator;
    }
    getCC(){
        return this.cc;
    }
    getQ(){
        return this.q;
    }
}




// Function to check if a value is equal to any of the types
function equalType(value, ...types){
    return types.some(type => type === value);
}


// Function to convert a CST to a Q by recursively traversing a list with Instructions
function CSTtoQ(insNodes){
    // The table that will store the quadruples
    let table = [];
    // First we traverse the list of instructions, creating a quadruple for each one
    for (let i = 0; i < insNodes.length; i++){
        // Create the new quadruple and operator
        let newOperator;
        let newQuadruple = new Quadruple();

        let ins = insNodes[i];
        let op = ins.getChildren()[0];
        //Check if there are arguments
        let args;
        if (ins.getChildren().length == 1){
            args = null
        } else {
            args = ins.getChildren()[1];
        }
        // Check the operator node if has cc and q
        if(op.getChildren().length == 3){
            let operator = op.getChildren()[0].getValue();
            let cc = op.getChildren()[1].getValue();
            let q = op.getChildren()[2].getValue();
            newOperator = new Operator(operator, cc, q);
        } else if(op.getChildren().length == 2){
            let operator = op.getChildren()[0].getValue();
            let cc = op.getChildren()[1].getValue();
            let q = '';
            newOperator = new Operator(operator, cc, q);
        } else {
            let operator = op.getChildren()[0].getValue();
            let cc = '';
            let q = '';
            newOperator = new Operator(operator, cc, q);
        }
        // Set the operator to the quadruple
        newQuadruple.setOp(newOperator);
        let temp = 1;
        // Check the arguments node, if there are no arguments, set the quadruple with '--'
        if (args == null){
            newQuadruple.setResult('--');
            newQuadruple.setOp1('--');
            newQuadruple.setOp2('--');
            newQuadruple.setOp3('--');
            table.push(newQuadruple);
        } else{
            // Check the number of arguments, and set the quadruple with the corresponding values

            // If there is only one argument, the value is set as the result, and the rest of the quadruple is set as '--'
            if (args.getChildren().length == 1){
                let arg = args.getChildren()[0];
                newQuadruple.setResult(returnValue(arg, table, temp));
                newQuadruple.setOp1('--');
                newQuadruple.setOp2('--');
                newQuadruple.setOp3('--');
                table.push(newQuadruple);
            } else if (args.getChildren().length == 2){
                let arg1 = args.getChildren()[0];
                let arg2 = args.getChildren()[1];
                newQuadruple.setResult(returnValue(arg1, table, temp));
                newQuadruple.setOp1(returnValue(arg2, table, temp));
                newQuadruple.setOp2('--');
                newQuadruple.setOp3('--');
                table.push(newQuadruple);
            } else if (args.getChildren().length == 3){
                let arg1 = args.getChildren()[0];
                let arg2 = args.getChildren()[1];
                let arg3 = args.getChildren()[2];
                newQuadruple.setResult(returnValue(arg1, table, temp));
                newQuadruple.setOp1(returnValue(arg2, table, temp));
                newQuadruple.setOp2(returnValue(arg3, table, temp));
                newQuadruple.setOp3('--');
                table.push(newQuadruple);
            } else if (args.getChildren().length == 4){
                let arg1 = args.getChildren()[0];
                let arg2 = args.getChildren()[1];
                let arg3 = args.getChildren()[2];
                let arg4 = args.getChildren()[3];
                newQuadruple.setResult(returnValue(arg1, table, temp));
                newQuadruple.setOp1(returnValue(arg2, table, temp));
                newQuadruple.setOp2(returnValue(arg3, table, temp));
                newQuadruple.setOp3(returnValue(arg4, table, temp));
                table.push(newQuadruple);
            } else if (args.getChildren().length == 5){
                let arg1 = args.getChildren()[0];
                let arg2 = args.getChildren()[1];
                let arg3 = args.getChildren()[2];
                let arg4 = args.getChildren()[3];
                let arg5 = args.getChildren()[4];
                newQuadruple.setResult(returnValue(arg1, table, temp));
                newQuadruple.setOp1(returnValue(arg2, table, temp));
                newQuadruple.setOp2(returnValue(arg3, table, temp));
                newQuadruple.setOp3(returnValue(arg4, table, temp));
                table.push(newQuadruple);
            }
        }
    }
    return table;
}


// Function to convert a CST to a Q by recursively traversing a list with Instructions
function QDOT(insNodes){
    // The table that will store the quadruples
    let dot = 'digraph G {\n    label=<\n       <table border="1" cellborder="1" cellspacing="0" cellpadding="4" style="font-size:14px;">\n';
    let row = 0;
    // First we traverse the list of instructions, creating a quadruple for each one
    for (let i = 0; i < insNodes.length; i++){
        if(insNodes[i].type === TYPE.LABEL){
            dot += `<tr><td bgcolor="lightblue" colspan="6"><b>${insNodes[i].getValue()}</b></td></tr>\n`;
            dot += '<tr><td bgcolor=\"lightgray\">#</td>\n<td bgcolor=\"lightgray\">OP</td>\n<td bgcolor=\"lightgray\">ARG1</td>\n<td bgcolor=\"lightgray\">ARG2</td>\n<td bgcolor=\"lightgray\">ARG3</td>\n<td bgcolor=\"lightgray\">RESULT</td></tr>\n'
        } else{
            // Create the new quadruple and operator
            let newOperator;
            let newQuadruple = new Quadruple();

            let ins = insNodes[i];
            let op = ins.getChildren()[0];
            //Check if there are arguments
            let args;
            if (ins.getChildren().length == 1){
                args = null
            } else {
                args = ins.getChildren()[1];
            }
            // Check the operator node if has cc and q
            if(op.getChildren().length == 3){
                let operator = op.getChildren()[0].getValue();
                let cc = op.getChildren()[1].getValue();
                let q = op.getChildren()[2].getValue();
                newOperator = new Operator(operator, cc, q);
            } else if(op.getChildren().length == 2){
                let operator = op.getChildren()[0].getValue();
                let cc = op.getChildren()[1].getValue();
                let q = '';
                newOperator = new Operator(operator, cc, q);
            } else {
                let operator = op.getChildren()[0].getValue();
                let cc = '';
                let q = '';
                newOperator = new Operator(operator, cc, q);
            }
            // Set the operator to the quadruple
            newQuadruple.setOp(newOperator);
            let temp = 1;
            // Check the arguments node, if there are no arguments, set the quadruple with '--'
            if (args == null){
                newQuadruple.setResult('--');
                newQuadruple.setOp1('--');
                newQuadruple.setOp2('--');
                newQuadruple.setOp3('--');
                dot += `<tr><td bgcolor="lightblue"><b>${row+1}</b></td>\n` + newQuadruple.getDot();
            } else{
                // Check the number of arguments, and set the quadruple with the corresponding values

                // If there is only one argument, the value is set as the result, and the rest of the quadruple is set as '--'
                if (args.getChildren().length == 1){
                    let arg = args.getChildren()[0];
                    newQuadruple.setResult(returnValue(arg, dot, temp));
                    newQuadruple.setOp1('--');
                    newQuadruple.setOp2('--');
                    newQuadruple.setOp3('--');
                    dot += `<tr><td bgcolor="lightblue"><b>${row+1}</b></td>\n` + newQuadruple.getDot();
                } else if (args.getChildren().length == 2){
                    let arg1 = args.getChildren()[0];
                    let arg2 = args.getChildren()[1];
                    newQuadruple.setResult(returnValueDOT(arg1, dot, temp));
                    newQuadruple.setOp1(returnValueDOT(arg2, dot, temp));
                    newQuadruple.setOp2('--');
                    newQuadruple.setOp3('--');
                    dot += `<tr><td bgcolor="lightblue"><b>${row+1}</b></td>\n` + newQuadruple.getDot();
                } else if (args.getChildren().length == 3){
                    let arg1 = args.getChildren()[0];
                    let arg2 = args.getChildren()[1];
                    let arg3 = args.getChildren()[2];
                    newQuadruple.setResult(returnValueDOT(arg1, dot, temp));
                    newQuadruple.setOp1(returnValueDOT(arg2, dot, temp));
                    newQuadruple.setOp2(returnValueDOT(arg3, dot, temp));
                    newQuadruple.setOp3('--');
                    dot += `<tr><td bgcolor="lightblue"><b>${row+1}</b></td>\n` + newQuadruple.getDot();
                } else if (args.getChildren().length == 4){
                    let arg1 = args.getChildren()[0];
                    let arg2 = args.getChildren()[1];
                    let arg3 = args.getChildren()[2];
                    let arg4 = args.getChildren()[3];
                    newQuadruple.setResult(returnValueDOT(arg1, dot, temp));
                    newQuadruple.setOp1(returnValueDOT(arg2, dot, temp));
                    newQuadruple.setOp2(returnValueDOT(arg3, dot, temp));
                    newQuadruple.setOp3(returnValueDOT(arg4, dot, temp));
                    dot += `<tr><td bgcolor="lightblue"><b>${row+1}</b></td>\n` + newQuadruple.getDot();
                } else if (args.getChildren().length == 5){
                    let arg1 = args.getChildren()[0];
                    let arg2 = args.getChildren()[1];
                    let arg3 = args.getChildren()[2];
                    let arg4 = args.getChildren()[3];
                    newQuadruple.setResult(returnValueDOT(arg1, dot, temp));
                    newQuadruple.setOp1(returnValueDOT(arg2, dot, temp));
                    newQuadruple.setOp2(returnValueDOT(arg3, dot, temp));
                    newQuadruple.setOp3(returnValueDOT(arg4, dot, temp));
                    dot += `<tr><td bgcolor="lightblue"><b>${row+1}</b></td>\n` + newQuadruple.getDot();
                }
            }
            row++;
        }
    }
    dot += '    </table>\n    >\n}';
    console.log(dot);
    return dot;
}
function returnValueDOT(arg, table, temp, row){
    console.log(`EVALUANDO NODO DE TIPO: ${arg.getType()}`);
    if(equalType(arg.getType(), TYPE.R64, TYPE.R32, TYPE.SP64, TYPE.SP32, TYPE.ZR64, TYPE.ZR32, TYPE.PC, TYPE.SYSREG)){
        return arg.getValue();
    } else if(equalType(arg.getType(), TYPE.IMM)){
        if (arg.getChildren().length == 1){
            child = arg.getChildren()[0];
            return child.getValue();
        } else {
            child = arg.getChildren()[1];
            return child.getValue();
        }
    } else if(equalType(arg.getType(), TYPE.CONSTANT)){
        if (arg.getChildren().length == 1){
            child = arg.getChildren()[0];
            return child.getValue();
        } else {
            child = arg.getChildren()[1];
            return child.getValue();
        }
    } else if(equalType(arg.getType(), TYPE.REL, TYPE.MASK)){
        arg = arg.getChildren()[0];
        return returnValue(arg, table, temp , row);
    } else if(equalType(arg.getType(), TYPE.OPSHIFT, TYPE.OPEXTEND)){
        let pQ = new Quadruple();
        let pO = new Operator();
        let args = arg.getChildren();
        console.log(args);
        pO.setOperator(args[1].getValue()); pO.setCC(''); pO.setQ('');
        pQ.setOp(pO);
        pQ.setOp1(returnValue(args[2], table, temp, row));
        pQ.setOp2('--');
        pQ.setOp3('--');
        pQ.setResult(returnValue(args[0], table, temp , row));
        table +=`<tr><td bgcolor="lightblue"><b>${row+1}</b></td>\n` + pQ.getDot();
        row++;
        return pQ.getResult();
    } else if(equalType(arg.getType(), TYPE.OP2A, TYPE.OP2L)){
        arg = arg.getChildren()[0];
        return returnValue(arg, table, temp , row);
    } else if(equalType(arg.getType(), TYPE.ADDR)){
        let args = arg.getChildren();
        if (args.length == 1){
            return returnValue(args[0], table, temp , row);
        } else if(args.length == 2){
            let pQ = new Quadruple();
            let pO = new Operator();
            pO.setOperator('addr'); pO.setCC(''); pO.setQ('');
            pQ.setOp(pO);
            pQ.setOp1(returnValue(args[0], table, temp , row));
            pQ.setOp2(returnValue(args[1], table, temp , row));
            pQ.setOp3('--');
            pQ.setResult(`t${temp}`);
            temp++;
            table +=`<tr><td bgcolor="lightblue"><b>${row+1}</b></td>\n` + pQ.getDot();
            row++;
            return pQ.getResult();
        }
    }
}





/*
    If the argument is a type of register; R64, R32, SP64, SP32, ZR64, ZR32, PC, SYSREG its value is in the same node
    If the argument is a type of immediate; the value is int the chidlren of the node, this can have 2 children but the value is always in the last one, if there is only one child, the value is in that child
    If the argument is a type of constant; the value is in the children of the node, this can have 2 children but the value is always in the last one, if there is only one child, the value is in that child
    If the argument is a type of rel; the value is in the children of the children of the node
    If the argument is a type of op2a; the value or values are in the children of the node
    If the argument is a type of op2l; the value or values are in the children of the node
    If the argument is a type of addr; the value or values is in the children of the node
    If the argument is a type of shift; the value or values are in the children of the node
    If the argument is a type of barrierop; the value is in the children of the node
    If the argument is a type of prfop; the value is in the children of the node
    If the argument is a type of mask; the value is in the children of the node
    If the argument is a type of extend; the value or values are in the children of the node
    THIS NEED TO BE RECURSIVE BECAUSE THE OP2A, OP2L, ADDR CAN HAVE MORE THAN ONE ARGUMENT
*/
function returnValue(arg, table, temp){
    console.log(`EVALUANDO NODO DE TIPO: ${arg.getType()}`);
    if(equalType(arg.getType(), TYPE.R64, TYPE.R32, TYPE.SP64, TYPE.SP32, TYPE.ZR64, TYPE.ZR32, TYPE.PC, TYPE.SYSREG)){
        return arg.getValue();
    } else if(equalType(arg.getType(), TYPE.IMM)){
        if (arg.getChildren().length == 1){
            child = arg.getChildren()[0];
            return child.getValue();
        } else {
            child = arg.getChildren()[1];
            return child.getValue();
        }
    } else if(equalType(arg.getType(), TYPE.CONSTANT)){
        if (arg.getChildren().length == 1){
            child = arg.getChildren()[0];
            return child.getValue();
        } else {
            child = arg.getChildren()[1];
            return child.getValue();
        }
    } else if(equalType(arg.getType(), TYPE.REL, TYPE.MASK)){
        arg = arg.getChildren()[0];
        return returnValue(arg, table, temp);
    } else if(equalType(arg.getType(), TYPE.OPSHIFT, TYPE.OPEXTEND)){
        let pQ = new Quadruple();
        let pO = new Operator();
        let args = arg.getChildren();
        console.log(args);
        pO.setOperator(args[1].getValue()); pO.setCC(''); pO.setQ('');
        pQ.setOp(pO);
        pQ.setOp1(returnValue(args[2], table, temp));
        pQ.setOp2('--');
        pQ.setOp3('--');
        pQ.setResult(returnValue(args[0], table, temp));
        table.push(pQ);
        return pQ.getResult();
    } else if(equalType(arg.getType(), TYPE.OP2A, TYPE.OP2L)){
        arg = arg.getChildren()[0];
        return returnValue(arg, table, temp);
    } else if(equalType(arg.getType(), TYPE.ADDR)){
        let args = arg.getChildren();
        if (args.length == 1){
            return returnValue(args[0], table, temp);
        } else if(args.length == 2){
            let pQ = new Quadruple();
            let pO = new Operator();
            pO.setOperator('addr'); pO.setCC(''); pO.setQ('');
            pQ.setOp(pO);
            pQ.setOp1(returnValue(args[0], table, temp));
            pQ.setOp2(returnValue(args[1], table, temp));
            pQ.setOp3('--');
            pQ.setResult(`t${temp}`);
            temp++;
            table.push(pQ);
            return pQ.getResult();
        }
    }
}

// Table full of Quadruples
function tabletoDOT(table){
    let dot = 'digraph G {\n    label=<\n       <table border="1" cellborder="1" cellspacing="0" cellpadding="4" style="font-size:14px;">\n';
    dot += '<tr><td bgcolor=\"lightgray\">#</td>\n<td bgcolor=\"lightgray\">OP</td>\n<td bgcolor=\"lightgray\">ARG1</td>\n<td bgcolor=\"lightgray\">ARG2</td>\n<td bgcolor=\"lightgray\">ARG3</td>\n<td bgcolor=\"lightgray\">RESULT</td></tr>\n'
    for(let i = 0; i < table.length; i++){
        dot += `<tr>\n<td bgcolor="lightblue"><b>${i+1}</b></td>\n` + table[i].getDot();
    }
    dot += '    </table>\n    >\n}';
    console.log(dot);
    return dot;
}

function graphVQ(){
    let resultado = PARSE.parse(Arm64Editor.getValue());
    openGraphPage(QDOT(resultado.getINSTnodes()));
}

const btnq = document.getElementById('btn__q');
btnq.addEventListener('click', () => graphVQ());

const TYPE = {
    EMPTY: 'Vacio', COMMA: 'Coma', EXCLAMATION: 'Signo de Exclamacion', RB: 'Llave Derecha', LB: 'Llave Izquierda', PLUS: 'Mas',
    Y: 'Simbolo &', O: 'Simbolo |', NEG: 'Simbolo ~', XOR: 'Simbolo ⊕', COMMENT: 'Comentario', BLANK: 'Linea en Blanco',
    INTEGER: 'Numero Entero', BIN: 'Numero Binario', HEX: 'Numero Hexadecimal', OCTAL: 'Numero Octal', STRING: 'Cadena de Caracteres', CHAR: 'Caracter',
    IDENTIFIER: 'Identificador', CONSTANT: 'Constante', EQUAL: 'Igual', LABEL: 'Etiqueta', NUMERAL: 'Numeral', SIGN: 'Signo', IMM: 'Inmediato',
    Q: 'Sufijo de Condicion', CC: 'Codigo de Condicion', SYSREG: 'Registro de Sistema', SY: 'Sufijo de Sistema', R64: 'Registro de 64 bits',
    R32: 'Registro de 32 bits', SP64: 'Puntero de Pila de 64 bits', SP32: 'Puntero de Pila de 32 bits', ZR64: 'Registro Cero de 64 bits',
    ZR32: 'Registro Cero de 32 bits', PC: 'Contador de Programa', EXTEND: 'Extendido', OPEXTEND: 'Operando Extendido', SHIFT: 'Desplazamiento',
    OPSHIFT: 'Operando de Desplazamiento', BARRIEROP: 'Operacion de Barrera', PRFOP: 'Operacion de Prefetch', ADDR: 'Direccion de Memoria',
    SH: 'Sufijo de Desplazamiento', MASK: 'Mascara', REL: 'Etiqueta de Salto', OP2A: 'Operando 2 Aritmetico', OP2L: 'Operando 2 Logico',
    INST: 'Instruccion', OP: 'Operador', ARGS: 'Argumentos', DIRECTIVE_SECTION: 'Seccion de Directivas', DIRECT_EXP: 'Expresion de Directiva',
    INSTRUCTION_SECTION: 'Seccion de Instrucciones', INSTRUCTION: 'Instruccion', INSTRUCTIONS: 'Instrucciones', EXPRESSION: 'Expresion',
    EXPRESSIONS: 'Expresiones', DIRECTIVE: 'Directiva', ROOT: 'Raiz',
    /*-----------------------------------------------------------*/
    AT: 'AT', BRK: 'BRK', CLREX: 'CLREX', DMB: 'DMB', DSB: 'DSB', ERET: 'ERET',
    HVC: 'HVC', ISB: 'ISB', MRS: 'MRS', MSR: 'MSR', NOP: 'NOP', SEV: 'SEV', SEVL: 'SEVL',
    SMC: 'SMC', SVC: 'SVC', WFE: 'WFE', WFI: 'WFI', YIELD: 'YIELD',
    /*-----------------------------------------------------------*/
    LDAXP: 'LDAXP', LDXP: 'LDXP',
    LDR: 'LDR', LDAR: 'LDAR', LDXR: 'LDAXR', LDAXR: 'LDAXR',
    LDAXRB: 'LDAXRB', LDAXRH: 'LDAXRH', LDRB: 'LDRB', LDRH: 'LDRH',
    LDNP: 'LDNP',
    LDRT: 'LDRT', LDTRB: 'LDTRB', LDTRH: 'LDTRH',
    LDTRS: 'LDTRS', LDTRSB: 'LDTRSB', LDTRSH: 'LDTRSH',
    LDTRSW: 'LDTRSW',
    STLR: 'STLR', STLRB: 'STLRB', STLRH: 'STLRH',
    STLXP: 'STLXP', STXP: 'STXP',
    STXR: 'STXR', STLXR: 'STLXR', STXRB: 'STXRB', STXRH: 'STXRH', STLXRB: 'STLXRB', STLXRH: 'STLXRH',
    STMP: 'STMP',
    STTR: 'STTR', STTRB: 'STTRB', STTRH: 'STTRH',
    /*-----------------------------------------------------------*/
    CRC32: 'CRC32', CRC32B: 'CRC32B', CRC32H: 'CRC32CH',
    CRC32W: 'CRC32W', CRC32X: 'CRC32X',
    CRC32C: 'CRC32C', CRC32CB: 'CRC32CB', CRC32CH: 'CRC32CH',
    CRC32CW: 'CRC32CW', CRC32CX: 'CRC32CX',
    /*-----------------------------------------------------------*/
    AADD: 'AADD', ACLR: 'ACLR', AEOR: 'AEOR', ASET: 'ASET',
    /*-----------------------------------------------------------*/
    CAS: 'CAS', CASBH: 'CASBH', CASP: 'CASP', LDAO: 'LDAO', LDAOBH: 'LDAOBH', STAO: 'STAO',
    STAOBH: 'STAOBH', SWP: 'SWP', SWPBH: 'SWPBH',
    /*-----------------------------------------------------------*/
    LDP: 'LDP',LDPSW: 'LDPSW',
    LDR: 'LDR',LDUR: 'LDUR',
    LDURB: 'LDURB', LDURH: 'LDURH', LDRB: 'LDRB', LDRH: 'LDRH',
    LDRS: 'LDRS', LDURSB: 'LDURSB', LDURSH: 'LDURSH', LDRSB: 'LDRSB', LDRSH: 'LDRSH',
    LDRSW: 'LDRSW', LDURSW: 'LDURSW',
    PRFM: 'PRFM', STP: 'STP',
    STR: 'STR', STUR: 'STUR',
    STURB: 'STURB', STURH: 'STURH', STRB: 'STRB', STRH: 'STRH',
    /*-----------------------------------------------------------*/
    CCMM: 'CCMM', CCMP: 'CCMP', CINC: 'CINC', CINV: 'CINV', CNEG: 'CNEG', CSEL: 'CSEL', 
    CSET: 'CSET', CSETM: 'CSETM', CSINC: 'CSINC', CSINV: 'CSINV', CSNEG: 'CSNEG',
    /*-----------------------------------------------------------*/
    B: 'B', BCC: 'BCC', BL: 'BL', BLR: 'BLR', BR: 'BR', CBZ: 'CBZ',
    CBNZ: 'CBNZ', RET: 'RET', TBZ: 'TBZ', TBNZ: 'TBNZ',
    /*-----------------------------------------------------------*/
    AND: 'AND', ANDS: 'ANDS', ASR: 'ASR', ASRV: 'ASRV', BIC: 'BIC', BICS: 'BICS',
    EON: 'EON', EOR: 'EOR', ORN: 'ORN',
    LSL: 'LSL', LSR: 'LSR', MOV: 'MOV', MOVK: 'MOVK', MOVN: 'MOVN', MOVZ: 'MOVZ',
    MVN: 'MVN', ORN: 'ORN', ORR: 'ORR', ROR: 'ROR', TST: 'TST',
    /*-----------------------------------------------------------*/
    BFI: 'BFI', BFXIL: 'BFXIL', CLS: 'CLS', CLZ: 'CLZ', EXTR: 'EXTR', RBIT: 'RBIT',
    REV: 'REV', REV16: 'REV16', REV32: 'REV32', 
    SBFIZ: 'SBFIZ', UBFIZ: 'UBFIZ', SBFX: 'SBFX', UBFX: 'UBFX',
    SXTB: 'SXTB', SXTH: 'SXTH', UXTB: 'UXTB', UXTH: 'UXTH',
    SXTW: 'SXTW',
    /*-----------------------------------------------------------*/
    ADC: 'ADC', ADCS: 'ADCS', ADD: 'ADD', ADDS: 'ADDS', ADR: 'ADR', ADRP: 'ADRP',
    CMN: 'CMN', CMP: 'CMP', MADD: 'MADD', MNEG: 'MNEG', MSUB: 'MSUB', MUL: 'MUL',
    NEG: 'NEG', NEGS: 'NEGS', NGC: 'NGC', NGCS: 'NGCS', SBC: 'SBC', SBCS: 'SBCS',
    SDIV: 'SDIV', SMADDL: 'SMADDL', SMNEGL: 'SMNEGL', SMSUBL: 'SMSUBL', SMULH: 'SMULH',
    SMULL: 'SMULL', SUB: 'SUB', SUBS: 'SUBS', UDIV: 'UDIV', UMADDL: 'UMADDL',
    UMNEGL: 'UMNEGL', UMSUBL: 'UMSUBL', UMULH: 'UMULH', UMULL: 'UMULL',
    /*-----------------------------------------------------------*/
}