const { run, begin, row, end, execQuery }   = require('./server.js');

function handleError(response, error, callback) {
    if(error) {
        response.end(error);
    } else {
        callback();
    }
}

const endpoints = [
   /*
   {
       url: <url string>,
       static: <true or false>,
       fileLocation: <file location on disk if static is true>,
       handler: function that takes request and response if static is false
   }
   */
   {
       url: '/',
       static: true,
       fileLocation: './index.html'
   },
   {
    url: '/query1',
    handler: function(request, response) {
        execQuery(`
            select c.fName, c.lName from Customer c
            inner join Attends a on c.customerId = a.CID
            where not exists (
                select 1 from Room r
                where r.CID = c.customerId
                and r.BID = c.BID);
        `, (error, data) => handleError(response, error, () => {
            begin(response, ['First Name', 'Last Name']);
            data.recordset.forEach(element => row(response, [element.fName, element.lName]));
            end(response);
        }));
    }
   }
];

const config =  {
        server: {
            hostname: "127.0.0.1",
            port: 80
        },
        sql: {
            user: "admin",
            password: "",
            server: "DESKTOP-LKS836Q\\SQLEXPRESS",
            database: "master"
        }
};

run(config, endpoints);
