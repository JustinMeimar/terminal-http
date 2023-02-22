import { useState, useEffect } from 'react';
import Editor from 'react-simple-code-editor';
import { highlight, languages } from 'prismjs';
import axios from 'axios';

function CodeEditor({ onRunProgram }) {
    
    const [input, setInput] = useState('aUbUc');
    const [program, setProgram] = useState();

    useEffect(() => {
        setProgram("nfa-regex");
    }, []);

    // CURRENTLY NOT USED. Will use to fetch predefined inputs for Gazprea (like mergesort, quicksort ...)
    async function getProgram(program) {
          
        const fetchData = async () => {
            const get = axios.get(`http://localhost:3001/file?program=${program}`)
                .then(response => {
                    setInput(response.data); 
                }); 
        }
        fetchData();        
    }
    
    const handleInputChange = (newCode) => {
        setInput(newCode);
    };
    
    const handleProgramChange = (event) => {
        setProgram(event.target.value);
    }

    return (
        <div className="code_editor">
            {/* Editor */}
            <Editor
                value={input}
                onValueChange={handleInputChange}
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
            <button onClick={() => {onRunProgram(program, input)}}> Run Code </button> 
                
            {/* Program Selector Dropdown */}
            <div className="program dropdown">
                <select onChange={handleProgramChange} value={program}>
                    <option value="nfa-regex">nfa-regex</option>
                    <option value="b-tree">b-tree</option>
                    <option value="other">Other</option>
                </select>
            </div>
            

        </div> 
    );
}

export default CodeEditor;