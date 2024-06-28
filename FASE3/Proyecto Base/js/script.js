let errorTable, symbolTable, Arm64Editor, consoleResult, dotStringCst = "";
/*Scrips Code Mirror */
$(document).ready(function () {
    Arm64Editor = editor('editor');
    consoleResult = editor('console', 'text/x-rustsrc', true, true, false, true);
});

function editor(id, language, lineNumbers = true, readOnly = false, styleActiveLine = true,  lineWrapping = true) {
    return CodeMirror.fromTextArea(document.getElementById(id), {
        lineNumbers: true,
        readOnly: readOnly,
        styleActivateLine: true,
        matchBrackets: true,
        theme: "midnight",
        scrollbarStyle: "null",
        lineWrapping: lineWrapping,
        mode: "text/x-rustsrc"
    });
}

/**
 * Tabla de Errores 
 */
function getErrors(e) {
    let info = '<tr><th>No.</th><th>Tipo</th><th>Descripción</th><th>Linea</th><th>Columna</th></tr>'
    if (isLexicalError(e)){
        info += `<tr><td>1</td><td>${"Léxico"}</td><td>${"Se ha encontrado un caracter que no pertenece al lenguaje: " + e.found}</td><td>${e.location.start.line}</td><td>${e.location.start.column}</td></tr>`
    }else {
        info += `<tr><td>1</td><td>${"Sintátctico"}</td><td>${e.message}</td><td>${e.location.start.line}</td><td>${e.location.start.column}</td></tr>`
    }
    document.getElementById('errors-report').innerHTML = info
    


}
/**
 * Tabla de simbolos 
 */
function getSymbolsTable() {
    let info = '<tr><th>No.</th><th>ID</th><th>Tipo</th><th>Tipo de Dato</th><th>Entorno</th><th>Linea</th><th>Columna</th></tr>'
    document.getElementById('symb-report').innerHTML = info


}

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
/**
 * Tabla de Tokens 
 */
function getTokens() {

    let info = '<tr><th>No.</th><th>Lexema</th><th>Token</th><th>Linea</th><th>Columna</th></tr>'
    document.getElementById('tokens-report').innerHTML = info


}
/**
 * CST
 * la Funcion recibe debe recibir un sring  con dot para 
 * crear el cst
 */
function graphCST(DOTstring) {
    //console.log(DOTstring)
    var container = document.getElementById("mynetwork");
    var parsedData = vis.parseDOTNetwork(DOTstring);
    var data = {
        nodes: parsedData.nodes,
        edges: parsedData.edges
    }
    var options = {
        nodes: {
            widthConstraint: 70,
        },
        layout: {
            hierarchical: {
                levelSeparation: 100,
                nodeSpacing: 100,
                parentCentralization: true,
                direction: 'UD',        // UD, DU, LR, RL
                sortMethod: 'directed',  // hubsize, directed
                shakeTowards: 'roots'  // roots, leaves                        
            },
        },
    };
    var network = new vis.Network(container, data, options);
}
function graphVCST(){
    const text = Arm64Editor.getValue();
    let resultado = PARSE.parse(text);
    openGraphPage(resultado.getDot(resultado));
}
function resetGraph(){
    
}
/** Abrir Archivo */
const openFile = async (editor) => {
    console.log('click en open file ')
    let fileInput = document.createElement('input')
    fileInput.type = 'file'
    fileInput.addEventListener('change', function (event) {
        let file = event.target.files[0]
        let reader = new FileReader()
        reader.readAsText(file, 'utf-8')
        console.log(reader)
        try {
            reader.onload = function (e) {
                var contenido = e.target.result;
                editor.setValue(contenido);
            }
        } catch (error) {
            editor.setValue('error en la carga del archivo intente de nuevo ')
        }

    });
    fileInput.click();
}

/**Guardar achivo .s  */
const saveFile = async (editor) => {
    const text = Arm64Editor.getValue();
    var archivoBlob = new Blob([text], { type: 'text/plain' });
    // Crear un enlace para descargar el archivo
    var enlaceDescarga = document.createElement("a");
    enlaceDescarga.href = window.URL.createObjectURL(archivoBlob);

    // Solicitar al usuario que ingrese un nombre de archivo
    var nombreArchivo = prompt("Por favor, ingresa el nombre del archivo:", "nombreArchivo");
    nombreArchivo += ".s"
    if (nombreArchivo) {
        enlaceDescarga.download = nombreArchivo;

        // Ocultar el enlace
        enlaceDescarga.style.display = "none";

        // Agregar el enlace al cuerpo del documento y hacer clic en él
        document.body.appendChild(enlaceDescarga);
        enlaceDescarga.click();

        // Eliminar el enlace del cuerpo del documento
        document.body.removeChild(enlaceDescarga);
    }
}

/*limpiar consola */
const cleanEditor = (editor) => {
    editor.setValue("");
    consoleResult.setValue('')
}


/* Analizador*/

const analysis = async () => {
    const text = Arm64Editor.getValue();
    try {
        iniciarContador();
        resultado = PARSE.parse(text);
        graphCST(resultado.getDot(resultado));
        terminarContador();
        var jsonString = JSON.stringify(resultado.Text(), null, 2);
        consoleResult.setValue(resultado.Text());
    } catch (error) {
        consoleResult.setValue(error.message);
        getErrors(error)
    }
}

const btnClean = document.getElementById('clearButton'),
    btnOpen = document.getElementById('btn__open'),
    btnSave = document.getElementById('btn__save'),
    btnAnalysis = document.getElementById('btn__analysis'),
    btnT = document.getElementById('btn__t');




btnOpen.addEventListener('click', () => openFile(Arm64Editor));
btnClean.addEventListener('click', () => cleanEditor(Arm64Editor));
btnAnalysis.addEventListener('click', () => analysis());
btnSave.addEventListener('click', () => saveFile());
btnT.addEventListener('click', () => graphVCST());

/**contador para ejecucion */

let contadorId;

// Función para iniciar el contador
// Función para iniciar el contador
function iniciarContador() {
    tiempoInicio = performance.now(); // Guardar el tiempo de inicio en milisegundos
    console.log('Contador iniciado.');
}

// Función para terminar el contador y mostrar la duración en nanosegundos
function terminarContador() {
    const tiempoFin = performance.now(); // Guardar el tiempo de fin en milisegundos
    const duracionEnNanosegundos = (tiempoFin - tiempoInicio) * 1000000; // Convertir la duración a nanosegundos
    console.log(`La duración del contador es ${duracionEnNanosegundos} nanosegundos.`);
    document.getElementById('contador').innerHTML = `La duración del Analisis es ${tiempoFin - tiempoInicio} milisegundos.`
}
function openGraphPage(dotString) {
    const encodedDotString = encodeURIComponent(dotString);
    window.open(`graph.html?dot=${encodedDotString}`, '_blank');
}

