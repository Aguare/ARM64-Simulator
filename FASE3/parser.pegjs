{
    // Arreglo para descomponer operaciones 
    // Tipo: MSUB se descompone en SUB, MUL
    // MADD se descompone en ADD, MUL
    const operations = [
        { operation: 'MSUB', type:'arithmetic', decompose: ['SUB', 'MUL'] },
        { operation: 'MADD', type:'arithmetic', decompose: ['ADD', 'MUL'] },
        { operation: 'MNEG', type:'arithmetic', decompose: ['NEG', 'MUL'] },
        { operation: 'SMADDL', type:'arithmetic', decompose: ['ADD', 'MUL'] },
        { operation: 'SMNEGL', type:'arithmetic', decompose: ['NEG', 'MUL'] },
        { operation: 'SMSUBL', type:'arithmetic', decompose: ['SUB', 'MUL'] },
        { operation: 'UMADDL', type:'arithmetic', decompose: ['ADD', 'MUL'] },
        { operation: 'UMNEGL', type:'arithmetic', decompose: ['NEG', 'MUL'] },
        { operation: 'UMSUBL', type:'arithmetic', decompose: ['SUB', 'MUL'] },
        { operation: 'CSEL', type:'conditional', decompose: ['MOV', 'MOV', 'B'] },
        { operation: 'CINC', type:'conditional', decompose: ['ADD', 'MOV', 'B'] },
        { operation: 'CSINC', type:'conditional', decompose: ['ADD', 'MOV', 'B'] },
        { operation: 'CSINV', type:'conditional', decompose: ['NEG', 'NEG', 'B'] },
        { operation: 'CSNEG', type:'conditional', decompose: ['MOV', 'NEG', 'B'] }
    ];
    // Clase para representar un nodo del árbol de sintaxis concreto "CST"
    class ASTnode{
        constructor(type, value, children = [], location = null){
            this.type = type;
            this.value = value;
            this.children = children;
            this.location = location;
            this.id = ASTnode.generateUniqueId();
        }
        // Genera un identificador único para el nodo del árbol "Para el archivo .dot"
        static generateUniqueId() {
            return '\"xxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx\"'.replace(/[xy]/g, function(c) {
                const r = Math.random() * 16 | 0,
                v = c === 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        }
        // Función utilizada para interpretar el código armv8 en base al C3D
        accept(c3d) {
            let labels = getLabels(c3d);
            let variables = getVariables(c3d);
            let bss = getBss(c3d);
            let registers = getRegisters();
            function acceptC3d(c3d) {
                for(let currentIndex = 0; currentIndex < c3d.length; currentIndex++) {
                    executeLine(c3d[currentIndex]);
                }
            }

            function executeLine(instruction) {
                console.log(instruction);
            }

            // Función para obtener las etiquetas de un arreglo de c3d
            function getLabels(c3d) {
                let labels = [];
                for(let i = 0; i < c3d.length; i++) {
                    if(c3d[i].resultado === '.text') {
                        labels.push({label: c3d[i].operador1, index: i});
                    }
                }
                return labels;
            }

            // Función para obtener las variables inicializadas .data de un arreglo de c3d
            function getVariables(c3d) {
                let variables = [];
                for(let i = 0; i < c3d.length; i++) {
                    if(c3d[i].resultado === '.data') {
                        variables.push({ variable: c3d[i].operador1, value : c3d[i].operador2, type: c3d[i].operacion });
                    }
                }
                return variables;
            }

            // Función para obtener las variables no inicializadas .bss de un arreglo de c3d
            function getBss(c3d) {
                let bss = [];
                for(let i = 0; i < c3d.length; i++) {
                    if(c3d[i].resultado === '.bss') {
                        bss.push({ variable: c3d[i].operador1, value: '', type: c3d[i].operacion, size: parseInt(c3d[i].operador2, 10) });
                    }
                }
                return bss;
            }

            function getRegisters() {
                return [
                    { register: 'w0', value: 0 },
                    { register: 'w1', value: 0 },
                    { register: 'w2', value: 0 },
                    { register: 'w3', value: 0 },
                    { register: 'w4', value: 0 },
                    { register: 'w5', value: 0 },
                    { register: 'w6', value: 0 },
                    { register: 'w7', value: 0 },
                    { register: 'w8', value: 0 },
                    { register: 'w9', value: 0 },
                    { register: 'w10', value: 0 },
                    { register: 'w11', value: 0 },
                    { register: 'w12', value: 0 },
                    { register: 'w13', value: 0 },
                    { register: 'w14', value: 0 },
                    { register: 'w15', value: 0 },
                    { register: 'w16', value: 0 },
                    { register: 'w17', value: 0 },
                    { register: 'w18', value: 0 },
                    { register: 'w19', value: 0 },
                    { register: 'w20', value: 0 },
                    { register: 'w21', value: 0 },
                    { register: 'w22', value: 0 },
                    { register: 'w23', value: 0 },
                    { register: 'w24', value: 0 },
                    { register: 'w25', value: 0 },
                    { register: 'w26', value: 0 },
                    { register: 'w27', value: 0 },
                    { register: 'w28', value: 0 },
                    { register: 'w29', value: 0 },
                    { register: 'w30', value: 0 },
                    { register: 'w31', value: 0 },
                    { register: 'x0', value: 0 },
                    { register: 'x1', value: 0 },
                    { register: 'x2', value: 0 },
                    { register: 'x3', value: 0 },
                    { register: 'x4', value: 0 },
                    { register: 'x5', value: 0 },
                    { register: 'x6', value: 0 },
                    { register: 'x7', value: 0 },
                    { register: 'x8', value: 0 },
                    { register: 'x9', value: 0 },
                    { register: 'x10', value: 0 },
                    { register: 'x11', value: 0 },
                    { register: 'x12', value: 0 },
                    { register: 'x13', value: 0 },
                    { register: 'x14', value: 0 },
                    { register: 'x15', value: 0 },
                    { register: 'x16', value: 0 },
                    { register: 'x17', value: 0 },
                    { register: 'x18', value: 0 },
                    { register: 'x19', value: 0 },
                    { register: 'x20', value: 0 },
                    { register: 'x21', value: 0 },
                    { register: 'x22', value: 0 },
                    { register: 'x23', value: 0 },
                    { register: 'x24', value: 0 },
                    { register: 'x25', value: 0 },
                    { register: 'x26', value: 0 },
                    { register: 'x27', value: 0 },
                    { register: 'x28', value: 0 },
                    { register: 'x29', value: 0 },
                    { register: 'x30', value: 0 },
                    { register: 'x31', value: 0 },
                    { register: 'sp', value: 0 },
                    { register: 'lr', value: 0 },
                    { register: 'zero', value: 0 }
                ];
            }

            acceptC3d(c3d);
        }

        // Función para obtener el código .dot del árbol de sintaxis concreto "CST"
        getDot(node){
            let dot = '';
            dot += 'digraph G {\n';
            function addNodes(node){
                // ROOT
                if (node.type === 'ROOT') {dot += `${node.id} [label="${node.type}"];\n`;}
                // INSTRUCTION
                else if (node.type === 'INSTRUCTION'){dot += `${node.id} [label="${node.type} ${node.value}"];\n`;}
                // Registro General 64 Bits
                else if (node.type === 'Registro General 64 Bits'){dot += `${node.id} [label="${node.type} ${node.value}"];\n`;}
                // SOURCE1 AND SOURCE2
                else if (node.type === 'DESTINATION' || node.type === 'SOURCE1' || node.type === 'SOURCE2' ) {dot += `${node.id} [label="${node.value}"];\n`;}
                // R_64_BITS, R_32_BITS, R_STACK_POINTER, R_LINK_REGISTER, R_ZERO_REGISTER
                else if (node.type === 'R_64_BITS' || node.type === 'R_32_BITS' || node.type === 'R_STACK_POINTER' || node.type === 'R_LINK_REGISTER' || node.type === 'R_ZERO_REGISTER'){dot += `${node.id} [label="${node.value}"];\n`;}
                // LOGICAL_SHIFT_LEFT, LOGICAL_SHIFT_RIGHT, ARITHMETIC_SHIFT_RIGHT
                else if (node.type === 'LOGICAL_SHIFT_LEFT' || node.type === 'LOGICAL_SHIFT_RIGHT' || node.type === 'ARITHMETIC_SHIFT_RIGHT'){dot += `${node.id} [label="${node.value}"];\n`;}
                // UNSIGNED_EXTEND_BYTE, UNSIGNED_EXTEND_HALFWORD, UNSIGNED_EXTEND WORD, UNSIGNED_EXTEND_DOUBLEWORD, SIGNED_EXTEND_BYTE, SIGNED_EXTEND_HALFWORD, SIGNED_EXTEND_WORD, SIGNED_EXTEND_DOUBLEWORD
                else if (node.type === 'UNSIGNED_EXTEND_BYTE' || node.type === 'UNSIGNED_EXTEND_HALFWORD' || node.type === 'UNSIGNED_EXTEND WORD' || node.type === 'UNSIGNED_EXTEND_DOUBLEWORD' || node.type === 'SIGNED_EXTEND_BYTE' || node.type === 'SIGNED_EXTEND_HALFWORD' || node.type === 'SIGNED_EXTEND_WORD' || node.type === 'SIGNED_EXTEND_DOUBLEWORD'){dot += `${node.id} [label="${node.value}"];\n`;}
                else{dot += `${node.id} [label="${node.value}"];\n`;}
                // Agregar nodos hijos y aristas correspondientes a cada nodo del árbol "Recursivo"
                node.children.forEach(child => {
                    dot += `${node.id} -> ${child.id};\n`;
                    addNodes(child);
                });
            }
            addNodes(node);
            dot += '}';
            console.clear();
            console.log(dot);
            return dot;
        }

        // Función para obtener una lista de c3d de los nodos "Instruction" del árbol de sintaxis concreto "CST"
        // Esta función creará objetos tipo { resultado: 'R0', operador1: 'R1', operador2: 'R2', operacion: 'ADD' }
        getC3d(node){
            let instructions = [];
            let temporalCounter = 1;
            let temporalLabel = 1;
            let temporalRegister = "x10";
            let currentDirective = '';
            let sectionScope = false;
            function getC3d(node) {
                sectionScope = node.type === 'SECTION' ? true : sectionScope;
                if (node.type === 'DIRECTIVE' && node.value === 'Directive') {
                    if (node.children.length === 2 && node.children[0].value !== '.global') {
                        let instruction = instructions[instructions.length - 1];
                        instruction.operador2 = node.children[1].value;
                        instruction.operacion = node.children[0].value;
                    }
                } else if (node.type === 'DIRECTIVE' && (node.value === '.global' || node.value === '.text' || node.value === '.data' || node.value === '.bss' )) {
                    currentDirective = node.value;
                } else if(node.type === 'LABEL' && node.value !== 'LBL' && (sectionScope || currentDirective === '.global')) {
                    let instruction = { resultado: '', operador1: '', operador2: '', operacion: '', line: 0, column: 0 };
                    instruction.operador1 = node.value;
                    instruction.line = node.location.start.line;
                    instruction.column = node.location.start.column;
                    instruction.resultado = currentDirective === '' ? '.text' : currentDirective;
                    if(currentDirective === '.global') currentDirective = '';
                    instructions.push(instruction);
                    sectionScope = false;
                } else if(node.type === 'INTEGER' || node.type === 'STRING') {

                } else if (node.type === 'INSTRUCTION') {
                    let instruction = { resultado: '', operador1: '', operador2: '', operacion: '' };
                    instruction.operacion = node.value;
                    instruction.line = node.location.start.line;
                    instruction.column = node.location.start.column;
                    if(node.children.length === 4) {
                        // Si es mayor a 4 se debe crear una operación temporal con los valores 3 y 2 del arreglo
                        // Ejemplo: MADD R0, R1, R2, R3
                        // t1 = R1 * R2
                        // RO = R3 + t1
                        // La operación se toma del arreglo operations
                        const operation = operations.find(op => op.operation === node.value);
                        if(operation && operation.type === 'arithmetic') {
                            // const temp1 = { resultado: 'T' + temporalCounter, operador1: node.children[1].children[0].value, operador2: node.children[2].children[0].value, operacion: operation.decompose[1] };
                            const temp1 = { resultado: temporalRegister, operador1: node.children[1].children[0].value, operador2: node.children[2].children[0].value, operacion: operation.decompose[1], line: node.location.start.line, column: node.location.start.column};
                            instructions.push(temp1);
                            instruction.operacion = operation.decompose[0];
                            instruction.resultado = node.children[0].children[0].value;
                            instruction.operador1 = node.children[3].children[0].value;
                            // instruction.operador2 = 'T' + temporalCounter;
                            // temporalCounter++;
                            instruction.operador2 = temporalRegister;
                        } else if (operation && operation.type === 'conditional') {
                            // Para las operaciones condicionales las descompondremos de la siguiente manera:
                            /*
                                Supongamos que tenemos la siguiente instrucción
                                CSEL w7, w5, w6, eq
                                Se descompone en:
                                BEQ temporal_label_1
                                MOV w7, w6
                                B temporal_label_2
                                temporal_label_1:
                                MOV w7, w5
                                temporal_label_2:
                                la operación beq se obtiene de concatenar la operación con 'B' con el children[3].value
                                Las operaciones se encuentran en el arreglo operations en el arreglo decompose (B se encuentra al final del arreglo decompose)
                            */
                            const tempLabel1 = { resultado: '.text', operador1: 'temporal_label_' + temporalLabel, operador2: '', operacion: '' };
                            const tempLabel2 = { resultado: '.text', operador1: 'temporal_label_' + (temporalLabel + 1), operador2: '', operacion: '' };
                            const bop = { resultado: 'temporal_label_' + temporalLabel, operador1: '', operador2: '', operacion: 'B' + node.children[3].children[0].value };
                            const bop2 = { resultado: 'temporal_label_' + (temporalLabel + 1), operador1: '', operador2: '', operacion: 'B' };
                            const trueOp = { resultado: node.children[0].children[0].value, operador1: node.children[2].children[0].value, operador2: '', operacion: operation.decompose[1] };
                            const falseOp = { resultado: node.children[0].children[0].value, operador1: node.children[1].children[0].value, operador2: '', operacion: operation.decompose[0] };
                            instructions.push(bop);
                            instructions.push(falseOp)
                            instructions.push(bop2);
                            instructions.push(tempLabel1);
                            instructions.push(trueOp);
                            instructions.push(tempLabel2);
                            temporalLabel += 2;

                        }
                    } else {
                        for(let i = 0; i < node.children.length; i++) {
                            if(i === 0) instruction.resultado = node.children[i].children[0].value;
                            if(i === 1) {
                                if(node.children[i].children[0].value === '[]') {
                                    instruction.operador1 = getValues(node.children[i].children[0].children);
                                } else {
                                    instruction.operador1 = node.children[i].children[0].value;
                                }
                            }
                            if(i === 2) {
                                if(node.children[i].children[0].value === '[]') {
                                    instruction.operador2 = getValues(node.children[i].children[0].children);
                                } else {
                                    instruction.operador2 = node.children[i].children[0].value;
                                }
                            }
                        }
                    }
                    instructions.push(instruction);
                }
                node.children.forEach(child => getC3d(child));
            }
            getC3d(node);
            return instructions;
        }

        // Función para obtener una lista de cuadruplos
        // Esta función recibe por parámetros un objeto con las instrucciones c3d { resultado: 'R0', operador1: 'R1', operador2: 'R2', operacion: 'ADD' }
        // Un cuadruplo se conforma de el operator, operando1, operando2 y destino
        getQuarters(c3dList) {
            let quarters = [];
            c3dList.forEach(c3d => {
                let quarter = { operator: '', operand1: '', operand2: '', destination: '' };
                quarter.operator = c3d.operacion;
                quarter.operand1 = c3d.operador1;
                quarter.operand2 = c3d.operador2;
                quarter.destination = c3d.resultado;
                quarters.push(quarter);
            });
            return quarters;
        }

    }

    // Función para concatenar todos los hijos de un nodo
    function getValues(children) {
        let values = '[';
        children.forEach(child => {
            if(child.value === 'SRC1' || child.value === 'SRC2') {
                values += child.children[0].value + ', ';

            } else {
                values += child.value + ', ';
            }
        });
        
        values = values.slice(0, -2);
        values += ']';
        return values;
    }

    // Funciones para crear y manipular nodos del árbol de sintaxis concreto "CST"
    function createNode(type, value, location, children = []){
        return new ASTnode(type, value, children, location);
    }
    function setValue(node, value){
        node.value = value;
    }
    function addChild(node, child){
        node.children.push(child);
    }
    function addChildren(node, children){
        node.children = node.children.concat(children);
    }
    // Función para obtener el código .dot del árbol de sintaxis concreto "CST"
    function getDot(node){
        let dot = '';
        dot += 'digraph G {\n';
        function addNodes(node){
            // ROOT
            if (node.type === 'ROOT') {dot += `${node.id} [label="${node.type}"];\n`;}
            // INSTRUCTION
            else if (node.type === 'INSTRUCTION'){dot += `${node.id} [label="${node.type} ${node.value}"];\n`;}
            // Registro General 64 Bits
            else if (node.type === 'Registro General 64 Bits'){dot += `${node.id} [label="${node.type} ${node.value}"];\n`;}
            // SOURCE1 AND SOURCE2
            else if (node.type === 'DESTINATION' || node.type === 'SOURCE1' || node.type === 'SOURCE2' ) {dot += `${node.id} [label="${node.value}"];\n`;}
            // R_64_BITS, R_32_BITS, R_STACK_POINTER, R_LINK_REGISTER, R_ZERO_REGISTER
            else if (node.type === 'R_64_BITS' || node.type === 'R_32_BITS' || node.type === 'R_STACK_POINTER' || node.type === 'R_LINK_REGISTER' || node.type === 'R_ZERO_REGISTER'){dot += `${node.id} [label="${node.value}"];\n`;}
            // LOGICAL_SHIFT_LEFT, LOGICAL_SHIFT_RIGHT, ARITHMETIC_SHIFT_RIGHT
            else if (node.type === 'LOGICAL_SHIFT_LEFT' || node.type === 'LOGICAL_SHIFT_RIGHT' || node.type === 'ARITHMETIC_SHIFT_RIGHT'){dot += `${node.id} [label="${node.value}"];\n`;}
            // UNSIGNED_EXTEND_BYTE, UNSIGNED_EXTEND_HALFWORD, UNSIGNED_EXTEND WORD, UNSIGNED_EXTEND_DOUBLEWORD, SIGNED_EXTEND_BYTE, SIGNED_EXTEND_HALFWORD, SIGNED_EXTEND_WORD, SIGNED_EXTEND_DOUBLEWORD
            else if (node.type === 'UNSIGNED_EXTEND_BYTE' || node.type === 'UNSIGNED_EXTEND_HALFWORD' || node.type === 'UNSIGNED_EXTEND WORD' || node.type === 'UNSIGNED_EXTEND_DOUBLEWORD' || node.type === 'SIGNED_EXTEND_BYTE' || node.type === 'SIGNED_EXTEND_HALFWORD' || node.type === 'SIGNED_EXTEND_WORD' || node.type === 'SIGNED_EXTEND_DOUBLEWORD'){dot += `${node.id} [label="${node.value}"];\n`;}
            else{dot += `${node.id} [label="${node.value}"];\n`;}
            // Agregar nodos hijos y aristas correspondientes a cada nodo del árbol "Recursivo"
            node.children.forEach(child => {
                dot += `${node.id} -> ${child.id};\n`;
                addNodes(child);
            });
        }
        addNodes(node);
        dot += '}';
        console.clear();
        console.log(dot);
        return dot;
    }
    const root = createNode('ROOT', 'ROOT', location());
}
// Iniciamos el análisis sintáctico con la regla inicial "start"
start
    = line:(directive / section / instruction / comment / mcomment / blank_line)*
        {
            root.children = [...line];
            root.children = root.children.filter(node => node.type !== 'EMPTY');
            root.children = root.children.filter(node => node.type !== 'COMMENT');
            return root;
        }
// Directivas en ARM64 v8
directive
  = _* name:directive_p _* args:(directive_p / label / string / expression)? _* comment? "\n"?
  {
    const node = createNode('DIRECTIVE', 'Directive', location());
    addChild(node, name);
    if(args){
        addChild(node, args);
    }
    return node;
  
  }
//
directive_p
    = "." directive_name
    {
        const node = createNode('DIRECTIVE', text(), location());
        return node;  
    }
// Nombre de las directivas
directive_name
  = "align" / "ascii" / "asciz" / "byte" / "hword" / "word" / "quad" / "skip" / "extern" /
    "data" / "text" / "global" / "section" / "space" / "zero" / "incbin" / "set" / "equ" / "bss"

// Secciones
section
  = _* label:label _* ":" _* comment? "\n"?
  {
    const node = createNode('SECTION', 'Section', location());
    addChild(node, label);
    return node;
  }


// Instrucciones en ARM64 v8 
instruction
    = i:add_inst
    / i:adc_inst
    / i:sub_inst
    / i:mul_inst
    / i:div_inst
    / i:udiv_inst
    / i:sdiv_inst
    / i:ands_inst
    / i:and_inst
    / i:orr_inst
    / i:eor_inst
    / i:mov_inst
    / i:mvn_inst
    / i:ldrb_inst
    / i:ldr_inst
    / i:ldp_inst
    / i:strb_inst
    / i:str_inst
    / i:stp_inst
    / i:lsl_inst
    / i:lsr_inst
    / i:asr_inst
    / i:ror_inst
    / i:cmp_inst
    / i:beq_inst
    / i:bne_inst
    / i:bgt_inst
    / i:blt_inst
    / i:ble_inst
    / i:bl_inst
    / i:b_inst
    / i:ret_inst
    / i:svc_inst
    / i:madd_inst
    / i:mneg_inst
    / i:msub_inst
    / i:ngc_inst
    / i:sbc_inst
    / i:smaddl_inst
    / i:cmn_inst
    / i:smnegl_inst
    / i:smsubl_inst
    / i:smulh_inst
    / i:smull_inst
    / i:umaddl_inst
    / i:umnegl_inst
    / i:umsubl_inst
    / i:umulh_inst
    / i:umull_inst
    / i:bfi_inst
    / i:bfxil_inst
    / i:cls_inst
    / i:clz_inst
    / i:rev_inst
    / i:rev16_inst
    / i:rev32_inst
    / i:rbit_inst
    / i:extr_inst
    / i:sxtw_inst
    / i:movk_inst
    / i:movn_inst
    / i:movz_inst
    / i:bic_inst
    / i:eon_inst
    / i:tst_inst
    / i:cbz_inst
    / i:cbnz_inst
    / i:tbz_inst
    / i:tbnz_inst
    / i:cas_inst
    / i:swp_inst
    / i:ccmn_inst
    / i:ccmp_inst
    / i:csel_inst
    / i:cinc_inst
    / i:cinv_inst
    / i:cset_inst
    / i:csetm_inst
    / i:csinc_inst
    / i:csinv_inst
    / i:csneg_inst
    / i:ldp_inst
    / i:ldpsw_inst
    / i:clr_inst
    / i:set_inst
    / i:crc32_inst
    / i: uxt_inst


// Instrucción Zero Extend Byte (UXTB)
uxt_inst
    = _* "UXTB"i _* rd:reg64 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'UXTB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucción para multiplicación con signo de dos registros de 64 bits (SMULH)
smulh_inst
    = _* "SMULH"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SMULH', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción para multiplicación de dos registros de 32 bits (SMULL)
smull_inst
    = _* "SMULL"i _* rd:reg64 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SMULL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción para multiplicar y sumar dos registros de 32 bits (UMADDL) 
umaddl_inst
    = _* "UMADDL"i _* rd:reg64 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'UMADDL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            addChild(node, src3);
            return node;
        }

// Instrucción para multiplicar y negar dos registros de 32 bits (UMNEGL)
umnegl_inst
    = _* "UMNEGL"i _* rd:reg64 _* "," _* src1:reg32 _* "," _* src2:operand32 _*  _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'UMNEGL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }

// Instrucción para multiplicar y restar dos registros de 32 bits (UMSUBL)
umsubl_inst
    = _* "UMSUBL"i _* rd:reg64 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'UMSUBL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            addChild(node, src3);
            return node;
        }

// Instrucción para multiplicar dos registros de 64 bits y escribir el resultado de 128 bits en registro de 64 bits (UMULH)
umulh_inst
    = _* "UMULH"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'UMULH', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// instrucción para multiplicar dos registros de 32 bits y almacenar el resultado en un registro de 64 bits (UMULL)
umull_inst
    = _* "UMULL"i _* rd:reg64 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'UMULL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucciones Suma 64 bits y 32 bits (ADD)
add_inst "Instrucción de Suma"
    = _* "ADD"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ADD', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "ADD"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ADD', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucciones Suma con acarreo 64 bits y 32 bits (ACD)
adc_inst "Instrucción de Suma con acarreo"
    = _* "ADC"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ADC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "ADC"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ADC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }


// Instrucciones para comparar con negado (CMN)
cmn_inst "Instrucción de Comparación con negado"
    = _* "CMN"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CMN', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "CMN"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CMN', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

//Instrucciones para suma con multiplicacion 64 y 32 bits (MADD)
madd_inst
    = _* "MADD"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MADD', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }
    / _* "MADD"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MADD', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }

// Instrucciones de negación con multiplicación de 64 y 32 bits (MNEG)
mneg_inst
    = _* "MNEG"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MNEG', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "MNEG"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MNEG', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucciones de resta con multiplicación de 64 y 32 bits (MSUB)
msub_inst
    = _* "MSUB"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MSUB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }
    / _* "MSUB"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MSUB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }

// Instrucciones de negación con carry 64 y 32 bits (NGC)
ngc_inst
    = _* "NGC"i _* rd:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'NGC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            addChild(rdNode, rd);
            addChild(node, rdNode);
            addChild(node, src2);
            return node;
        }
    / _* "NGC"i _* rd:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'NGC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            addChild(rdNode, rd);
            addChild(node, rdNode);
            addChild(node, src2);
            return node;
        }

// Instrucciones de resta con carry 64 y 32 bits (SBC)
sbc_inst
    = _* "SBC"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SBC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "SBC"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SBC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucciones de multiplicación con signo 64 y 32 bits (SMADDL)
smaddl_inst
    = _* "SMADDL"i _* rd:reg64 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SMADDL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }

// Instrucciones de multiplicación con signo negativo de 32 bits (SMNEGL)
smnegl_inst
    = _* "SMNEGL"i _* rd:reg64 _* "," _* src1:reg32 _* "," _* src2:operand32 _*  _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SMNEGL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucciones de multiplicación con signo de dos registros de 32 bits (SMSUBL)
smsubl_inst
    = _* "SMSUBL"i _* rd:reg64 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SMSUBL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            setNode();
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }



// Instrucciones de Resta 64 bits y 32 bits (SUB)  
sub_inst
    = _* "SUB"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SUB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "SUB"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SUB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
// Instrucciones de Multiplicación 64 bits y 32 bits (MUL)
mul_inst
    = _* "MUL"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MUL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "MUL"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MUL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
// Instrucciones de División 64 bits y 32 bits (DIV)
div_inst
    = _* "DIV"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'DIV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "DIV"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'DIV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
// Instrucciones de División sin signo 64 bits y 32 bits (UDIV)
udiv_inst
    = _* "UDIV"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'UDIV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "UDIV"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'UDIV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
// Instrucciones de División con signo 64 bits y 32 bits (SDIV)
sdiv_inst
    = _* "SDIV"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SDIV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "SDIV"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SDIV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucciones de manipulación de bits
// Instrucción BFI 64 bits y 32 bits (BFI)
bfi_inst
    = _* "BFI"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BFI', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }
    / _* "BFI"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BFI', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }

// Instrucción BFXIL 64 bits y 32 bits (BFXIL)
bfxil_inst
    = _* "BFXIL"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BFXIL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }
    / _* "BFXIL"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BFXIL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }

// Instrucción CLS 64 bits y 32 bits (CLS)
cls_inst
    = _* "CLS"i _* rd:reg64 _* "," _* src1:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CLS', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }
    / _* "CLS"i _* rd:reg32 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CLS', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucción CLZ 64 bits y 32 bits (CLZ)
clz_inst
    = _* "CLZ"i _* rd:reg64 _* "," _* src1:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CLZ', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }
    / _* "CLZ"i _* rd:reg32 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CLZ', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instruccion EXTR 64 bits y 32 bits (EXTR)
extr_inst
    = _* "EXTR"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'EXTR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }
    / _* "EXTR"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'EXTR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }

// Instrucción RBIT 64 bits y 32 bits (RBIT)
rbit_inst
    = _* "RBIT"i _* rd:reg64 _* "," _* src1:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'RBIT', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }
    / _* "RBIT"i _* rd:reg32 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'RBIT', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucción REV 64 bits y 32 bits (REV)
rev_inst
    = _* "REV"i _* rd:reg64 _* "," _* src1:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'REV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }
    / _* "REV"i _* rd:reg32 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'REV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucción REV16 64 bits y 32 bits (REV16)
rev16_inst
    = _* "REV16"i _* rd:reg64 _* "," _* src1:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'REV16', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }
    / _* "REV16"i _* rd:reg32 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'REV16', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucción REV32 64 bits y 32 bits (REV32)
rev32_inst
    = _* "REV32"i _* rd:reg64 _* "," _* src1:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'REV32', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }
    / _* "REV32"i _* rd:reg32 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'REV32', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucción BFIZ 64 bits y 32 bits (BFIZ)
bfiz_inst
    = _* "BFIZ"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BFIZ', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }
    / _* "BFIZ"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BFIZ', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }

// Instrucción BFX 64 bits y 32 bits (BFX)
bfx_inst
    = _* "BFX"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* src3:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BFX', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }
    / _* "BFX"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* src3:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BFX', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, src3);
            return node;
        }

// Instrucción SXTW (SXTW)
sxtw_inst
    = _* "SXTW"i _* rd:reg64 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SXTW', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucciones AND 64 bits y 32 bits (AND)        
and_inst
    = _* "AND"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'AND', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "AND"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'AND', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción ANDS 64 y 32 bits (ANDS)
ands_inst
    = _* "ANDS"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ANDS', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "ANDS"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ANDS', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción para limpiar bit a bit 64 bits y 32 bits (BIC)
bic_inst
    = _* "BIC"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BIC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "BIC"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BIC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción para hacer un OR NOT exclusivo bit a bit 64 bits y 32 bits (EON)
eon_inst
    = _* "EON"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'EON', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "EON"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'EON', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucciones OR 64 bits y 32 bits (ORR)
orr_inst
    = _* "ORR"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ORR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "ORR"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ORR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
// Instrucciones XOR 64 bits y 32 bits (EOR)
eor_inst
    = _* "EOR"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'EOR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "EOR"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'EOR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
// Instrucción MOV 64 bits y 32 bits (MOV)
mov_inst "Instrucción MOV"
  = _* "MOV"i _* rd:reg64_or_reg32 _* "," _* src:mov_source _* comment? "\n"?
  {
    const node = createNode('INSTRUCTION', 'MOV', location());
    const rdNode = createNode('DESTINATION', 'RD', location());
    const srcNode = createNode('SOURCE1', 'SRC1', location());
    addChild(rdNode, rd);
    addChild(srcNode, src);
    addChild(node, rdNode);
    addChild(node, srcNode);
    return node;
  }


// Instrucción MOVK 64 bits y 32 bits (MOVK)
movk_inst "Instrucción MOVK"
  = _* "MOVK"i _* rd:reg64_or_reg32 _* "," _* src:movk_source _* comment? "\n"?
  {
    const node = createNode('INSTRUCTION', 'MOVK', location());
    const rdNode = createNode('DESTINATION', 'RD', location());
    const srcNode = createNode('SOURCE1', 'SRC1', location());
    addChild(rdNode, rd);
    addChild(srcNode, src);
    addChild(node, rdNode);
    addChild(node, srcNode);
    return node;
  }
  / _* "MOVK"i _* rd:reg64_or_reg32 _* "," _* src:movk_source _* "," _* src2:movk_source _* comment? "\n"?
  {
    const node = createNode('INSTRUCTION', 'MOVK', location());
    const rdNode = createNode('DESTINATION', 'RD', location());
    const srcNode = createNode('SOURCE1', 'SRC1', location());
    addChild(rdNode, rd);
    addChild(srcNode, src);
    addChild(node, rdNode);
    addChild(node, srcNode);
    addChild(node, src2);
    return node;
  }

// Instrucción ORN 64 bits y 32 bits (ORN)
orn_inst
    = _* "ORN"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ORN', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "ORN"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ORN', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción TST 64 bits y 32 bits (TST)
tst_inst
    = _* "TST"i _* rd:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'TST', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            addChild(rdNode, rd);
            addChild(node, rdNode);
            addChild(node, src2);
            return node;
        }
    / _* "TST"i _* rd:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'TST', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            addChild(rdNode, rd);
            addChild(node, rdNode);
            addChild(node, src2);
            return node;
        }


// Instrucción MOVN 64 bits y 32 bits (MOVN)
movn_inst
    = _* "MOVN"i _* rd:reg64_or_reg32 _* "," _* src:movk_source _* comment? "\n"?
    {
        const node = createNode('INSTRUCTION', 'MOVN', location());
        const rdNode = createNode('DESTINATION', 'RD', location());
        const srcNode = createNode('SOURCE1', 'SRC1', location());
        addChild(rdNode, rd);
        addChild(srcNode, src);
        addChild(node, rdNode);
        addChild(node, srcNode);
        return node;
    }

movz_inst
    = _* "MOVZ"i _* rd:reg64_or_reg32 _* "," _* src:movk_source _* comment? "\n"?
    {
        const node = createNode('INSTRUCTION', 'MOVZ', location());
        const rdNode = createNode('DESTINATION', 'RD', location());
        const srcNode = createNode('SOURCE1', 'SRC1', location());
        addChild(rdNode, rd);
        addChild(srcNode, src);
        addChild(node, rdNode);
        addChild(node, srcNode);
        return node;
    }


movk_source
    = "#" i:immediate
    {
        return i;
    }

reg64_or_reg32 "Registro de 64 o 32 Bits"
  = reg64
  / reg32

mov_source "Source para MOV"
  = reg64_or_reg32
  / immediate


// Instrucción Load Register (LDRB)
ldrb_inst "Instrucción LDRB"
    = _* "LDRB"i _* rd:reg64 _* "," _* src:ldr_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LDRB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }
    / _* "LDRB"i _* rd:reg32 _* "," _* src:ldr_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LDRB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }


//  Instucción Load Register (LDR)
ldr_inst "Instrucción LDR"
    = _* "LDR"i _* rd:reg64 _* "," _* src:ldr_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LDR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }
    / _* "LDR"i _* rd:reg32 _* "," _* src:ldr_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LDR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }
ldr_source 
    = "=" l:label
        {
            l.type = "VARIABLE";
            l.value = '=' + l.value;
            return [l];
        }
    / "[" _* r:reg64_or_reg32 _* "," _* r2:reg64_or_reg32 _* "," _* s:shift_op _* i2:immediate _* "]"
        {
            const node = createNode('[]', '[]', location());
            addChildren(node, [r, r2, s, i2] );
            return node;
        }
    / "[" _* r:reg64 _* "," _* i:operand64 _* "," _* s:shift_op _* i2:immediate _* "]"
        {
            const node = createNode('[]', '[]', location());
            addChildren(node, [r, i, s, i2] );
            return node;
            // return [r, i, s, i2];
        }
    / "[" _* r:reg64 _* "," _* i:operand64 _* "," _* e:extend_op _* "]" 
        {
            const node = createNode('[]', '[]', location());
            addChildren(node, [r, i, e] );
            return node;
            // return [r, i, e];
        }
    / "[" _* r:reg64 _* "," _* i:operand64 _* "]"
        {
            const node = createNode('[]', '[]', location());
            addChildren(node, [r, i] );
            return node;
            // return [r, i];
        }
    / "[" _* r:reg64 _* "]"
        {
            const node = createNode('[]', '[]', location());
            addChild(node, r);
            return node;
            // return [r];
        }

// INSTRUCCIONES DE CARGA Y ALMACENAMIENTO

// Instrucción Load Pair Register (LDP)
ldp_inst "Instrucción LDP"
    = _* "LDP"i _* rd:reg64 _* "," _* rd2:reg64 _* "," _* src:ldr_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LDP', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const rd2Node = createNode('DESTINATION', 'RD2', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(rd2Node, rd2);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, rd2Node);
            addChild(node, srcNode);
            return node;
        }
    / _* "LDP"i _* rd:reg32 _* "," _* rd2:reg32 _* "," _* src:ldr_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LDP', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const rd2Node = createNode('DESTINATION', 'RD2', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(rd2Node, rd2);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, rd2Node);
            addChild(node, srcNode);
            return node;
        }

// Instrucción Load Pair Register Post Indexed (LDPSW)
ldpsw_inst
    = _* "LDPSW"i _* rd:reg64 _* "," _* rd2:reg64 _* "," _* src:ldr_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LDPSW', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const rd2Node = createNode('DESTINATION', 'RD2', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(rd2Node, rd2);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, rd2Node);
            addChild(node, srcNode);
            return node;
        }

// Instrucción PRFM
prfm_inst
    = _* "PRFM"i _* rd:reg64 _* "," _* src:ldr_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'PRFM', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }

// OPERACIONES ATÓMICAS

// Instrucción CLR 64 bits y 32 bits (CLR)
clr_inst
    = _* "CLR"i _* rd:reg64 _* "," _* src1:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CLR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }
    / _* "CLR"i _* rd:reg32 _* "," _* src1:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CLR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucción SET 64 bits y 32 bits (SET)
set_inst
    = _* "SET"i _* rd:reg64 _* "," _* src1:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SET', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            return node;
        }

// Instrucción Store Register (STR)
// Ejemplo de instrucción STR: STR X0, [X1, #0x10]
str_inst "Instrucción STR"
    = _* "STR"i _* rd:reg64 _* "," _* src:str_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'STR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }
    / _* "STR"i _* rd:reg32 _* "," _* src:str_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'STR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }
str_source 
    = "[" _* r:reg64_or_reg32 _* "," _* r2:reg64_or_reg32 _* "," _* s:shift_op _* i2:immediate _* "]"
        {
            const node = createNode('[]', '[]', location());
            addChildren(node, [r, r2, s, i2] );
            return node;
            // return [r, r2, s, i2];
        }
    / "[" _* r:reg64 _* "," _* i:operand64 _* "," _* s:shift_op _* i2:immediate _* "]"
        {
            const node = createNode('[]', '[]', location());
            addChildren(node, [r, i, s, i2] );
            return node;
            // return [r, i, s, i2];
        }
    / "[" _* r:reg64 _* "," _* i:operand64 _* "," _* e:extend_op _* "]" 
        {
            const node = createNode('[]', '[]', location());
            addChildren(node, [r, i, e] );
            return node;
            // return [r, i, e];
        }
    / "[" _* r:reg64 _* "," _* i:operand64 _* "]"
        {
            const node = createNode('[]', '[]', location());
            addChildren(node, [r, i] );
            return node;
            // return [r, i];
        }
    / "[" _* r:reg64 _* "]"
        {
            const node = createNode('[]', '[]', location());
            addChild(node, r);
            return node;
            // return [r];
        }

// Instrucción Store Register Byte (STRB)
strb_inst "Instrucción STRB"
    = _* "STRB"i _* rd:reg64 _* "," _* src:str_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'STRB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }
    / _* "STRB"i _* rd:reg32 _* "," _* src:str_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'STRB', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }

// Instrucción Store Pair Register (STP)
stp_inst "Instrucción STP"
    = _* "STP"i _* rd:reg64 _* "," _* rd2:reg64 _* "," _* src:str_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'STP', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const rd2Node = createNode('DESTINATION', 'RD2', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(rd2Node, rd2);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, rd2Node);
            addChild(node, srcNode);
            return node;
        }
    / _* "STP"i _* rd:reg32 _* "," _* rd2:reg32 _* "," _* src:str_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'STP', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const rd2Node = createNode('DESTINATION', 'RD2', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(rd2Node, rd2);
            addChildren(srcNode, src);
            addChild(node, rdNode);
            addChild(node, rd2Node);
            addChild(node, srcNode);
            return node;
        }
// Instrucción Move Not (MVN)
mvn_inst "Instrucción MVN"
    = _* "MVN"i _* rd:reg64 _* "," _* src:mov_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MVN', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }
    / _* "MVN"i _* rd:reg32 _* "," _* src:mov_source _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'MVN', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(srcNode, src);
            addChild(node, rdNode);
            addChild(node, srcNode);
            return node;
        }

// Instrucción Logial Shift Left (LSL)
lsl_inst "Instrucción LSL"
    = _* "LSL"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LSL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "LSL"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LSL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción Logial Shift Right (LSR)
lsr_inst "Instrucción LSR"
    = _* "LSR"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LSR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "LSR"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LSR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción Arithmetical Shift Right (ASR)
asr_inst "Instrucción ASR"
    = _* "ASR"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ASR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "ASR"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ASR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción Rotate Right (ROR)
ror_inst "Instrucción ROR"
    = _* "ROR"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ROR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "ROR"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'ROR', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción Compare (CMP)
cmp_inst "Instrucción CMP"
    = _* "CMP"i _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CMP', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(src1Node, src1);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "CMP"i _* src1:reg32 _* "," _* src2:operand32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CMP', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(src1Node, src1);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Instrucción Branch (B)
b_inst "Instrucción B"
    = _* "B"i _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'B', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción BLE (Branch Less or Equal)
ble_inst "Instrucción BLE"
    = _* "BLE"i _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BLE', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Branch with Link (BL)
bl_inst "Instrucción BL"
    = _* "BL"i _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BL', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Branch with Link and Register (BLR)
blr_inst "Instrucción BLR"
    = _* "BLR"i _* src:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BLR', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(srcNode, src);
            addChild(node, srcNode);
            return node;
        }

// Instrucción Branch and Register (BR)
br_inst "Instrucción BR"
    = _* "BR"i _* src:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BR', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(srcNode, src);
            addChild(node, srcNode);
            return node;
        }

// Instrucción Compare and Branch On Zero (CBNZ)
cbnz_inst
    = _* "CBNZ"i _* src:reg64_or_reg32 _* "," _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CBNZ', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(srcNode, src);
            addChild(labelNode, l);
            addChild(node, srcNode);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Compare and Branch (CBZ)
cbz_inst
    = _* "CBZ"i _* src:reg64_or_reg32 _* "," _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CBZ', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(srcNode, src);
            addChild(labelNode, l);
            addChild(node, srcNode);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Retornar de Subrutina (RET)
ret_inst "Instrucción RET"
    = _* "RET"i _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'RET', location());
            return node;
        }

// Instrucción Test and Branch on Zero (TBNZ)
tbnz_inst
    = _* "TBNZ"i _* src:reg64_or_reg32 _* "," _* i:immediate _* "," _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'TBNZ', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(srcNode, src);
            addChild(labelNode, l);
            addChild(node, srcNode);
            addChild(node, i);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Test and Branch (TBZ)
tbz_inst
    = _* "TBZ"i _* src:reg64_or_reg32 _* "," _* i:immediate _* "," _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'TBZ', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(srcNode, src);
            addChild(node, srcNode);
            addChild(node, i);
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Salto Condicional (BEQ)
beq_inst "Instrucción BEQ"
    = _* "BEQ"i _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BEQ', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Salto Condicional (BNE)
bne_inst "Instrucción BNE"
    = _* "BNE"i _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BNE', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Salto Condicional (BGT)
bgt_inst "Instrucción BGT"
    = _* "BGT"i _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BGT', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Salto Condicional (BLT)
blt_inst "Instrucción BLT"
    = _* "BLT"i _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'BLT', location());
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Supervisor Call (SVC)
svc_inst "Instrucción SVC"
    = _* "SVC"i _* i:immediate _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SVC', location());
            const srcNode = createNode('SOURCE1', 'SRC1', location());
            addChild(srcNode, i);
            addChild(node, srcNode);
            return node;
        }

// Instrucciones atómicas

// Instrucción Compare and Swap (CAS) word or doubleword memory
cas_inst
    = _* "CAS"i "A"i? "L"i? _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CAS', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }
    / _* "CAS"i "A"i? "L"i? _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CAS', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }

// Instrucción  Swap Word or Doubleword memory in memory amotically loads (SWP/SWPA/SWPAL/SWPL)
swp_inst
    = _* "SWP"i "A"i? "L"i? _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SWP', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }
    / _* "SWP"i "A"i? "L"i? _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'SWP', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }

// Instrucciones condicionales

// Instrucción Conditional Compare Negative (CCMN)
ccmn_inst
    = _* "CCMN"i _* src1:reg64 _* "," _* src2:operand64 _* "," _* i:immediate _* "," _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CCMN', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(src1Node, src1);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, i);
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }
    / _* "CCMN"i _* src1:reg32 _* "," _* src2:operand32 _* "," _* i:immediate _* "," _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CCMN', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(src1Node, src1);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, i);
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Conditional Compare (CCMP)
ccmp_inst
    = _* "CCMP"i _* src1:reg64 _* "," _* src2:operand64 _* "," _* i:immediate _* "," _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CCMP', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(src1Node, src1);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, i);
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }
    / _* "CCMP"i _* src1:reg32 _* "," _* src2:operand32 _* "," _* i:immediate _* "," _* l:label _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CCMP', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(src1Node, src1);
            addChild(node, src1Node);
            addChild(node, src2);
            addChild(node, i);
            const labelNode = createNode('LABEL', 'LBL', location());
            addChild(labelNode, l);
            addChild(node, labelNode);
            return node;
        }

// Instrucción Conditional Increment (CINC)
cinc_inst
    = _* "CINC"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CINC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CINC"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CINC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Instrucción Conditional Invert (CINV)
cinv_inst
    = _* "CINV"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CINV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CINV"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CINV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Instrucción Conditional Negate (CNEG)
cneg_inst
    = _* "CNEG"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CNEG', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CNEG"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CNEG', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Instrucción Conditional select (CSEL)
csel_inst
    = _* "CSEL"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSEL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CSEL"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSEL', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Instrucción Conditional Set (CSET)
cset_inst
    = _* "CSET"i _* rd:reg64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSET', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            addChild(rdNode, rd);
            addChild(node, rdNode);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CSET"i _* rd:reg32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSET', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            addChild(rdNode, rd);
            addChild(node, rdNode);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Instrucción Conditional Set Mask (CSETM)
csetm_inst
    = _* "CSETM"i _* rd:reg64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSETM', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            addChild(rdNode, rd);
            addChild(node, rdNode);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CSETM"i _* rd:reg32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSETM', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            addChild(rdNode, rd);
            addChild(node, rdNode);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Instrucción Conditional Select Increment (CSINC)
csinc_inst
    = _* "CSINC"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSINC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CSINC"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSINC', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Instrucción para condiciones: EQ, NE, CS, CC, MI, PL, VS, VC, HI, LS, GE, LT, GT, LE, AL y NV
condition_inst
    = "EQ"i
        {
            const node = createNode('CONDITION', 'EQ', location());
            return node;
        }
    / "NE"i
        {
            const node = createNode('CONDITION', 'NE', location());
            return node;
        }
    / "CS"i
        {
            const node = createNode('CONDITION', 'CS', location());
            return node;
        }
    / "CC"i
        {
            const node = createNode('CONDITION', 'CC', location());
            return node;
        }
    / "MI"i
        {
            const node = createNode('CONDITION', 'MI', location());
            return node;
        }
    / "PL"i
        {
            const node = createNode('CONDITION', 'PL', location());
            return node;
        }
    / "VS"i
        {
            const node = createNode('CONDITION', 'VS', location());
            return node;
        }
    / "VC"i
        {
            const node = createNode('CONDITION', 'VC', location());
            return node;
        }
    / "HI"i
        {
            const node = createNode('CONDITION', 'HI', location());
            return node;
        }
    / "LS"i
        {
            const node = createNode('CONDITION', 'LS', location());
            return node;
        }
    / "GE"i
        {
            const node = createNode('CONDITION', 'GE', location());
            return node;
        }
    / "LT"i
        {
            const node = createNode('CONDITION', 'LT', location());
            return node;
        }
    / "GT"i
        {
            const node = createNode('CONDITION', 'GT', location());
            return node;
        }
    / "LE"i
        {
            const node = createNode('CONDITION', 'LE', location());
            return node;
        }
    / "AL"i
        {
            const node = createNode('CONDITION', 'AL', location());
            return node;
        }
    / "NV"i
        {
            const node = createNode('CONDITION', 'NV', location());
            return node;
        }

// Instrucción Conditional Select Invert (CSINV)
csinv_inst
    = _* "CSINV"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSINV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CSINV"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSINV', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Instrucción Conditional Select Negate (CSNEG)
csneg_inst
    = _* "CSNEG"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSNEG', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }
    / _* "CSNEG"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand32 _* "," _* condition:condition_inst _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CSNEG', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            const conditionNode = createNode('CONDITION', 'COND', location());
            addChild(conditionNode, condition);
            addChild(node, conditionNode);
            return node;
        }

// Registros de propósito general 64 bits (limitado a los registros válidos de ARM64)
reg64 "Registro_64_Bits"
    = "x"i ("30" / [12][0-9] / [0-9])
        {
            const node = createNode('RG_64_BITS', 'reg64', location());
            setValue(node, text());
            return node;
        }
    / "SP"i // Stack Pointer
        {
            const node = createNode('R_STACK_POINTER', 'SP', location());
            setValue(node, text());
            return node;
        }
    / "LR"i  // Link Register
        {
            const node = createNode('R_LINK_REGISTER', 'LR', location());
            setValue(node, text());
            return node;
        }
    / "ZR"i  // Zero Register
        {
            const node = createNode('R_ZERO_REGISTER', 'ZR', location());
            setValue(node, text());
            return node;
        }
    / "PC"i  // Program Counter
        {
            const node = createNode('R_PROGRAM_COUNTER', 'PC', location());
            setValue(node, text());
            return node;
        }
    / "XZR"i // Zero Register
        {
            const node = createNode('R_ZERO_REGISTER', 'ZR', location());
            setValue(node, text());
            return node;
        }

// INSTRUCCIONES DE SUMA DE COMPROBACIÓN

// Instrucción Checksum (CRC32B/ CRC32H/ CRC32W/ CRC32X)
crc32_inst
    =  _* "CRC32"i "C"i? "B"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CRC32B', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }
    / _* "CRC32"i "C"i? "H"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CRC32H', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }
    / _* "CRC32"i "C"i? "W"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:reg32 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CRC32W', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }
    / _* "CRC32"i "C"i? "X"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:reg64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'CRC32X', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            const src2Node = createNode('SOURCE2', 'SRC2', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(src2Node, src2);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2Node);
            return node;
        }

// INSTRUCCIONES DE CARGA Y ALMACENAMIENTO CON ATRIBUTOS

// Instrucción LD (Load)
ld_inst
    = _* "LD"i _* rd:reg64 _* "," _* src1:reg64 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LD', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }
    / _* "LD"i _* rd:reg32 _* "," _* src1:reg32 _* "," _* src2:operand64 _* comment? "\n"?
        {
            const node = createNode('INSTRUCTION', 'LD', location());
            const rdNode = createNode('DESTINATION', 'RD', location());
            const src1Node = createNode('SOURCE1', 'SRC1', location());
            addChild(rdNode, rd);
            addChild(src1Node, src1);
            addChild(node, rdNode);
            addChild(node, src1Node);
            addChild(node, src2);
            return node;
        }

// Registros de propósito general 32 bits (limitado a los registros válidos de ARM64)
reg32 "Registro_32_Bits"
    = "w"i ("30" / [12][0-9] / [0-9])
        {
            const node = createNode('RG_32_BITS', 'reg32', location());
            setValue(node, text());
            return node;
        }

// Operando puede ser un registro o un número inmediato
operand64 "Operandor 64 Bits"
    = r:reg64 _* "," _* ep:extend_op                 // Registro con extensión de tamaño
        {
            const node = createNode('SOURCE2', 'SRC2', location());
            addChild(node, r);
            if(ep){
            addChild(node, ep);
            }
            return node;
        }  
    / r:reg64 lp:(_* "," _* shift_op _* immediate)?  // Registro con desplazamiento lógico opcional
        {
            const node = createNode('SOURCE2', 'SRC2', location());
            addChild(node, r);
            if(lp){
                addChild(node, lp[3]);
                addChild(node, lp[5]);
            }
            return node;
        }   
    / i:immediate                                     // Valor inmediato
        {
            const node = createNode('SOURCE2', 'SRC2', location());
            addChild(node, i);
            return node;
        }                             

// Operando puede ser un registro o un número inmediato
operand32 "Operandor 32 Bits"
    = r:reg32 lp:(_* "," _* shift_op _* immediate)?  // Registro con desplazamiento lógico
        {
            const node = createNode('SOURCE2', 'SRC2', location());
            addChild(node, r);
            if(lp){
                addChild(node, lp[3]);
                addChild(node, lp[5]);
            }
            return node;
        }
    / i:immediate                             // Valor inmediato
        {
            const node = createNode('SOURCE2', 'SRC2', location());
            addChild(node, i);
            return node;
        }

// Definición de desplazamientos
shift_op "Operador de Desplazamiento"
    = "LSL"i
        {
            const node = createNode('LOGICAL_SHIFT_LEFT', 'LSL', location());
            setValue(node, text());
            return node;
        } 
    / "LSR"i
        {
            const node = createNode('LOGICAL_SHIFT_RIGHT', 'LSR', location());
            setValue(node, text());
            return node;
        } 
    / "ASR"i
        {
            const node = createNode('ARITHMETIC_SHIFT_RIGHT', 'ASR', location());
            setValue(node, text());
            return node;
        }

// Definición de extensiones
extend_op "Operador de Extensión"
    = "UXTB"i
        {
            const node = createNode('UNSIGNED_EXTEND_BYTE', 'UXTB', location());
            setValue(node, text());
            return node;
        }
    / "UXTH"i 
        {
            const node = createNode('UNSIGNED_EXTEND_HALFWORD', 'UXTH', location());
            setValue(node, text());
            return node;
        }
    / "UXTW"i 
        {
            const node = createNode('UNSIGNED_EXTEND WORD', 'UXTW', location());
            setValue(node, text());
            return node;
        }
    / "UXTX"i
        {
            const node = createNode('UNSIGNED_EXTEND_DOUBLEWORD', 'UXTX', location());
            setValue(node, text());
            return node;
        }
    / "SXTB"i
        {
            const node = createNode('SIGNED_EXTEND_BYTE', 'SXTB', location());
            setValue(node, text());
            return node;
        }
    / "SXTH"i
        {
            const node = createNode('SIGNED_EXTEND_HALFWORD', 'SXTH', location());
            setValue(node, text());
            return node;
        }
    / "SXTW"i 
        {
            const node = createNode('SIGNED_EXTEND_WORD', 'SXTW', location());
            setValue(node, text());
            return node;
        }
    / "SXTX"i
        {
            const node = createNode('SIGNED_EXTEND_DOUBLEWORD', 'SXTX', location());
            setValue(node, text());
            return node;
        }

// Definición de valores inmediatos
immediate "Inmediato"
    = "#"? "0b" binary_literal
        {
            const node = createNode('INMEDIATE_OP', '#', location());
            setValue(node, text());
            return node;
        }
    / ("+"/"-")? integer
        {
            const node = createNode('INMEDIATE_OP', 'Integer', location());
            setValue(node, text());
            return node;
        }
    / "#"? "'"letter"'"
        {
            const node = createNode('INMEDIATE_OP', '#', location());
            setValue(node, text());
            return node;
        }
    / "#"? "0x"? hex_literal
        {
            const node = createNode('INMEDIATE_OP', '#', location());
            setValue(node, text());
            return node;
        }
    / "#" integer
        {
            const node = createNode('INMEDIATE_OP', '#', location());
            setValue(node, text());
            return node;
        }

binary_literal
  = [01]+ // Representa uno o más dígitos binarios
hex_literal
    = [0-9a-fA-F]+ // Representa uno o más dígitos hexadecimales
letter
    = [a-zA-Z] 
// Expresiones
expression "Espresión"
    = integer
        {
            const node = createNode('INTEGER', 'Integer', location());
            setValue(node, text());
            return node;
        }

// Etiqueta
label "Etiqueta"
    = [a-zA-Z_][a-zA-Z0-9_]*
        {
            const node = createNode('LABEL', 'Label', location());
            setValue(node, text());
            return node;
        }

// Número entero
integer "Numero Entero"
    = [0-9]+

// Cadena ASCII
string "Cadena de Texto"
    = '"' ([^"]*) '"'
    {
        const node = createNode('STRING', 'String', location());
        setValue(node, text().slice(1, -1));
        return node;
    }

// Línea en blanco
blank_line "Linea En Blanco"
    = _* comment? "\n"
        {
            const node = createNode('EMPTY', 'Empty');
            return node;
        }

// Comentarios
comment "Comentario"
    = ("//" [^\n]*) 
        {
            const node = createNode('COMMENT', 'Comment');
            setValue(node, text());
            return node;
        }
  / (";" [^\n]*)
        {
            const node = createNode('COMMENT', 'Comment');
            setValue(node, text());
            return node;
        }

mcomment "Comentario Multilinea"
    = "/*" ([^*] / [*]+ [^*/])* "*/"
        {
            const node = createNode('COMMENT', 'Comment');
            setValue(node, text());
            return node;
        }
// Espacios en blanco
_ "Ignorado"
    = [ \t]+
