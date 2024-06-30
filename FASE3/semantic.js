let labels = [];
let variables = [];
let bss = [];
let registers = [];
let currentIndex = 0;
let errors = [];
let output = '';

// Funciones de inicialización
function init(c3d) {
    currentIndex = 0;
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

// Función para obtener el valor de un operador1 y operador2
function getValue(operador) {
    // Eliminarmos # si es que lo tiene
    operador = operador.replace('#', '');
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
        return register.value;
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
    // si es una variable
    operador = operador.replace('=', '');
    let variable = variables.find(v => v.variable === operador);
    if(!variable) {
        variable = bss.find(v => v.variable === value);
        if(!variable) {
            errors.push({error: `No se encontró la variable: ${value}`, type: 'semántico', row: 0, column: 0});
            return null;
        }
    }
    return variable

}

// Función para ejecutar el código c3d
function accept(c3d) {
    init(c3d);
    while(currentIndex < c3d.length) {
        executeLine(c3d);
    }
}

// Función para debuggear (solamente inicializa las variables)
// Se debe llamar a executeLine para ejecutar línea por línea
function debug(c3d) {
    init(c3d);
}

// Función para ejecutar línea por línea el código c3d
function executeLine(c3d) {
    let line = c3d[currentIndex];
    if(line.resultado === '.global') {
        executeGlobal(line);
    } else if (line.operacion !== '') {
        executeInstruction(line);
    }
    currentIndex++;
}

// Función para ejecutar una instrucción global
// buscar en el arreglo de labels el label de inicio de ejecución
function executeGlobal(line) {
    let label = labels.find(l => l.label === line.operador1);
    if(!label) {
        errors.push({error: `No se encontró el label: ${line.operador1} de inicio de ejecución`, type: 'semántico', row: line.row, column: line.column});
    }
        
}

// Función para ejecutar una instrucción
// Este método llama a otras funciones en base a la operación
function executeInstruction(line) {
    switch(line.operacion) {
        case 'MOV':
            mov(line.resultado, line.operador1);
            break;
        case 'SVC':
            svc(line.resultado);
            break;
        default:
            break;
    }
}

function mov(register, value) {
    console.log('mov', register);
    let reg = registers.find(r => r.register === register);
    value = getValue(value);
    if(value === null) {
        errors.push({error: `No se encontró el valor: ${value}`, type: 'semántico', row: 0, column: 0});
        return;
    }

    if(reg) {
        reg.value = value;
    }
}

// Función para ejecutar la instrucción SVC
// Esta instrucción verifica si el registro x8 tiene un valor 93 para finalizar la ejecución
// Si el registro x8 tiene un valor de 64 entonces imprime el valor del registro x0
function svc(value) {
    console.log('svc', value);
    let x8 = registers.find(r => r.register === 'x8');
    value = getValue(value);
    if(value === null) {
        errors.push({error: `No se encontró el valor: ${value}`, type: 'semántico', row: 0, column: 0});
        return;
    }

    if(x8 && x8.value === 93 && value === 0) {
        let reg = registers.find(r => r.register === 'x0');
        output += reg.value;
        currentIndex = 10000;
    } else if (x8 && x8.value === 64 && value === 0) {
        let reg = registers.find(r => r.register === 'x0');
        output += reg.value;
    }
}

// Función para imprimir u obtener algo (input / output) ldr
