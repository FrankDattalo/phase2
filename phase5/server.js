const http  = require('http');
const fs    = require('fs');
const sql   = require('mssql');


function handleRequest(request, response) {

}

function run(config) {
    console.log(`Attempting to connect to database with configuration: ${config.sql}`);

    sql.connect(config.sql, function(sqlerror) {
        if(sqlerror) {
            console.log(`Error connecting to database: ${sqlerror}`);
            return;
        }

        http.createServer(handleRequest)
        .listen(config.server.port, config.server.hostname, function() {
            console.log(`Server started at: http://${config.server.hostname}:${config.server.port}`);
        });
    });
}

module.exports = run;