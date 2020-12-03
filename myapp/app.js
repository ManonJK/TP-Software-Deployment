const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.post('/:environment', (req, res)=>{
    let environment = req.params.environment;
    let sentence = req.query.sentence;
    if (sentence == undefined){
      res.send('Hello ' + environment + '! \n');
    } else {
      res.send('Hello ' + environment + '! \n' + sentence + '\n');
    }
    
})

app.listen(port, () => {
  console.log("Example app listening at http://localhost:" + port)
})

app.use(function (req, res, next) {
  res.status(404).send("Sorry can't find that!")
})