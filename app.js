const http = require('http');
const express = require('express');
const fs = require('fs');
const ejs = require('ejs');
const bodyParser = require('body-parser');
const { exec } = require('child_process');

const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.set('view engine', 'ejs');
app.set('views', './views');

app.get('/', (req, res) => {
  res.render('index', {
    title: 'SnyAir'
  });
});

app.post('/send', function(req, res) {
  send(req.body.dep, req.body.arr);
  res.sendStatus(200);
});

function send(dep, arr) {
  console.log('\n\nDepart:', dep, '\nArrivée:', arr, '\n');
  exec('./snyair-flight.sh ' + dep + ' ' + arr, (error, stdout) => {
    if (error) {
      console.error(`exec error: ${error}`);
      return;
    }
    console.log(`${stdout}`);
  });
}

app.get('/a', (req, res) => {
  fs.readFile('index.html', 'utf8', (err, data) => {
    if (err) {
      res.status(500).send('Error reading file');
    } else {
      res.send(data);

    }
  });
});

app.listen(2828, () => {
  console.log('Server listening on http://localhost:2828');
});