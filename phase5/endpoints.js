const { run }   = require('./server.js');

const endpoints = [
   /*
   {
       url: <url string>,
       static: <true or false>,
       fileLocation: <file location on disk if static is true>,
       columnNames: <array containing ordered column names of return query>
       mapper: <function that takes one data element and returns an array of ordered columns>
   }
   */
   {
        url: '/',
        static: true,
        fileLocation: './index.html'
   },
   {
        url: '/query1',
        columnNames: ['First Name', 'Last Name'],
        mapper: element => [element.fName, element.lName]
   },
   {
        url: '/query2',
        columnNames: ['First Name', 'Last Name'],
        mapper: element => [element.fName, element.lName]
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
