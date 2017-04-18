step 1: clone the repo <br/>
step 2: cd into /phase5 <br/>
step 3: install mssql & handlebars <br/>
`$ npm install mssql` <br/>
`$ npm install handlebars` <br/>
step 4: Open SQLServer Management Studio <br/>
step 5: right click on server -> click properties <br/>
step 6: change server name in endpoints.js to server name that is specified in this window <br/>
step 7: go to security tab of properties menu <br/>
step 8: change logons to allow both sqlserver logons as well as windows logons <br/>
step 9: save these settings and close the window <br/>
step 10: expand server -> go to security -> go to logons <br/>
step 11: go to logon sa -> right click -> properties -> change password to a specified password of your choice -> save this and update it in endpoints.js as well <br/>
step 12: uncheck enfore password policy for the sa user <br/>
step 13: go to logon tab of sa user (if there isnt a logon tab to go security tab) -> set logon to enabled <br/>
step 14: save and close the users properties <br/>
step 15: go to sql server configuration manager <br/>
step 16: go to network services tab (i did 64 bit) <br/>
step 17: right click on TCP/IP services -> set to enable <br/>
step 18: save configuration <br/>
step 19: restart services or restart computer <br/>
step 20: try running server, if database connects and server doesn't start, change port to 8080 in endpoints.js <br/>

