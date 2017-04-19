const http  = require('http');
const fs    = require('fs');
const sql   = require('mssql');
const hb    = require('handlebars');

function bindToTemplate(templateFileName, templateData, callback) {
    fs.readFile(templateFileName, 'utf8', function(fileError, template) {
        if(fileError) {
            callback(fileError);
        } else {
            callback(false, hb.compile(template)(templateData));
        }
    });
}

function sendResponse(response, file, templateData) {
    bindToTemplate(file, templateData, function(error, result) {
        if(error) {
            response.end(`${error}`);
        } else {
            response.end(result);
        }
    });
}

function query(queryToExec, callback) {
   new sql.Request().query(queryToExec, callback);
}

function send404(request, response, message) {
    response.statusCode = 404;
    console.log(`Responding with 404: ${message}`);
    sendResponse(response, './error.html', {message});
}

function send500(request, response, message) {
    response.statusCode = 500;
    console.log(`Responding with 500: ${message}`);
    sendResponse(response, './error.html', {message});
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

        if(endpoint.mime) {
            response.setHeader('Content-Type', endpoint.mime);
        }

        response.end(data);
    });
}

function handleDynamic(endpoint, request, response) {
    console.log(`Responding with dynamic content at endpoint: ${endpoint.url}`);
    try {
        fs.readFile(`.${endpoint.url}.sql`, 'utf8', function(fileError, queryString) {
            if(fileError) {
                response.end(`${fileError}`);
            }

            console.log("Executing query: -------------------------------------------")
            console.log(queryString);
            console.log('------------------------------------------------------------');

            query(queryString, function (queryError, queryData) {
                if(queryError) {
                    response.end(`${queryError}`);
                    return;
                }

                if(endpoint.noResult) {
                    sendResponse(response, './result.html', {
                        url: endpoint.url,
                        query: queryString
                    });
                } else {                   
                    sendResponse(response, './result.html', {
                        headers: endpoint.columnNames,
                        query: queryString,
                        url: endpoint.url,
                        rows: queryData.recordset.map(item => endpoint.columns.map(colName => item[colName]))
                    });
                }
            });
        });
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

    const endpoint = endpoints.filter(ep => ep.url === request.url)[0];

    if(!endpoint) {
        send404(request, response, `no mapping for ${request.url}`);
        return;
    }

    const handler = endpoint.static ? handleStatic : handleDynamic;

    handler(endpoint, request, response);
}

function run(config, endpoints) {
    console.log(`Attempting to connect to database with configuration: ${JSON.stringify(config.sql)}`);

    sql.connect(config.sql, function(error) {
        if(error) {
            console.log(`Error connecting to database: '${error}'`);
            return;
        }

        console.log('Connected to database successfully!');

        http.createServer(function(request, response) {
            handleRequest(endpoints, request, response);
            
        }).listen(config.server.port, config.server.hostname, function() {

            console.log(`Server started at: http://${config.server.hostname}:${config.server.port}`);
            console.log(`Registered endpoints: [${endpoints.map(i => ' ' + i.url)}]`);
        });
    });
}

module.exports = { run };