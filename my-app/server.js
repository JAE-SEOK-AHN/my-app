const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = process.env.PORT || 5000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true}));

app.get('/api/custormers', (req, res) => {
    res.send([
        {
        'id' : 1,
        'image' : 'https://placeimg.com/64/64/1',
        'name' : 'Jae-Seok Ahn',
        'birthday' : '980601',
        'gender' : 'Male',
        'job' : 'student' 
        },
        {
        'id' : 2,
        'image' : 'https://placeimg.com/64/64/2',
        'name' : 'Jun-tae Kim',
        'birthday' : '960102',
        'gender' : 'Male',
        'job' : 'baseball player' 
        },
        {
        'id' : 3,
        'image' : 'https://placeimg.com/64/64/3',
        'name' : 'Ji-hoon Choi',
        'birthday' : '951234',
        'gender' : 'Male',
        'job' : 'baseball player' 
        }
      ]);    
})

app.listen(port, () => console.log(`Listening on port ${port}`));