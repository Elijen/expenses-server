var pg = require('pg');
var conString = 'postgres://expenses:pazz123@localhost/expenses'; //move to a config/env

module.exports = function(callback) {
    return pg.connect(conString, callback);
};