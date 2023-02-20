import {React, Link} from 'react';
import './ProjectsPage.css'
import Gazprea from './projects/Gazprea.js'

function ProjectsPage() {

    const project_descriptions = [
        "A fully functional compiler. Gazprea uses ANTLR frontent to generatae a parse tree. After transforming \
        the parse tree to an AST we implement multiple walking including symbol definition, resolution, static type checking \
        and finally code generation.",
        "A C++ implementation of a B-Tree for indexing an ordered database.",
        "NFA regex includes a recursive-descent parser for recognizing a regular expression as well "
    ];

    const project_titles = ["Gazprea", "B-Tree", "VN-8Bit"];
    const title_divs = project_titles.map((title, idx) => {
        return <div className="single_project"> 
            <div className="project_title">
                {/* <Link to="/projects/gazprea">{title}</Link> */}
                 {title}
            </div> 
            <div className="project_description">
                <p>{project_descriptions[idx]}</p> 
            </div> 
        </div>
    });
    
    return( 
        <div className="project_page"> 
            <div className="terminal_div">
                <Gazprea></Gazprea>
            </div> 
        </div>
    );
}

export default ProjectsPage;