let editorCount = 1;
const editors = {};
const consoles = {};
let consoleResult;

$(document).ready(function () {
    editors['tab1'] = createEditor('julia__editor', 'text/x-rustsrc');
    consoles['console-tab1'] = createEditor('console__result1', '', false, true, false);

    document.getElementById('btn__newTab').addEventListener('click', addNewTab);
    document.getElementById('tab-nav').addEventListener('click', (e) => {
        if (e.target && e.target.nodeName === 'A') {
            e.preventDefault();
            activateTab(e.target);
        }
    });
    document.getElementById('console-tab-nav').addEventListener('click', (e) => {
        if (e.target && e.target.nodeName === 'A') {
            e.preventDefault();
            activateConsoleTab(e.target);
        }
    });

    document.getElementById('btn__showC3dTable').addEventListener('click', showC3dTable);
    document.getElementById('btn__showQuartersTable').addEventListener('click', showQuartersTable);

    

});

const createEditor = (id, language, lineNumbers = true, readOnly = false, styleActiveLine = true) => {
    return CodeMirror.fromTextArea(document.getElementById(id), {
        lineNumbers: lineNumbers,
        styleActiveLine: styleActiveLine,
        matchBrackets: true,
        theme: "monokai",
        mode: language,
        readOnly: readOnly
    });
};

const addNewTab = () => {
    editorCount++;
    const newTabId = `tab${editorCount}`;
    const newConsoleTabId = `console-tab${editorCount}`;

    // Add new editor tab to the navigation
    const newTabNav = document.createElement('li');
    newTabNav.innerHTML = `<a data-toggle="tab" href="#${newTabId}" role="tab">Tab ${editorCount}</a><span class="close-tab" onclick="closeTab(event, '${newTabId}')">&times;</span>`;
    document.getElementById('tab-nav').appendChild(newTabNav);

    // Add new console tab to the navigation
    const newConsoleTabNav = document.createElement('li');
    newConsoleTabNav.innerHTML = `<a data-toggle="tab" href="#${newConsoleTabId}" role="tab">Console Tab ${editorCount}</a><span class="close-tab" onclick="closeTab(event, '${newConsoleTabId}')">&times;</span>`;
    document.getElementById('console-tab-nav').appendChild(newConsoleTabNav);

    // Add new editor tab content
    const newTabContent = document.createElement('div');
    newTabContent.id = newTabId;
    newTabContent.setAttribute('role', 'tabpanel');
    newTabContent.innerHTML = `<textarea id="${newTabId}__editor" class="CodeMirror"></textarea>`;
    document.getElementById('tab-content').appendChild(newTabContent);

    // Add new console tab content
    const newConsoleTabContent = document.createElement('div');
    newConsoleTabContent.id = newConsoleTabId;
    newConsoleTabContent.setAttribute('role', 'tabpanel');
    newConsoleTabContent.innerHTML = `<textarea id="console__${newTabId}" class="CodeMirror"></textarea>`;
    document.getElementById('console-tab-content').appendChild(newConsoleTabContent);

    // Create new CodeMirror editors
    const newEditor = createEditor(`${newTabId}__editor`, 'text/x-rustsrc');
    editors[newTabId] = newEditor;

    const newConsole = createEditor(`console__${newTabId}`, '', false, true, false);
    consoles[newConsoleTabId] = newConsole;

    // Activate new tab
    activateTab(newTabNav.querySelector('a'));
    activateConsoleTab(newConsoleTabNav.querySelector('a'));
};

const activateTab = (tabLink) => {
    const tabId = tabLink.getAttribute('href').substring(1);
    const consoleTabId = `console-${tabId}`;
    
    // Desactivar todas las tabs y consolas
    document.querySelectorAll('.tab-nav a').forEach(tab => tab.classList.remove('active'));
    document.querySelectorAll('.tab-content > div').forEach(content => content.style.display = 'none');
    document.querySelectorAll('#console-tab-nav a').forEach(tab => tab.classList.remove('active'));
    document.querySelectorAll('#console-tab-content > div').forEach(content => content.style.display = 'none');

    // Activar la tab seleccionada y su consola correspondiente
    tabLink.classList.add('active');
    document.querySelector(`#${tabId}`).style.display = 'block';
    document.querySelector(`#${consoleTabId}`).style.display = 'block';
};

const activateConsoleTab = (tabLink) => {
    document.querySelectorAll('#console-tab-nav a').forEach(tab => tab.classList.remove('active'));
    document.querySelectorAll('#console-tab-content > div').forEach(content => content.style.display = 'none');

    tabLink.classList.add('active');
    document.querySelector(tabLink.getAttribute('href')).style.display = 'block';
};

const closeTab = (event, tabId) => {
    event.stopPropagation();

    // Remove tab from navigation
    const tabNavItem = document.querySelector(`#tab-nav a[href="#${tabId}"]`).parentElement;
    tabNavItem.parentElement.removeChild(tabNavItem);

    // Remove tab content
    const tabContentItem = document.getElementById(tabId);
    tabContentItem.parentElement.removeChild(tabContentItem);

    // Remove console tab from navigation
    const consoleTabId = `console-${tabId}`;
    const consoleTabNavItem = document.querySelector(`#console-tab-nav a[href="#${consoleTabId}"]`).parentElement;
    consoleTabNavItem.parentElement.removeChild(consoleTabNavItem);

    // Remove console content
    const consoleTabContentItem = document.getElementById(consoleTabId);
    consoleTabContentItem.parentElement.removeChild(consoleTabContentItem);

    // Remove editors from the dictionaries
    delete editors[tabId];
    delete consoles[consoleTabId];

    // Activate the first tab if available
    const firstTab = document.querySelector('#tab-nav a');
    if (firstTab) {
        activateTab(firstTab);
    }
    const firstConsoleTab = document.querySelector('#console-tab-nav a');
    if (firstConsoleTab) {
        activateConsoleTab(firstConsoleTab);
    }
};

const openFile = async (editor) => {
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

    let reader = new FileReader();

    reader.onload = (e) => {
        const fileContent = e.target.result;
        editor.setValue(fileContent);
    };
    
    reader.onerror = (e) => {
        console.log("Error reading file", e.target.error);
    };

    reader.readAsText(file);
};

const saveFile = async (fileName, extension, editor) => {
    if (!fileName) {
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
        fileName = name;
    }
    if (fileName) {
        download(`${fileName}.${extension}`, editor.getValue())
    }
};

const download = (name, content) => {
    let blob = new Blob([content], {type: 'text/plain;charset=utf-8'})
    let link = document.getElementById('download');
    link.href = URL.createObjectURL(blob);
    link.setAttribute("download", name)
    link.click()
};

const cleanEditors = (...editors) => {
    // Limpia todos los editores y consolas pasados a la función
    editors.forEach(editor => editor.setValue(""));

    // Limpia las tablas y oculta los títulos
    const c3dTableContainer = document.getElementById('c3dTableContainer');
    const quartersTableContainer = document.getElementById('quartersTableContainer');
    const c3dTableTitle = document.getElementById('c3dTableTitle');
    const quartersTableTitle = document.getElementById('quartersTableTitle');

    c3dTableContainer.innerHTML = '';
    quartersTableContainer.innerHTML = '';
    c3dTableTitle.classList.add('hidden');
    quartersTableTitle.classList.add('hidden');
};


const getActiveTabId = () => {
    const activeTabLink = document.querySelector('.tab-nav a.active');
    return activeTabLink ? activeTabLink.getAttribute('href').substring(1) : null;
};

const getActiveConsoleTabId = () => {
    const activeConsoleTabLink = document.querySelector('#console-tab-nav a.active');
    return activeConsoleTabLink ? activeConsoleTabLink.getAttribute('href').substring(1) : null;
};



const btnOpen = document.getElementById('btn__open'),
    btnSave = document.getElementById('btn__save'),
    btnClean = document.getElementById('btn__clean'),
    btnAnalysis = document.getElementById('btn__analysis');

btnOpen.addEventListener('click', () => openFile(editors[getActiveTabId()]));
btnSave.addEventListener('click', () => saveFile("file", "rs", editors[getActiveTabId()]));
btnClean.addEventListener('click', () => cleanEditors(editors[getActiveTabId()], consoles[getActiveConsoleTabId()]));
btnAnalysis.addEventListener('click', () => analysis());


const displayErrors = (errors) => {
    const errorTableBody = document.querySelector('#error-table tbody');
    errorTableBody.innerHTML = ''; // Clear previous errors
    errors.forEach((error, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${error.message}</td>
            <td>${error.location.start.line}</td>
            <td>${error.location.start.column}</td>
            <td>${isLexicalError(error) ? 'léxico' : 'sintáctico'}</td>
        `;
        errorTableBody.appendChild(row);
    });
};



const analysis = async () => {
    const activeTabId = getActiveTabId();
    const activeConsoleTabId = getActiveConsoleTabId();
    const editor = editors[activeTabId];
    const consoleEditor = consoles[activeConsoleTabId];
    const text = editor.getValue();
    const startTime = performance.now();
    try {
        let resultado = FASE1.parse(text);
        const errorTableBody = document.querySelector('#error-table tbody');
        errorTableBody.innerHTML = ''; // Clear previous errors
        // consoleEditor.setValue("ENTRADA VALIDA, Su JSON resultante es: \n" + JSON.stringify(resultado));
        // console.log(resultado)
        const c3d = resultado.getC3d(resultado);
        console.log(c3d);
        // resultado.accept(c3d);
        accept(c3d);
        console.log('output', output);
        console.log('errors', errors);
        console.log('registers', registers);
        if(errors.length === 0) {
            consoleEditor.setValue(output)
        } else {
            errors = errors.concat(errors);
            consoleEditor.setValue(errors);
            displayErrors(errors);
        }
        const quarters = resultado.getQuarters(c3d);
        // console.log("QUARTERS:");
        // console.log(quarters);
    } catch (error) {
        console.log(FASE1)
        if (error instanceof FASE1.SyntaxError) {
            displayErrors([error]);
            if (isLexicalError(error)) {
                consoleEditor.setValue('ERROR LÉXICO!, Carácter no reconocido: ' + `Location: Line ${error.location.start.line}, Column ${error.location.start.column} ` + error.message);
            } else {
                consoleEditor.setValue('ERROR SINTÁCTICO: ' + `Location: Line ${error.location.start.line}, Column ${error.location.start.column} ` + error.message);
            }
        } else {
            console.error('Error desconocido:', error);
        }
    }
    const endTime = performance.now();
    const executionTime = endTime - startTime;
    document.getElementById('execution-time').innerText = executionTime.toFixed(2);
    showRegisterTable();
};


function isLexicalError(e) {
    const validIdentifier = /^[a-zA-Z_$][a-zA-Z0-9_$]*$/;
    const validInteger = /^[0-9]+$/;
    const validRegister = /^[a-zA-Z][0-9]+$/;
    const validCharacter = /^[a-zA-Z0-9_$,\[\]#"]$/;
    if (e.found) {
      if (!validIdentifier.test(e.found) && 
          !validInteger.test(e.found) &&
          !validRegister.test(e.found) &&
          !validCharacter.test(e.found)) {
        return true; // Error léxico
      }
    }
    return false; // Error sintáctico
}

function showC3dTable() {
    const activeTabId = getActiveTabId();
    const editor = editors[activeTabId];
    const text = editor.getValue();

    try {
        let parsedResult = FASE1.parse(text);
        let c3dInstructions = parsedResult.getC3d(parsedResult);

        const tableContainer = document.getElementById('c3dTableContainer');
        tableContainer.innerHTML = ''; // Limpiar tabla existente

        let table = document.createElement('table');
        table.className = 'c3d-table';
        let thead = table.createTHead();
        let tbody = table.createTBody();

        // Encabezados de la tabla
        let headerRow = thead.insertRow();
        ['Resultado', 'Operador1', 'Operador2', 'Operación'].forEach(headerText => {
            let headerCell = document.createElement('th');
            headerCell.textContent = headerText;
            headerRow.appendChild(headerCell);
        });

        // Filas de la tabla
        c3dInstructions.forEach(instr => {
            let row = tbody.insertRow();
            [instr.resultado, instr.operador1, instr.operador2, instr.operacion].forEach(text => {
                let cell = row.insertCell();
                cell.textContent = text;
            });
        });

        tableContainer.appendChild(table);
    } catch (error) {
        console.error('Error al generar la tabla C3D:', error);
    }
    document.getElementById('c3dTableTitle').classList.remove('hidden');

}

function showQuartersTable() {
    const activeTabId = getActiveTabId();
    const editor = editors[activeTabId];
    const text = editor.getValue();

    try {
        let parsedResult = FASE1.parse(text);
        let c3dInstructions = parsedResult.getC3d(parsedResult);
        let quartersData = parsedResult.getQuarters(c3dInstructions);

        const tableContainer = document.getElementById('quartersTableContainer');
        tableContainer.innerHTML = ''; // Limpiar tabla existente

        let table = document.createElement('table');
        table.className = 'quarters-table';
        let thead = table.createTHead();
        let tbody = table.createTBody();

        // Encabezados de la tabla
        let headerRow = thead.insertRow();
        ['Operator', 'Operand 1', 'Operand 2', 'Destination'].forEach(headerText => {
            let headerCell = document.createElement('th');
            headerCell.textContent = headerText;
            headerRow.appendChild(headerCell);
        });

        // Filas de la tabla
        quartersData.forEach(quarter => {
            let row = tbody.insertRow();
            [quarter.operator, quarter.operand1, quarter.operand2, quarter.destination].forEach(text => {
                let cell = row.insertCell();
                cell.textContent = text;
            });
        });

        tableContainer.appendChild(table);
    } catch (error) {
        console.error('Error al generar la tabla Quarters:', error);
    }
    document.getElementById('quartersTableTitle').classList.remove('hidden');

}

//Graficar CST

function jsonToDot(json) {
    let dot = 'digraph G {\n';

    function traverse(node, parentId = null) {
        const nodeId = node.id.replace(/\\\"/g, '');
        dot += `  ${nodeId} [label="${node.value}"];
`;
        if (parentId) {
            dot += `  ${parentId} -> ${nodeId};
`;
        }
        for (let child of node.children) {
            traverse(child, nodeId);
        }
    }

    traverse(json);
    dot += '}';
    return dot;
}

function dotToVis(dotString) {
    const nodeRegex = /(\S+)\s+\[label="([^"]+)"\];/g;
    const edgeRegex = /(\S+)\s+->\s+(\S+);/g;
    const nodes = [];
    const edges = [];
    let match;
    
    while (match = nodeRegex.exec(dotString)) {
        nodes.push({ id: match[1], label: match[2] });
    }

    while (match = edgeRegex.exec(dotString)) {
        edges.push({ from: match[1], to: match[2] });
    }

    return { nodes, edges };
}


document.getElementById('btn__cst').addEventListener('click', generateCST);

function generateCST() {
    const activeTabId = getActiveTabId();
    const editor = editors[activeTabId];
    const text = editor.getValue();

    try {
        let resultado = FASE1.parse(text);
        let dotString = jsonToDot(resultado);

        console.log("dotString generado:", dotString);

        let { nodes, edges } = dotToVis(dotString);

        let htmlContent = `
            <html>
                <head>
                    <title>CST</title>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
                </head>
                <body>
                    <div id="mynetwork" style="width: 100%; height: 100%;"></div>
                    <script>
                        window.addEventListener('load', function() {
                            let container = document.getElementById('mynetwork');
                            let nodes = new vis.DataSet(${JSON.stringify(nodes)});
                            let edges = new vis.DataSet(${JSON.stringify(edges)});
                            let data = { nodes: nodes, edges: edges };
                            let options = {
                                layout: {
                                    hierarchical: {
                                        direction: 'UD', // UD for top-down, can also be LR for left-right
                                        sortMethod: 'directed' // Or 'hubsize' depending on the desired layout
                                    }
                                },
                                edges: {
                                    smooth: true
                                },
                                physics: {
                                    hierarchicalRepulsion: {
                                        nodeDistance: 120
                                    },
                                    solver: 'hierarchicalRepulsion'
                                }
                            };
                            let network = new vis.Network(container, data, options);
                        });
                    </script>
                </body>
            </html>
        `;

        let newWindow = window.open('', '', 'width=800,height=600');
        newWindow.document.open();
        newWindow.document.write(htmlContent);
        newWindow.document.close();
    } catch (error) {
        console.error('Error generando el CST:', error);
        alert('Error generando el CST: ' + error.message);
    }
}
//Mostrar registros 
function showRegisterTable() {
    const tableContainer = document.getElementById('registerTableContainer');
    tableContainer.innerHTML = ''; // Limpiar tabla existente

    let table = document.createElement('table');
    table.className = 'c3d-table';
    let thead = table.createTHead();
    let tbody = table.createTBody();

    // Encabezados de la tabla
    let headerRow = thead.insertRow();
    ['Variable', 'Tipo', 'Valor'].forEach(headerText => {
        let headerCell = document.createElement('th');
        headerCell.textContent = headerText;
        headerRow.appendChild(headerCell);
    });

    // Filas de la tabla para variables
    variables.forEach(variable => {
        let row = tbody.insertRow();
        [variable.variable, variable.type, variable.value].forEach(text => {
            let cell = row.insertCell();
            cell.textContent = text;
        });
    });

    // Filas de la tabla para bss
    bss.forEach(variable => {
        let row = tbody.insertRow();
        [variable.variable, variable.type, variable.size].forEach(text => {
            let cell = row.insertCell();
            cell.textContent = text;
        });
    });

    // Filas de la tabla para registros
    registers.forEach(register => {
        let row = tbody.insertRow();
        [register.register, 'Registro', register.value].forEach(text => {
            let cell = row.insertCell();
            cell.textContent = text;
        });
    });

    tableContainer.appendChild(table);
    document.getElementById('registerTableTitle').classList.remove('hidden');
}

document.getElementById('btn__analysis').addEventListener('click', () => {
    analysis();
    showRegisterTable();
});




