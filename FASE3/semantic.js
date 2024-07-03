let labels = [];
let variables = [];
let bss = [];
let registers = [];
let currentIndex = 0;
let currentFileContent = '';
let currentFileName = '';
let errors = [];
let output = '';
let svcExit = false;
let currentLine = 0;
let currentColumn = 0;

// Funciones de inicialización
function init(c3d) {
    currentIndex = 0;
    currentFileContent = '';
    currentFileName = '';
    currentLine = 0;
    currentColumn = 0;
    svcExit = false;
    errors = [];
    output = '';
    labels = getLabels(c3d);
    variables = getVariables(c3d);
    bss = getBss(c3d);
    registers = getRegisters();
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

// Función para obtener los registros
function getRegisters() {
    return [
        { register: 'w0', value: 0, offset: 0 },
        { register: 'w1', value: 0, offset: 0 },
        { register: 'w2', value: 0, offset: 0 },
        { register: 'w3', value: 0, offset: 0 },
        { register: 'w4', value: 0, offset: 0 },
        { register: 'w5', value: 0, offset: 0 },
        { register: 'w6', value: 0, offset: 0 },
        { register: 'w7', value: 0, offset: 0 },
        { register: 'w8', value: 0, offset: 0 },
        { register: 'w9', value: 0, offset: 0 },
        { register: 'w10', value: 0, offset: 0 },
        { register: 'w11', value: 0, offset: 0 },
        { register: 'w12', value: 0, offset: 0 },
        { register: 'w13', value: 0, offset: 0 },
        { register: 'w14', value: 0, offset: 0 },
        { register: 'w15', value: 0, offset: 0 },
        { register: 'w16', value: 0, offset: 0 },
        { register: 'w17', value: 0, offset: 0 },
        { register: 'w18', value: 0, offset: 0 },
        { register: 'w19', value: 0, offset: 0 },
        { register: 'w20', value: 0, offset: 0 },
        { register: 'w21', value: 0, offset: 0 },
        { register: 'w22', value: 0, offset: 0 },
        { register: 'w23', value: 0, offset: 0 },
        { register: 'w24', value: 0, offset: 0 },
        { register: 'w25', value: 0, offset: 0 },
        { register: 'w26', value: 0, offset: 0 },
        { register: 'w27', value: 0, offset: 0 },
        { register: 'w28', value: 0, offset: 0 },
        { register: 'w29', value: 0, offset: 0 },
        { register: 'w30', value: 0, offset: 0 },
        { register: 'w31', value: 0, offset: 0 },
        { register: 'x0', value: 0, offset: 0 },
        { register: 'x1', value: 0, offset: 0 },
        { register: 'x2', value: 0, offset: 0 },
        { register: 'x3', value: 0, offset: 0 },
        { register: 'x4', value: 0, offset: 0 },
        { register: 'x5', value: 0, offset: 0 },
        { register: 'x6', value: 0, offset: 0 },
        { register: 'x7', value: 0, offset: 0 },
        { register: 'x8', value: 0, offset: 0 },
        { register: 'x9', value: 0, offset: 0 },
        { register: 'x10', value: 0, offset: 0 },
        { register: 'x11', value: 0, offset: 0 },
        { register: 'x12', value: 0, offset: 0 },
        { register: 'x13', value: 0, offset: 0 },
        { register: 'x14', value: 0, offset: 0 },
        { register: 'x15', value: 0, offset: 0 },
        { register: 'x16', value: 0, offset: 0 },
        { register: 'x17', value: 0, offset: 0 },
        { register: 'x18', value: 0, offset: 0 },
        { register: 'x19', value: 0, offset: 0 },
        { register: 'x20', value: 0, offset: 0 },
        { register: 'x21', value: 0, offset: 0 },
        { register: 'x22', value: 0, offset: 0 },
        { register: 'x23', value: 0, offset: 0 },
        { register: 'x24', value: 0, offset: 0 },
        { register: 'x25', value: 0, offset: 0 },
        { register: 'x26', value: 0, offset: 0 },
        { register: 'x27', value: 0, offset: 0 },
        { register: 'x28', value: 0, offset: 0 },
        { register: 'x29', value: 0, offset: 0 },
        { register: 'x30', value: 0, offset: 0 },
        { register: 'x31', value: 0, offset: 0 },
        { register: 'pc', value: 0, offset: 0 },
        { register: 'sp', value: 0, offset: 0 },
        { register: 'lr', value: 0, offset: 0 },
        { register: 'N', value: 0, offset: 0 },
        { register: 'Z', value: 0, offset: 0 },
        { register: 'C', value: 0, offset: 0 },
        { register: 'V', value: 0, offset: 0 }
    ];
}

// Función para obtener el valor de un operador1 y operador2
function getValue(operador) {
    // Eliminarmos # si es que lo tiene (verificar si es un string)
    if(typeof operador === 'string') {
        operador = operador.replace('#', '');
        operador = operador.replace('=', '');

        // Si es un binario con una expresión regular que comienza con 0b
        if(operador.startsWith("0b")) {
            let bin = parseInt(operador.substring(2), 2);
            return parseInt(operador.substring(2), 2);
        }

        // Si es un número
        if(!isNaN(operador)) {
            return parseInt(operador, 10);
        }

        // Si es un hexadecimal con una expresión regular
        if(operador.match(/^[0-9a-fA-F]+$/)) {
            return parseInt(operador, 16);
        }
        // Si es un registro
        let register = registers.find(r => r.register === operador);
        if(register) {
            return register;
        }
        // Si es un label
        let label = labels.find(l => l.label === operador);
        if(label) {
            return label.index;
        }
        // Si es una cadena tipo 'hola'
        if(operador.startsWith("'") && operador.endsWith("'")) {
            return operador;
        }
        // Si es un registro con [ ]
        if(operador.includes('[') && operador.includes(']')) {
            let rgs = operador.substring(1, operador.length - 1);
            let values = rgs.split(',');
            if (values.length === 1) {
                let reg = registers.find(r => r.register === values[0]);
                if(reg) {
                    let clone = Object.assign({}, reg);
                    return clone;
                }
            } else if (values.length === 2) {
                let reg = registers.find(r => r.register === values[0]);
                if(reg) {
                    let clone = Object.assign({}, reg);
                    clone.offset = parseInt(values[1], 10) + values[2];
                    return clone;
                }
            }
            
        }
        // si es una variable en el arreglo de variables
        let variable = variables.find(v => v.variable === operador);
        if(variable) {
            return variable;
            
        }
        
        // Si es una variable en el arreglo de bss
        let bssVar = bss.find(v => v.variable === operador);
        if(bssVar) {
            return bssVar;
        }
    }

}

// Función para convertir números a caracter ascii
function numberToChar(number) {
    return parseInt(number, 10) + 48;
}

// Función para convertir un caracter ascii a número
function charToNumber(char) {
    return String.fromCharCode(parseInt(char, 10));
}

// Función para actualizar las banderas
function updateFlags(result) {
    // Obteniendo las flags
    let N = registers.find(r => r.register === 'N');
    let Z = registers.find(r => r.register === 'Z');
    let C = registers.find(r => r.register === 'C');
    let V = registers.find(r => r.register === 'V');
    // N
    N.value = result < 0 ? 1 : 0;
    // Z
    Z.value = result === 0 ? 1 : 0;
    // C
    C.value = result >= 0 ? 1 : 0;
    // V
    V.value = 0;
}

// Función para abrir un archivo en el computador
const openFileSemantic = async (filename) => {
    let fileContentResult = '';
    const { value: file } = await Swal.fire({
        title: 'Select File',
        input: 'file',
        inputAttributes: {
            'accept': 'text/*',
            'aria-label': 'Upload your file'
        },
        showCancelButton: true
    });
    
    if (!file) return;

    return new Promise((resolve, reject) => {
        let reader = new FileReader();

        reader.onload = (e) => {
            const fileContent = e.target.result;
            console.log('fileContentResult', fileContent);
            currentFileName = file.name;
            currentFileContent = fileContent;
            resolve({ filename: file.name, fileContent });
        };

        reader.onerror = (e) => {
            console.log("Error reading file", e.target.error);
            errors.push({error: `Error al leer el archivo: ${file.name}`, type: 'semántico', line: currentLine, column: currentColumn});
            reject(e.target.error);
        };

        reader.readAsText(file);
    });
};

// Función para escribir un archivo en el computador
const saveFileSemantic = async (data) => {
    if(!currentFileName || currentFileName === '') {
        errors.push({error: `No se ha abierto un archivo`, type: 'semántico', line: currentLine, column: currentColumn});
    };
    let filename = currentFileName.split('.')[0];
    const extension = currentFileName.split('.')[1];
    if (filename === '') {
        const { value: name } = await Swal.fire({
            title: 'Enter File name',
            input: 'text',
            inputLabel: 'File name',
            showCancelButton: true,
            inputValidator: (value) => {
                if (!value) {
                    return 'You need to write something!'
                }
            }
        })
        filename = name;
    }
    if (filename) {
        download(`${filename}.${extension}`, data)
    }
}

// Función para cerrar un archivo en el computador
function closeFileSemantic(filename) {
    currentFileName = '';
    currentFileContent = '';
}

function readFile(variable) {
    variable.value = currentFileContent;
    console.log('readFile', variable, currentFileContent)
}

// Función para ejecutar el código c3d
async function accept(c3d) {
    init(c3d);
    try {
        while(currentIndex < c3d.length && !svcExit) {
            await executeLine(c3d);
        }
    } catch (error) {
        console.log('error', error);
    }
}

// Función para debuggear (solamente inicializa las variables)
// Se debe llamar a executeLine para ejecutar línea por línea
function debug(c3d) {
    init(c3d);
}

// Función para ejecutar línea por línea el código c3d
async function executeLine(c3d) {
    let line = c3d[currentIndex];
    currentLine = line.line;
    currentColumn = line.column;
    if(line.resultado === '.global') {
        executeGlobal(line);
    } else if (line.operacion !== '') {
        await executeInstruction(line);
    }
    currentIndex++;
}

// Función para ejecutar una instrucción global
// buscar en el arreglo de labels el label de inicio de ejecución
function executeGlobal(line) {
    let label = labels.find(l => l.label === line.operador1);
    if(!label) {
        errors.push({error: `No se encontró el label: ${line.operador1} de inicio de ejecución`, type: 'semántico', line: currentLine, column: currentColumn});
        // svcExit = true;
    }
        
}

// Función para ejecutar una instrucción
// Este método llama a otras funciones en base a la operación
async function executeInstruction(line) {
    switch(line.operacion) {
        case 'MOV':
            mov(line.resultado, line.operador1);
            break;
        case 'SVC':
            await svc(line.resultado);
            break;
        case 'LDR':
            ldr(line.resultado, line.operador1);
            break;
        case 'ADD':
            add(line.resultado, line.operador1, line.operador2);
            break;
        case 'SUB':
            sub(line.resultado, line.operador1, line.operador2);
            break;
        case 'MUL':
            mul(line.resultado, line.operador1, line.operador2);
            break;
        case 'SDIV':
            sdiv(line.resultado, line.operador1, line.operador2);
            break
        case 'UDIV':
            udiv(line.resultado, line.operador1, line.operador2);
            break;
        case 'ADDS':
            adds(line.resultado, line.operador1, line.operador2);
            break;
        case 'SUBS':
            subs(line.resultado, line.operador1, line.operador2);
            break
        case 'LDRB':
            ldrb(line.resultado, line.operador1);
            break;
        case 'UXTB':
            uxtb(line.resultado, line.operador1);
            break;
        case 'AND':
            and(line.resultado, line.operador1, line.operador2);
            break;
        case 'ORR':
            orr(line.resultado, line.operador1, line.operador2);
            break;
        case 'EOR':
            eor(line.resultado, line.operador1, line.operador2);
            break;
        case 'ANDS':
            ands(line.resultado, line.operador1, line.operador2);
            break;
        case 'STRB':
            strb(line.resultado, line.operador1);
            break;
        case 'ASR':
            asr(line.resultado, line.operador1, line.operador2);
            break;
        case 'LSR':
            lsr(line.resultado, line.operador1, line.operador2);
            break;
        case 'LSL':
            lsl(line.resultado, line.operador1, line.operador2);
            break;
        case 'ASL':
            asl(line.resultado, line.operador1, line.operador2);
            break;
        case 'ROR':
            ror(line.resultado, line.operador1, line.operador2);
            break;
        case 'CMP':
            cmp(line.resultado, line.operador1);
            break;
        case 'B':
            b(line.resultado);
            break;
        case 'BL':
            bl(line.resultado);
            break;
        case 'BEQ':
            beq(line.resultado);
            break;
        case 'BNE':
            bne(line.resultado);
            break;
        case 'BLT':
            blt(line.resultado);
            break;
        case 'BLE':
            ble(line.resultado);
            break;
        case 'BGT':
            bgt(line.resultado);
            break;
        case 'BGE':
            bge(line.resultado);
            break;
            case '.align':
            case '.ascii':
            case '.asciz':
            case '.string':
            case '.byte':
            case '.half':
            case '.word':
            case '.dword':
            case '.hword':
            case '.quad':
            case '.skip':
            case '.data':
            case '.text':
            case '.bss':
            case '.section':
            case '.global':
            case '.equ':
            case '.extern':
            case '.file':
            case '.type':
            case '.size':
            case '.ident':
            case '.p2align':
            case '.zero':
            case '.space':
            case '.set':
            case '.incbin':
                break;
        default:
            errors.push({error: `No se encontró la operación: ${line.operacion}`, type: 'semántico', line: currentLine, column: currentColumn});
            break;
    }
}

function mov(register, value) {
    updateOutConsole('asignar', register,'=', value)
    let reg = registers.find(r => r.register === register);
    value = getValue(value);
    if(value === null) {
        errors.push({error: `No se encontró el valor: ${value}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(reg) {
        if(value.register && value.register.includes('x')) value = value.value;
        if(value.register && value.register.includes('w')) value = value.value;

        // if(isNaN(valueResult)) {
        //     errors.push({error: `El valor asignado no es un número: ${value}`, type: 'semántico', line: currentLine, column: currentColumn});
        //     return;
        // }

        reg.value = value;
    }
}

// Función para ejecutar la instrucción SVC
// Esta instrucción verifica si el registro x8 tiene un valor 93 para finalizar la ejecución
// Si el registro x8 tiene un valor de 64 entonces imprime el valor del registro x0
async function svc(value) {
    let x8 = registers.find(r => r.register === 'x8');
    value = getValue(value);
    if(value === null) {
        errors.push({error: `No se encontró el valor: ${value}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }
    let x0 = registers.find(r => r.register === 'x0');
    // Si el valor es 64 y x0 es 1 entonces se imprime el valor de x0
    // si el valor de x8 es 93 entonces se finaliza la ejecución
    // Si el valor de x8 es 63 entonces se lee un valor
    if(x8 && x8.value === 64 && x0 && x0.value === 1) {
        let x1 = registers.find(r => r.register === 'x1');
        if(x1.value === undefined) {
            errors.push({error: `No se encontró el valor de x1`, type: 'semántico', line: currentLine, column: currentColumn});
            return;
        }
        let x1Value = getValue(x1.value);
        output += x1Value.value + '\n';
        updateOutConsole('imprimir', x8.value,'=', 'x8')
        updateOutConsole('imprimir', x0.value,'=', 'x0')
    } else if (x8 && x8.value === 93) {
        output += x0.value + ' ' + x0.offset + '\n';
        output += 'Finalizando ejecución';
        svcExit = true;
        updateOutConsole('finalizar', x8.value,'=', 'x8')
    } else if(x8 && x8.value === 63 && x0 && x0.value === 0) {
        let x1 = registers.find(r => r.register === 'x1');
        if (x1 === undefined) {
            errors.push({error: `No se encontró el valor de x1`, type: 'semántico', line: currentLine, column: currentColumn});
            return;
        }
        let x1Value = getValue(x1.value);
        let input = await Swal.fire({
            title: 'Ingrese un valor',
            input: 'text',
            inputLabel: 'Input value',
            inputPlaceholder: 'Enter your value here'
        });
        x1Value.value = input.value;
        updateOutConsole('leer', x8.value,'=', 'x8')
    } else if (x8 && x8.value === 56 && x0 && x0.value === -100) {
        let x2 = registers.find(r => r.register === 'x2');
        let x3 = registers.find(r => r.register === 'x3');
        // if ((x2 && x2.value !== 101 && x3 && x3.value !== 777) || (x2 && x2.value !== 0)) {
        //     errors.push({error: `No se poseen los permisos requeridos para abrir el archivo.`, type: 'semántico', line: 0, column: 0});
        //     return;
        // }
        let x1 = registers.find(r => r.register === 'x1');
        if (x1 === undefined) {
            errors.push({error: `No se encontró el valor de x1`, type: 'semántico', line: currentLine, column: currentColumn});
            return;
        }
        let x1Value = getValue(x1.value);
        if (x2 && x2.value === 0) {
            const { filename, fileContent } = await openFileSemantic(x1Value.value);
            currentFileContent = fileContent;
            currentFileName = filename;
        } else {
            currentFileContent = '';
            currentFileName = x1Value.value;
        }
        updateOutConsole('leer', x8.value,'=', 'x8');
    
    } else if(x8 && x8.value === 63 && x0 && x0.value === -100) {
        let x1 = registers.find(r => r.register === 'x1');
        if (x1 === undefined) {
            errors.push({error: `No se encontró el valor de x1`, type: 'semántico', line: currentLine, column: currentColumn});
            return;
        }
        let x1Value = getValue(x1.value);
        readFile(x1Value);
        updateOutConsole('leer', x8.value,'=', 'x8')
    } else if(x8 && x8.value === 64 && x0 && x0.value === -100) { // valor 64 para escribir un archivo
        let x1 = registers.find(r => r.register === 'x1');
        if (x1 === undefined) {
            errors.push({error: `No se encontró el valor de x1`, type: 'semántico', line: currentLine, column: currentColumn});
            return;
        }
        let x1Value = getValue(x1.value);
        await saveFileSemantic(x1Value.value);
        updateOutConsole('escribir', x8.value,'=', 'x8')
    } 
}

// Función para imprimir u obtener algo (input / output) ldr
function ldr(register, value) {
    let reg = registers.find(r => r.register === register);
    let valueResult = getValue(value);
    
    if(valueResult === null || valueResult === undefined) {
        errors.push({error: `No se encontró el valor: ${value}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(reg) {
        // Almacenamos el nombre de la variable en el registro (por lo general x1)
        reg.value = valueResult.variable;
        updateOutConsole('imprimir', register,'=',valueResult.variable )
    }

}

// Función para cargar valores a registros ldrb
function ldrb(register, value) {
    let reg = registers.find(r => r.register === register);
    let valueResult = getValue(value);
    if(valueResult === null || valueResult === undefined) {
        errors.push({error: `No se encontró el valor: ${value}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(reg) {
        // Almacenamos el nombre de la variable en el registro (por lo general x1)
        let variable = getValue(valueResult.value);
        reg.value = variable.value.charAt(valueResult.offset);
        updateOutConsole('leer', register,'=', reg.value )
    }

}

// FUNCIONES ARITMÉTICAS
// Función add
function add(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1,'+',op2)
    // if(isNaN(value1.value)) {
    //     errors.push({error: `El valor asignado no es un número: ${value1.value}`, type: 'semántico', line: currentLine, column: currentColumn});
    //     return;
    // }
    if(reg.register.includes('x')) {
        if (value2.register && value2.register.includes('x')) value2 = value2.value;

        // if(isNaN(value2)) {
        //     errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
        //     return;
        // }

        reg.offset = value1.offset + value2;
        //updateOutputConsoleOP(register,op1,'+',op2)
        updateOutConsole('SUMA',register,'=', reg.offset )
    } else {
        if (value2.register && value2.register.includes('w')) value2 = value2.value;

        if(isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return;
        }

        reg.value = parseInt(value1.value, 10) + parseInt(value2, 10);
        //updateOutputConsoleOP(register,op1,'+',op2)
        updateOutConsole('SUMA',register,'=', reg.value )
    }
}

// Función sub
function sub(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1,'-',op2)
    if (isNaN(value1.value)) {
        errors.push({error: `El valor asignado no es un número: ${value1.value}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }
    if(reg.register.includes('x')) {
        if (value2.register && value2.register.includes('x')) value2 = value2.value;

        if(isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return;
        }
        reg.value = parseInt(value1.value, 10) - parseInt(value2, 10);
        updateOutConsole('RESTA',register,'=', reg.value )
    } else {
        if (value2.register && value2.register.includes('w')) value2 = value2.value;
        if(isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return
        }
        reg.value = numberToChar(value1.value) - value2;
        console.log('reg.value', reg);
        updateOutConsole('RESTA',register,'=', reg.value )
    }
}

// Función mul PENDIENTE
function mul(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    if (isNaN(value1.value)) {
        errors.push({error: `El valor asignado no es un número: ${value1.value}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    updateOutputConsoleOP(register,op1,'*',op2)
    if(reg.register.includes('x')) {
        if (value2.register && value2.register.includes('x')) value2 = value2.value;
        if (isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return
        }
        reg.value = parseInt(value1.value, 10) * parseInt(value2, 10);
        updateOutConsole('MUL',register,'=', reg.value )
    } else {
        if (value2.register && value2.register.includes('w')) value2 = value2.value;
        if (isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return
        }
        reg.value = numberToChar(value1.value) * numberToChar(value2);
        updateOutConsole('MUL',register,'=', reg.value )
    }
}

//Función sdiv
function sdiv(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    if (isNaN(value1.value)) {
        errors.push({error: `El valor asignado no es un número: ${value1.value}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }
    updateOutputConsoleOP(register,op1,'/',op2)
    if(reg.register.includes('x')) {
        if (value2.register && value2.register.includes('x')) value2 = value2.value;
        if (isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return
        }
        reg.value = parseInt(value1.value, 10) / parseInt(value2, 10);
        updateOutConsole('SDIV',register,'=', reg.value )
    } else {
        if (value2.register && value2.register.includes('w')) value2 = value2.value;
        if (isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return
        }
        reg.value = numberToChar(value1.value) / numberToChar(value2);
        updateOutConsole('SDIV',register,'=', reg.value )
    }
}

// Función udiv
function udiv(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    if (isNaN(value1.value)) {
        errors.push({error: `El valor asignado no es un número: ${value1.value}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }
    updateOutputConsoleOP(register,op1,'/',op2)
    if(reg.register.includes('x')) {
        if (value2.register && value2.register.includes('x')) value2 = value2.value;
        if (isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return
        }
        reg.value = parseInt(value1.value, 10) / parseInt(value2, 10);
        updateOutConsole('UDiV',register,'=', reg.value )
    } else {
        if (value2.register && value2.register.includes('w')) value2 = value2.value;
        if (isNaN(value2)) {
            errors.push({error: `El valor asignado no es un número: ${value2}`, type: 'semántico', line: currentLine, column: currentColumn});
            return
        }
        reg.value = numberToChar(value1.value) / numberToChar(value2);
        updateOutConsole('UDIV',register,'=', reg.value )
    }
    reg.value = Math.abs(reg.value);
}

// Funciones aritméticas que actualizan las banderas
// Función adds
function adds(register, op1, op2) {
    add(register, op1, op2);
    let reg = registers.find(r => r.register === register);
    updateFlags(reg.value);
    updateOutputConsoleOP(register,op1,'=>',op2)
    updateOutConsole('ADDs',register,'=', reg.value )
}

// Función subs
function subs(register, op1, op2) {
    sub(register, op1, op2);
    let reg = registers.find(r => r.register === register);
    updateFlags(reg.value);
    updateOutputConsoleOP(register,op1,'=>',op2)
    updateOutConsole('SUBs',register,'=', reg.value )
}

// FUNCIONES DE EXTENSIÓN
// Función de extensión de byte uxtb
function uxtb(register, value) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(value);
    if(reg) {
        reg.value = value1.value;
        updateOutConsole('uxtb',register,'=', reg.value )
    }
}

// FUNCIONES LÓGICAS
// Función and
function and(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1,'&&',op2)
    if(reg) {
        if(value2.register && value2.register.includes('x')) value2 = value2.value;
        if(value2.register && value2.register.includes('w')) value2 = value2.value;
        if(value1.register && value1.register.includes('x')) value1 = value1.value;
        if(value1.register && value1.register.includes('w')) value1 = value1.value;
        reg.value = value1 & value2;
        updateOutConsole('funcionAND',register,'=', reg.value )
    }
}

// Función orr
function orr(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1,'||',op2)
    if(reg) {
        if(value2.register && value2.register.includes('x')) value2 = value2.value;
        if(value2.register && value2.register.includes('w')) value2 = value2.value;
        if(value1.register && value1.register.includes('x')) value1 = value1.value;
        if(value1.register && value1.register.includes('w')) value1 = value1.value;
        reg.value = value1 | value2;
        updateOutConsole('funcionAND',register,'=', reg.value )
    }
}

// Función eor
function eor(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1,'^^',op2)
    if(reg) {
        if(value2.register && value2.register.includes('x')) value2 = value2.value;
        if(value2.register && value2.register.includes('w')) value2 = value2.value;
        if(value1.register && value1.register.includes('x')) value1 = value1.value;
        if(value1.register && value1.register.includes('w')) value1 = value1.value;
        reg.value = value1 ^ value2;
        updateOutConsole('funcionEOR',register,'=', reg.value )
    }
}

// Función mvn
function mvn(register, value) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(value);
    if(reg) {
        if(value1.register && value1.register.includes('x')) value1 = value1.value;
        if(value1.register && value1.register.includes('w')) value1 = value1.value;
        reg.value = ~value1;
        updateOutConsole('funcionMVN',register,'=', reg.value )
    }
}

// Funciones lógicas que actualizan las banderas
// Función ands
function ands(register, op1, op2) {
    and(register, op1, op2);
    let reg = registers.find(r => r.register === register);
    updateFlags(reg.value);
    updateOutputConsoleOP(register,op1,'=>',op2)
    updateOutConsole('FLBands',register,'=', reg.value )

}

// FUNCIONES RELACIONALES
// Función cmp
function cmp(register, value) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(value);
    if(reg) {
        if(value1.register && value1.register.includes('x')) value1 = value1.value;
        if(value1.register && value1.register.includes('w')) value1 = value1.value;
        let result = reg.value - value1;
        updateFlags(result);
        updateOutConsole('FuncionCMP',register,'=', result )
    }
}

// Función b
function b(label) {
    let l = labels.find(l => l.label === label);
    // Verificar si el label existe
    if(!l) {
        errors.push({error: `No se encontró el label: ${label}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }
    updateOutConsole('FuncionB',label,'=', l )
    currentIndex = l.index;
}

// Función bl
function bl(label) {
    let l = labels.find(l => l.label === label);

    // Verificar si el label existe
    if(!l) {
        errors.push({error: `No se encontró el label: ${label}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    let lr = registers.find(r => r.register === 'lr');
    lr.value = currentIndex;
    currentIndex = l.index;
    updateOutConsole('FuncionBL',label,'=', lr.value )
}

// Función beq
function beq(label) {
    let l = labels.find(l => l.label === label);
    let z = registers.find(r => r.register === 'Z');

    if(!l) {
        errors.push({error: `No se encontró el label: ${label}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(l && z && z.value === 1) {
        currentIndex = l.index;
        updateOutConsole('FuncionBEQ',label,'_', currentIndex)
    }
}

// Función bne
function bne(label) {
    let l = labels.find(l => l.label === label);
    let z = registers.find(r => r.register === 'Z');

    if(!l) {
        errors.push({error: `No se encontró el label: ${label}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(l && z && z.value === 0) {
        currentIndex = l.index;
        updateOutConsole('FuncionBNE',label,'_',currentIndex )
    }
}

// Función blt
function blt(label) {
    let l = labels.find(l => l.label === label);
    let n = registers.find(r => r.register === 'N');
    let v = registers.find(r => r.register === 'V');

    if(!l) {
        errors.push({error: `No se encontró el label: ${label}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(l && n && n.value !== v.value) {
        currentIndex = l.index;
        updateOutConsole('FuncionBLT',label,'_',currentIndex )
    }
}

// Función ble
function ble(label) {
    let l = labels.find(l => l.label === label);
    let n = registers.find(r => r.register === 'N');
    let v = registers.find(r => r.register === 'V');
    let z = registers.find(r => r.register === 'Z');

    if(!l) {
        errors.push({error: `No se encontró el label: ${label}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(l && (z.value === 1 || n.value !== v.value)) {
        currentIndex = l.index;
        updateOutConsole('FuncionBLE',label,'_',currentIndex )
    }
}

// Función bgt
function bgt(label) {
    let l = labels.find(l => l.label === label);
    let n = registers.find(r => r.register === 'N');
    let v = registers.find(r => r.register === 'V');
    let z = registers.find(r => r.register === 'Z');

    if(!l) {
        errors.push({error: `No se encontró el label: ${label}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(l && (z.value === 0 && n.value === v.value)) {
        currentIndex = l.index;
        updateOutConsole('FuncionBGT',label,'_',currentIndex )

    }
}

// Función bge
function bge(label) {
    let l = labels.find(l => l.label === label);
    let n = registers.find(r => r.register === 'N');
    let v = registers.find(r => r.register === 'V');

    if(!l) {
        errors.push({error: `No se encontró el label: ${label}`, type: 'semántico', line: currentLine, column: currentColumn});
        return;
    }

    if(l && n.value === v.value) {
        currentIndex = l.index;
        updateOutConsole('FuncionBGE',label,'_',currentIndex )

    }
}

// Función strb
function strb(register, value) {
    let reg = registers.find(r => r.register === register);
    let variable = getValue(value);
    let regValue = getValue(variable.value);
    if(reg) {
        regValue.value = charToNumber(reg.value);
        console.log('strb result', regValue);
        updateOutConsole('FuncionBLE',register,'=',regValue)

    }
}

// FUNCIONES DE DESPLAZAMIENTO

// Función para desplazar a la derecha dos bits
function asr(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    console.log('asr', value1, value2);
    updateOutputConsoleOP(register,op1, '=>',op2 )
    updateOutConsole('asr',register,value1,value2 )

    if(reg) {
        reg.value = value1 >> value2;
        updateOutConsole('asr',register,'=',reg.value )

    }
}

// Función para desplazar a la derecha un bit
function lsr(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1, '=>',op2 )
    updateOutConsole('asr',register,value1,value2 )
    if(reg) {
        reg.value = value1 >> value2;
        updateOutConsole('lsr',register,'=',reg.value )

    }
}

// Función para desplazar a la izquierda un bit
function lsl(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1, '<=',op2 )
    updateOutConsole('Desplazar1bitIzq',register,value1,value2 )

    if(reg) {
        reg.value = value1 << value2;
        updateOutConsole('Desplazar1bitIzq',register,'=',reg.value )

    }
}

// Función para desplazar a la izquierda dos bits
function asl(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1, '<=',op2 )
    updateOutConsole('Desplazar2bitsIzq',register,value1,value2 )

    if(reg) {
        reg.value = value1 << value2;
        updateOutConsole('Desplazar2bitIzq',register,'=',reg.value )

    }
}

// Función para rotar a la derecha
function ror(register, op1, op2) {
    let reg = registers.find(r => r.register === register);
    let value1 = getValue(op1);
    let value2 = getValue(op2);
    updateOutputConsoleOP(register,op1, '<0>',op2 )
    updateOutConsole('RotarDerecha',register,value1,value2 )
    if(reg) {
        reg.value = (value1 >> value2) | (value1 << (32 - value2));
        updateOutConsole('Desplazar2bitIzq',register,'=',reg.value )

    }
}

