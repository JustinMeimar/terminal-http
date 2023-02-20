import {HashRouter as Router, Route, Link} from 'react-router-dom';
import HomePage from "./pages/HomePage.js";
import ProjectsPage from "./pages/ProjectsPage.js";
import AboutPage from './pages/AboutPage.js';
import Gazprea from './pages/projects/Gazprea.js'
import ResumePDF from '../static/Resume.pdf'


function MainRouter() {
  return (
    <Router basename="/">
      <div className="App"> 
        <div className="AppNav">
          <Link to="/">Home </Link> 
          <Link to="/projects">Projects </Link>
          <Link to="/about">About </Link>
          <a href={ResumePDF} target="_blank" rel="noopener noreferrer">Resume </a>
        </div> 
        <br></br>
        <div className="AppRoutes">
           {/*main page routes*/}
          <Route exact path="/" component={HomePage}/> 
          <Route exact path="/about" component={AboutPage}/> 
          <Route exact path="/projects" component={ProjectsPage}></Route>
           
           {/*main page routes*/}
          <Route exact path="/projects/gazprea" component={Gazprea}></Route> 
        </div> 
      </div>
    </Router>     
  );
}

export default MainRouter;