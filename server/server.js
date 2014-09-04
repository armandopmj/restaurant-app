///////////////////////////////////////////////////////
// pull in required files
var http = require("http");
var url = require('url');
var sendResponse = require('./helpers').sendResponse;
// var getRestaurants = require('./queries').getRestaurants; // D: ERROR WITH CONNECT!!
var getRestaurants = function(){console.log('hey')}; // D: ERROR WITH CONNECT!!

///////////////////////////////////////////////////////
// set up server config
var ip = "127.0.0.1";
var port = 5555;

///////////////////////////////////////////////////////
// main server router
var router = function(request, response) {
  var path = url.parse(request.url, true).pathname;
  var query = url.parse(request.url, true).query;
  var method = request.method;
  var status = 200;
  var reply = 'server works';

  if (method === 'OPTIONS') {
    sendResponse(response, reply, status);
  } else if (method === 'GET') {
    if (path === '/customer/search-criteria' && query.find_distance > 0) {
      getRestaurants(response, query, sendResponse);
    } else {
      sendResponse(response, reply, status);
    }
  } else if (method === 'POST') {
    sendResponse(response, reply, status);
  } else {
    status = 404;
    reply = "Bad page";
    sendResponse(response, reply, status);
  }
}

///////////////////////////////////////////////////////
// fire up the server
var server = http.createServer(router);
server.listen(port, ip);

console.log("Listening");

///////////////////////////////////////////////////////
// D: PubNub
var pubnub = require("pubnub").init({
    publish_key   : "pub-c-2c4e8ddb-7e65-4123-af2d-ef60485170d4",
    subscribe_key : "sub-c-693a352e-3394-11e4-9846-02ee2ddab7fe"
});

/* ---------------------------------------------------------------------------
Publish Messages
--------------------------------------------------------------------------- */
var message = { "some" : "data" };
pubnub.publish({ 
    channel   : 'my_channel',
    message   : message,
    callback  : function(e) { console.log( "SUCCESS!", e ); },
    error     : function(e) { console.log( "FAILED! RETRY PUBLISH!", e ); }
});

//  ---------------------------------------------------------------------------
// Listen for Messages
// --------------------------------------------------------------------------- 
pubnub.subscribe({
    channel  : "my_channel",
    callback : function(message) {
        console.log( " > ", message );
    }
});

/* ---------------------------------------------------------------------------
Type Console Message
--------------------------------------------------------------------------- */
var stdin = process.openStdin();
stdin.on( 'data', function(chunk) {
    pubnub.publish({
        channel : "my_channel",
        message : ''+chunk
    });
});

