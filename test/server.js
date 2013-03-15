/**
 * Module dependencies.
 */

var express = require('express');

var app = module.exports = express();

var port = 8080;

// Configuration

app.configure(function(){
  	app.set('views', __dirname + '/views');
  	app.set('view options', {layout: false});
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

// Routes

app.get('/', function(req, res){
	res.sendfile(__dirname + '/index.html');
});

app.listen(port, function(){
  console.log("express-bootstrap app running at "+port);
});