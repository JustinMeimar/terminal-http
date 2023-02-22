import {React, useRef, useEffect, useState} from 'react';
import {XTerm} from 'xterm-for-react';
import axios from 'axios';
import CodeEditor from './CodeEditor.js';

function Gazprea() {

    const xTermRef = useRef();
    const terminalMsg = "justin@website:~$ " 
    const [data, setData] = useState(); 
    
    useEffect(() => { 
        resetTerminal(); 
    });  

    function resetTerminal() {
        var term = xTermRef.current.terminal; 
        term.reset();
        term.write(terminalMsg);
    }
   
    async function awaitProgramOutput(program, input) {
        var term = xTermRef.current.terminal; 

        //needed because of unusual terminal formatting without
        const parseOutput = (output, char) => {
            const arr = output.split('\n');
            return arr.join(`${char}\n`)
        }
        
        const fetchData = async () => {

            console.log("program:", program);
            console.log("input:", input);

            const post = axios.post('http://localhost:3001/post', {"program": program, "input" : input})
                .then(response => {
                    console.log("response:", response.data.stdout);
                    term.write(parseOutput(response.data.stdout, '\r'));    
                }); 
        }
        fetchData();        
    }
   
    const onKeyPressed = (event) => {
        var term = xTermRef.current.terminal;  
        return;
    }
        
    const onRunProgram = (program, input) => {
        console.log(program, input); 
        awaitProgramOutput(program, input);
    }

    return( 
        <div className="project_gazprea"> 
            <div className="terminal_div">
                 {/*Terminal*/}
                <XTerm
                    className="terminal"
                    options={{
                        cursorBlink: true,
                        disableStdin: false
                    }}
                    onKey={(e) => onKeyPressed(e)}
                    ref={xTermRef}
                />

                 {/*Editor*/}
                <CodeEditor 
                    onRunProgram={onRunProgram}>
                </CodeEditor>

            </div> 
        </div>
    );
}

export default Gazprea;