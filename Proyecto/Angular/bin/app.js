var http = require('http'),
    path = require('path'),
    express = require('express');


var app_name = 'Angular Fobos-e Development',
    port = process.argv[2],
    app = express();
// Server listener:


app.use(express.static(path.resolve('../app')));

app.all('/*', function(req,res,next){
    return res.sendfile(path.resolve('../app/index.html'));
});


app.listen(8080);
