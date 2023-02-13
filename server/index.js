const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const { exec } = require("child_process");
const { stdout, stderr } = require("process");
const PORT = process.env.PORT || 3001;
const app = express();

app.use(express.json());
app.use(cors());

app.post("/post", (req, res) => {
    
    const command = req.body.input; 
   
    exec(`${command}`, (error, stdout, stderr) => {
      
      res.json({
        stdout,
        stderr
      });
    })

}); 

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});