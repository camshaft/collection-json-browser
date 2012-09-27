
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http')
  , path = require('path')
  , request = require('request');

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(require('connect-assets')({buildDir: 'public'}));
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public'), { maxAge: 365 * 24 * 60 * 60 * 1000 })); // One year
  app.use(function(req, res, next) {
    res.render('index')
  });
});

app.configure('development', function(){
  app.use(express.errorHandler());
  app.locals.pretty = true
});

app.all("/proxy", function(req, res) {
  var options = {
    uri: req.query.uri,
    method: req.method,
    headers: req.headers,
    body: req.body
  }
  delete options.headers['x-requested-with']
  delete options.headers['referer']
  delete options.headers['host']

  try {
    request(options).pipe(res);
  }
  catch(error) {
    res.send(500);
  }
});

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
