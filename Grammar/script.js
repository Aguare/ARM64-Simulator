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
    newTabNav.innerHTML = `<a data-toggle="tab" href="#${newTabId}" role="tab">Tab ${editorCount}</a>`;
    document.getElementById('tab-nav').appendChild(newTabNav);

    // Add new console tab to the navigation
    const newConsoleTabNav = document.createElement('li');
    newConsoleTabNav.innerHTML = `<a data-toggle="tab" href="#${newConsoleTabId}" role="tab">Console Tab ${editorCount}</a>`;
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
    document.querySelectorAll('.tab-nav a').forEach(tab => tab.classList.remove('active'));
    document.querySelectorAll('.tab-content > div').forEach(content => content.style.display = 'none');

    tabLink.classList.add('active');
    document.querySelector(tabLink.getAttribute('href')).style.display = 'block';
};

const activateConsoleTab = (tabLink) => {
    document.querySelectorAll('#console-tab-nav a').forEach(tab => tab.classList.remove('active'));
    document.querySelectorAll('#console-tab-content > div').forEach(content => content.style.display = 'none');

    tabLink.classList.add('active');
    document.querySelector(tabLink.getAttribute('href')).style.display = 'block';
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
    editors.forEach(editor => editor.setValue(""));
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

const analysis = async () => {
    const activeTabId = getActiveTabId();
    const activeConsoleTabId = getActiveConsoleTabId();
    const editor = editors[activeTabId];
    const consoleEditor = consoles[activeConsoleTabId];
    const text = editor.getValue();
    try {
        let resultado = FASE1.parse(text);
        consoleEditor.setValue("ENTRADA VALIDA, Su JSON resultante es: \n"+JSON.stringify(resultado))
    } catch (error) {
        console.log(FASE1)
        if (error instanceof FASE1.SyntaxError) {
            if (isLexicalError(error)) {
                consoleEditor.setValue('ERROR LÉXICO!, Carácter no reconocido: ' + error.message);
                console.log(error.message)
            } else {
                consoleEditor.setValue('ERROR SINTÁCTICO: ' + error.message);
                console.log(error.message)
            }
        } else {
            console.error('Error desconocido:', error);
        }
    }
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
