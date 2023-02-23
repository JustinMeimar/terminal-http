const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const { exec } = require("child_process");
const fs = require("fs");
const { stdout, stderr } = require("process");
const path  = require("path");
require("dotenv").config();
const PORT = process.env.PORT || 436;
const app = express();

app.use(express.json());
app.use(cors());

app.get("/", (req, res) => {
  console.log("recieved");
  res.send("Hello, Curl\n");
});

app.get("/file", (req, res) => {

  const fileName = req.query.program;
  fs.readFile(`./inputs/${fileName}.txt`, 'utf8', (err,data) => {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
    }
  })
});

app.post("/post", (req, res) => {
  
    const programs = ["nfa-regex", "b-tree", "gazprea"]
    const program = req.body.program; 
    const input = req.body.input; 
    
    console.log("recieved program: ", program);
    console.log("received input:", input);

    const execute_gazprea = () => {

      console.log("executing gazprea");
      
      const gazc_path = "./bin/gazc";
      const libgazrt_path = "./bin/libgazrt.so";
      
      const temp_in = "./tmp/prog.in" 
      const temp_ll = "./tmp/prog.ll"

      const run_executable = () => {
        // run the executable and return the stdout to client
        exec(`sudo LD_PRELOAD=${ libgazrt_path } tmp/prog`, (error, stdout, stderr) => {      
          if (error) {
            console.log(error);
            throw new Error("error in running the executable");
          } else {
            console.log("success!");
            res.json({
              stdout, 
              stderr
            });
          }
        });
      }

      const compile_to_executable = () => {
        // use clang to compile .o and link with runtime
        exec(`clang tmp/prog.o ${libgazrt_path} -o tmp/prog`, (error) => {
          if (error) { 
            // console.log("error in clang step", error); 
            // return; 
          } else {
            console.log("successful - compile to executable");
            run_executable();
          }
        });
      }

      const compile_to_obj = () => {
        // use llc to compile .ll to .o
        exec(`llc -filetype=obj ${temp_ll} -o tmp/prog.o`,(error) => {
          if (error) {  
            // throw new Error("failed to compile to .o");
          } else {
            console.log("successful - compile to .o");
            compile_to_executable();
          }
        }); 
      }

      const compile_to_ll = () => {
        // try to compile input to ll
        exec(`${gazc_path} ${temp_in} ${temp_ll}`, (error, stdout, stderr) => {
          if (error) { 
            console.log(stderr);
            res.json({stdout, stderr});
            // throw new Error("failed to compile to .ll");
          } else {
            console.log("successful - compile to .ll");
            compile_to_obj();
          }
        });
      }      

      const write_to_file = () => {
        // Write the input file to a text file
        fs.writeFile(temp_in, input, (err) => {
          if (err) {
            // throw new Error("failed to write file");
          } else {
            console.log(`Successfully wrote to file ${temp_in}`);
            compile_to_ll();
          }
        }); 
      }

      //clean tmp folder
      exec('./clean.sh', (error) => {
        if (error) {
          throw new Error("clean failed");
        } else { 
          write_to_file();
        }
      });
 
    } 
    // let bin_path = './programs'
    switch (program) {
      //set up the binary path for the program recieved 
      case programs[0]:
        break;
      case programs[1]:
        break;
      case programs[2]:
        try {         
          execute_gazprea();
        } catch(exception) {
          console.log("problem executing gazprea");
        } 
    } 
}); 

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});