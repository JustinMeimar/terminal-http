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
    

    const program = req.body.program; 
    const input = req.body.input; 
    
    console.log("recieved program: ", program);
    console.log("received input:", input);
    
    try {
      exec(`./programs/${program} ${input}`, (error, stdout, stderr) => {        
        res.json({
          stdout,
          stderr
        });
      })
    } catch(exception) {
      console.log(exception)
    } 
}); 

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});