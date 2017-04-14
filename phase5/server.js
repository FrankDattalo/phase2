const http  = require('http');
const fs    = require('fs');
const sql   = require('mssql');


function begin(response, tableHeadersArray) {
    const headers = tableHeadersArray.map(item => `<th>${item}</th>`).reduce((total, item) => total + item, '');

    response.totalResponse = 
    `<!DOCTYPE html>
        <html>
            <head>
                <title>Phase 5</title>
            </head>
            <body>
                <center>
                    <pre>
                        <h2><a href="/">Home</a></h2>
                        <table border="1" cellpadding="15">
                            ${headers}`;
}

function row(response, rowArray) {
    const rowhtml = rowArray.map(item => `<td>${item}</td>`).reduce((total, item) => total + item, '');
    response.totalResponse += 
                            `<tr>${rowhtml}</tr>`;
}

function end(response) {
    response.totalResponse +=
                        `</table>
                    </pre>
                </center>
            </body>
        </html>`;
    response.end(response.totalResponse);
}

function execQuery(query, callback) {
   new sql.Request().query(query, callback);
}

function send404(request, response, message) {
    response.statusCode = 404;
    if(!message) {
        message = `No mapping for ${request.url}`;
    }
    response.end(`<!DOCTYPE html><html><body>${message}</body></html>`);
}

function send500(request, response, message) {
    response.statusCode = 500;
    if(!message) {
        message = `Internal Server Error for ${request.url}`;
    }
    response.end(`<!DOCTYPE html><html><body>${message}</body></html>`);
}

function handleStatic(endpoint, request, response) {
    if(!endpoint.fileLocation) {
        endpoint.fileLocation = '.' + endpoint.url;
    }

    console.log(`Responding with static content at endpoint: ${endpoint.url} from file ${endpoint.fileLocation}`);
    fs.readFile(endpoint.fileLocation, 'utf8', function(error, data) {
        if(error) {
            send500(request, response, `handle static failed for ${request.url}`);
            return;
        }

        response.end(data);
    });
}

function handleDynamic(endpoint, request, response) {
    console.log(`Responding with dynamic content at endpoint: ${endpoint.url}`);
    try {
        endpoint.handler(request, response);
    } catch (e) {
        console.log(e);
        send500(request, response, `handle dynamic failed for ${request.url}`);
    }
}

function handleRequest(endpoints, request, response) {
     console.log(`Request recieved: ${request.url}`);

    response.statusCode = 200;
    response.setHeader('Access-Control-Allow-Origin', '*');
    response.setHeader('Content-Type', 'text/html');

    for(const endpoint of endpoints) {
        if(endpoint.url === request.url) {
            if(endpoint.static) {
                handleStatic(endpoint, request, response);
            } else {
                handleDynamic(endpoint, request, response);
            }
            
            return;
        }
    }

    send404(request, response);
}

function run(config, endpoints) {
    

    console.log(`Attempting to connect to database with configuration: ${JSON.stringify(config.sql)}`);

    sql.connect(config.sql, function(error) {
        if(error) {
            console.log(`Error connecting to database: '${error}'`);
            return;
        }

        http.createServer(function(request, response) {
            handleRequest(endpoints, request, response);
        }).listen(config.server.port, config.server.hostname, function() {
            console.log(`Server started at: http://${config.server.hostname}:${config.server.port}`);
            console.log('Registered endpoints: [');
            for(const endpoint of endpoints) {
                console.log(`-> ${endpoint.url}`);
            }
            console.log(']');
        });
    });
}

module.exports = { run, begin, row, end, execQuery };