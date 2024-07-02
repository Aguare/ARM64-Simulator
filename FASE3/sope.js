
    // Inicializar nueva consola de debug
    const debugConsole = createEditor('debug-console', '', false, true, false);

    // Funciones para actualizar la consola de debug y el cuadro de texto de output
    function updateDebugConsole(content) {
        debugConsole.setValue(debugConsole.getValue() + '\n' + content);
    }

    function updateOutConsole(reg, hol, adi, pep) {
        if(reg==undefined){
        document.getElementById('output-console').value += 'Output:'+'\n'
        }else{
            document.getElementById('output-console').value += 'Output:' + reg+'_'+ hol + adi+ pep+'\n';
        }
    }
    function updateOutputConsoleOP(reg, op1,  signo, op2) {
        document.getElementById('output-console').value += 'operacion:'+reg+'='+op1+signo+op2+'\n';
    }

    function clearDebugConsole() {
        debugConsole.setValue('');
    }

    function clearOutputConsole() {
        document.getElementById('output-console').value = '';
    }

    // Actualizar funciones debug y executeLine para mostrar en la nueva consola y output


    // Botones de evento para debug y next line
    document.getElementById('btn__debug').addEventListener('click', () => {
        clearDebugConsole();
        clearOutputConsole();
        const activeTabId = getActiveTabId();
        const editor = editors[activeTabId];
        const text = editor.getValue();
        try {
            let resultado = FASE1.parse(text);
            c3dGlobal = resultado.getC3d(resultado);
            debug(c3dGlobal);
            updateDebugConsole('Debugging started');
        } catch (error) {
            console.error('Error during parsing:', error);
            updateDebugConsole('Error during parsing: ' + error.message);
        }
    });

    document.getElementById('btn__nextLine').addEventListener('click', () => {
        //clearOutputConsole();
        if (c3dGlobal) {
            try {
                executeLine(c3dGlobal);
                const line = c3dGlobal[currentIndex - 1];
                updateDebugConsole('Executed line: ' + JSON.stringify(line, null, 2));
                //updateOutputConsole('Output: ' + output);
                //updateOutConsole();
            } catch (error) {
                console.error('Error during execution:', error);
                updateDebugConsole('Error during execution: ' + error.message);
            }
        } else {
            console.error('No C3D available. Please start debugging first.');
            updateDebugConsole('No C3D available. Please start debugging first.');
        }
    });

