const http  = require('http');
const fs    = require('fs');
const sql   = require('mssql');

function mapArray(array, aroundElement) {
    return array.map((item) => `<${aroundElement}>${item}</${aroundElement}>`).reduce((total, item) => total + item, '');
}

function begin(response, tableHeadersArray, query, url) {
    const headers = tableHeadersArray ? mapArray(tableHeadersArray, 'th'): '';

    response.totalResponse = 
    `<!DOCTYPE html><html><head><title>Phase 5 - ${url}</title></head><body><center>
        <pre>
            <h2><a href="/">Home</a> - ${url}</h2>
            <table border="1" cellpadding="15">
                <tr><td>${query}</td></tr>
            </table>
            <table border="1" cellpadding="15">
                ${headers}`;
}

function row(response, rowArray) {
    const rowhtml = mapArray(rowArray, 'td');
    response.totalResponse += `<tr>${rowhtml}</tr>`;
}

function end(response) {
    response.totalResponse += `</table></pre></center></body></html>`;
    response.end(response.totalResponse);
}

function query(queryToExec, callback) {
   new sql.Request().query(queryToExec, callback);
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
        fs.readFile(`.${endpoint.url}.sql`, 'utf8', function(fileError, queryString) {
            query(queryString, function (queryError, queryData) {
                if(queryError) {
                    response.end(queryError);
                    return;
                }

                begin(response, endpoint.columnNames, queryString, endpoint.url);

                queryData.recordset.map(dataElement => 
                    endpoint.columns.map(name => dataElement[name])
                ).forEach(dataElement => row(response, dataElement));

                end(response);
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
        send404(request, response);
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

        http.createServer(function(request, response) {
            handleRequest(endpoints, request, response);
            
        }).listen(config.server.port, config.server.hostname, function() {

            console.log(`Server started at: http://${config.server.hostname}:${config.server.port}`);
            console.log('Registered endpoints: [');
            endpoints.forEach(endpoint => console.log(`-> ${endpoint.url}`));
            console.log(']');
        });
    });
}

module.exports = { run };