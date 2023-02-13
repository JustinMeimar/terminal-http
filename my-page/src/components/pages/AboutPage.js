import { React } from 'react';
import "./AboutPage.css" 

function AboutPage() {

    return (
        <div className="aboutPage"> 
            <div className="about-me-title">
            
            <br></br> 
                About me.
            </div>
            <div className="home_page_info">
            
            <br></br> 
            Hello, I’m Justin, a third year computer science student at the 
            <a href="https://www.ualberta.ca/computing-science/index.html"> University of Alberta </a>  

            <br></br> <br></br> 
            I enjoy implementing low level programs and concepts. A couple of my projects include 
            a compiler for a vector language which targets LLVM IR (team of 4), and a virtual CPU + assembler for 
            a custom toy ISA. 
            
            <br></br> <br></br>
            These, along with others, are pinned on my GitHub, however, since no one enjoys clicking through 
            the source files of a github repo, the <a href="./projects#/projects">projects</a> page will soon have a loaded up terminal to 
            run my programs in the browser.  
            
            <br></br> <br></br>
            I learned the fundamentals by implementing some of the suggested projects in    
            <a href='https://github.com/geohot/fromthetransistor' target='_blank'>  this Github blog</a>, 
            which I'm continuing to let guide my exploration.   
                      
            <br></br> <br></br>
            Beside low-level programming, I have experience with modern 
            tools. I've become close with Git by
            working in group projects ranging from 4-6 people. 
            
            <br></br> <br></br>
            I'm in a continual loop of learning React. It always seems to find a 
            use case (including this website :p).   
            
            <br></br> <br></br>
            Last summer, I gained some real world experience working as a Full Stack 
            at a <a href="https://bitsinglass.com/" target='_blank'>Bits In Glass</a>
            , a local Edmonton company. There I learned the ropes of AGILE development
            where we operated in two-week sprints. I was lucky to be placed on a project 
            at its inception and see it fully through its ~3 month development cylce. 
            
           
            <br></br> <br></br>
            Outside of computers, I enjoy reading, running and playing sports like hockey
            and soccer. This is my   
            <a href="https://www.goodreads.com/user/show/137002609-justin-meimar" 
                target='_blank' > GoodReads</a> profile, though if I'm in school my 
                book completion rate falls enormously.
            </div>
            
            <br></br> <br></br> 
            <div className="about-page-title">
                About this page.
            </div>
        </div> 
        
    );
}

export default AboutPage;