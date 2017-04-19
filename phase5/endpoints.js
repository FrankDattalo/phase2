const { run }   = require('./server.js');

const endpoints = [
    {
        url: '/',
        static: true,
        fileLocation: './index.html'
    },
    {
        url: '/query1',
        columnNames: ['First Name', 'Last Name'],
        columns: ['fName', 'lName']
    },
    {
        url: '/query2',
        columnNames: ['First Name', 'Last Name'],
        columns: ['fName', 'lName']
    },
    {
        url: '/query3',
        columnNames: ['Branch Id', 'Phone #', 'Address', 'Count'],
        columns: ['branchId', 'phoneNo', 'address', 'count']
    },
    {
        url: '/query4',
        columnNames: ['First Name', 'Last Name'],
        columns: ['fName', 'lName']
    },
    {
        url: '/query5',
        columnNames: ['Branch Id', 'Phone #', 'Cost'],
        columns: ['branchId', 'phoneNo', 'cost']
    },
    {
        url: '/query6',
        columnNames: ['Branch Id'],
        columns: ['branchId']   
    },
    {
        url: '/query7',
        columnNames: ['Room #', 'Status'],
        columns: ['roomNo', 'status']   
    },
    {
        url: '/load',
        noResult: true
    },
    {
        url: '/drop',
        noResult: true
    }
];

const config = {
    server: {
        hostname: "127.0.0.1",
        port: 80
    },
    sql: {
        user: "sa",
        password: "pw",
        server: "DESKTOP-LKS836Q\\SQLEXPRESS",
        database: "master"
    }
};

run(config, endpoints);
