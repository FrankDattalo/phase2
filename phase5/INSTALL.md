step 1: clone the repo
step 2: cd into this phone 
step 3: install mssql & handlebars
`$ npm install mssql`
`$ npm install handlebars`
step 4: Open SQLServer Management Studio
step 5: right click on server -> click properties
step 6: change server name in endpoints.js to server name that is specified in this window
step 7: go to security tab of properties menu
step 8: change logons to allow both sqlserver logons as well as windows logons
step 9: save these settings and close the window
step 10: expand server -> go to security -> go to logons
step 11: go to logon sa -> right click -> properties -> change password to a specified password of your choice -> save this and update it in endpoints.js as well
step 12: uncheck enfore password policy for the sa user
step 13: go to logon tab of sa user (if there isnt a logon tab to go security tab) -> set logon to enabled
step 14: save and close the users properties
step 15: go to sql server configuration manager
step 16: go to network services tab (i did 64 bit)
step 17: right click on TCP/IP services -> set to enable
step 18: save configuration
step 19: restart services or restart computer
step 20: try running server, if database connects and server doesn't start, change port to 8080 in endpoints.js
