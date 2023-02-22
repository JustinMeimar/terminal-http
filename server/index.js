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
  
    const programs = ["nfa-regex", "b-tree"]
    const program = req.body.program; 
    const input = req.body.input; 
    
    console.log("recieved program: ", program);
    console.log("received input:", input);
      
    let bin_path = './programs'
    switch (program) {
      //set up the binary path for the program recieved 
      case programs[0]:
        bin_path += '/nfa-regex/bin/regex'; 
        break;
      case programs[1]:
        bin_path += '/B-Tree/bin/btree'; 
        break;
    }
    console.log("bin_path:", bin_path);

    try {
      exec(`${bin_path} ${input}`, (error, stdout, stderr) => {      
        res.json({
          stdout,
          stderr
        });
      })
    } catch(exception) {
      console.log(exception);
    } 
}); 

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});