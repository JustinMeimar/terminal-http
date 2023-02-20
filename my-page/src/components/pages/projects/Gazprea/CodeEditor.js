import { useState, useEffect } from 'react';
import Editor from 'react-simple-code-editor';
import { highlight, languages } from 'prismjs';
import axios from 'axios';

function CodeEditor({ onSelectProgram }) {
    
    const [code, setCode] = useState('const message = "Hello, world!";');
    const [program, setProgram] = useState();

    useEffect(() => {
        getProgram("program");
    }, []);

    async function getProgram(program) {
          
        const fetchData = async () => {
            const get = axios.get(`http://localhost:3001/file?program=${program}`)
                .then(response => {
                    setCode(response.data); 
                }); 
        }
        fetchData();        
    }
    
    const handleCodeChange = (newCode) => {
        setCode(newCode);
    };
    
    const handleProgramChange = (event) => {
        setProgram(event.target.value);
    }

    return (
        <div className="code_editor">
            {/* Editor */}
            <Editor
                value={code}
                onValueChange={handleCodeChange}
                highlight={(code) => highlight(code, languages.javascript, 'javascript')}
                padding={10}
                style={{
                    fontFamily: '"Fira code", "Fira Mono", monospace',
                    fontSize: 12,
                    backgroundColor: '#f5f5f5',
                    border: '1px solid #ddd',
                }}
            />
            
            {/* Run Code Button */}
            <button onClick={() => {onSelectProgram(code)}}> Run Code </button> 
                
            {/* Program Selector Dropdown */}
            <div className="program dropdown">
                <select onChange={handleProgramChange} value={program}>
                    <option value="add">Test</option>
                    <option value="gazprea">Add</option>
                    <option value="fruit">Gazprea</option>
                </select>
            </div>
            

        </div> 
    );
}

export default CodeEditor;