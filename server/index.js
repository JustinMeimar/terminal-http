const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const { exec } = require("child_process");
const fs = require("fs");
const { stdout, stderr } = require("process");

const PORT = process.env.PORT || 3001;
const app = express();

app.use(express.json());
app.use(cors());

app.get("/file", (req, res) => {

  const fileName = req.query.program;
  fs.readFile(`./programs/${fileName}.txt`, 'utf8', (err,data) => {
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

      // Write the input file to a text file
      fs.writeFile(temp_in, input, (err) => {
        if (err) {
          console.error(`Error writing to file ${temp_in}: ${err}`);
        } else {
          console.log(`Successfully wrote to file ${temp_ll}`);
        }
      });

      try {

        // export environment variable
        exec(`export LD_PRELOAD=${ libgazrt_path }`);
       
        // try to compile input to ll
        exec(`${gazc_path} ${temp_in} ${temp_ll}`, (error, stdout, stderr) => {
          if (error) { 
            console.log("---error---", error);  
            console.log("---stdout---", stdout);  
            console.log("---stderr---", stderr);   
            res.json({
                stdout, 
                stderr
              });
            return;
          } else {
            console.log("successful compile");
          }
        }); 
        // use llc to compile .ll to .c
        exec(`llc -fileType=obj ${temp_ll} -o tmp/prog.o`,(error) => {
          if (error) { 
            console.log("error in step: "); 
            return; 
          }
        }); 
        // use clang to compile .o and link with runtime
        exec(`clang prog.o ${libgazrt_path} -o tmp/prog`, (error) => {
          if (error) { 
            console.log("error in step: "); 
            return; 
          }
        });
        // run the executable and return the stdout to client
        exec(`./temp/prog`, (error, stdout, stderr) => {      
          if (!error) {
            res.json({
              stdout, 
              stderr
            });
          } 
        });

      } catch(exception) {
        console.log("problem executing gazprea");
      }
    } 
    // let bin_path = './programs'
    switch (program) {
      //set up the binary path for the program recieved 
      case programs[0]:
        break;
      case programs[1]:
        break;
      case programs[2]:
        execute_gazprea();
    }

 
}); 

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});