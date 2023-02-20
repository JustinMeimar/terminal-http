import {React, useState} from 'react';
import './ProjectsPage.css'
import Gazprea from './projects/Gazprea/Gazprea.js'
import Test from './projects/Test.js'

function ProjectsPage() {

    const project_descriptions = [
        "A fully functional compiler. Gazprea uses ANTLR frontend to generatae a parse tree. After transforming \
        the parse tree to an AST we implement multiple AST walks including symbol definition, resolution, static type checking \
        and finally code generation.",
        "A C++ implementation of a B-Tree for indexing an ordered database.",
        "NFA regex includes a recursive-descent parser for recognizing a regular expression as well "
    ];
    const project_titles = ["Gazprea", "B-Tree", "VN-8Bit"];
    
    const project_components = [
        <Gazprea></Gazprea>,
        <Test></Test>
    ] 

    const [showProjectIndex, setShowProjectIndex] = useState(-1);

    const title_divs = project_titles.map((title, idx) => {
        
        const onTitleClick = (idx) => {
            setShowProjectIndex(idx);
            console.log(showProjectIndex, idx);
        }

        return <div className="single_project" onClick={() => onTitleClick(idx)}> 
            <div className="project_title">
                 {title}
            </div> 
            <div className="project_description">
                <p>{project_descriptions[idx]}</p> 
            </div> 
        </div>
    });
    
    const render_projects = project_components.map((component, index) => {
        return(
            <div className={`project_component_${index}`}>
                {showProjectIndex == index && component}
            </div>
        );
    });

    return( 
        <div className="project_page"> 
            <div className="dyanmic_projects">
                {showProjectIndex == -1 ? title_divs : render_projects}
            </div>
        </div>
    );
}

export default ProjectsPage;