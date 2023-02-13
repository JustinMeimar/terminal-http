import {React, useRef, useEffect, useState} from 'react';
import {XTerm} from 'xterm-for-react';
import './ProjectsPage.css'
import axios from 'axios';

function ProjectsPage() {

    const xTermRef = useRef();
    const terminal_msg = "justin@website:~$ " 
    const [data, setData] = useState(); 
     
    let written = 0; 
    let inputStr = '';
    let outputStr = '';
    
    useEffect(() => { 
        resetTerminal(); 
    });  

    function resetTerminal() {
        var term = xTermRef.current.terminal; 
        term.reset();
        term.write(terminal_msg);
    }
   
    async function awaitData(input) {

        //needed because of unusual terminal formatting without
        const parseOutput = (output, char) => {
            const arr = output.split('\n');
            return arr.join(`${char}\n`)
        }
        
        const fetchData = async () => {
            console.log(input);
            const post = axios.post('http://localhost:3001/post', {"input" : input})
                .then(response => {
                    outputStr = parseOutput(response.data.stdout, '\r');    
                }); 
        }
        fetchData();        
    }
   
    const onKeyPressed = (event) => {
        var term = xTermRef.current.terminal; 
        
        function handleInput(input) {
            awaitData(input); 
            term.write("\r\n" + outputStr + "\r\n" + terminal_msg);
            inputStr = '';  //reset input for next command
            written = 0;    //reset character count for next command 
        }

        if (event.domEvent.key == "Enter") {
            // term.write("\r\n" + terminal_msg);     
            handleInput(inputStr);
 
        } else if (event.domEvent.key == "Backspace") {
            inputStr = inputStr.slice(0, inputStr.length-1);
            if (written > 0) {
                term.write('\b \b');
                written-=1;
            } 
        } else {
            term.write(event.domEvent.key); 
            inputStr += event.domEvent.key;
            written+=1
        }
    }

    return( 
        <div className="project_page"> 
            <button className="resetButton">Reset</button> 
            <div className="terminal_div">
                <XTerm
                    className="terminal"
                    options={{
                        cursorBlink: true,
                        disableStdin: false
                    }}
                    onKey={(e) => onKeyPressed(e)}
                    ref={xTermRef}
                />
            </div> 
        </div>
    );
}

export default ProjectsPage;