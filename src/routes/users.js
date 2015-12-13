var db = require('expenses/db/db.js');

// Get a user profile
exports.get = function (req, res) {
    db(function(err, client, done){
        client.query('SELECT id, firstname, lastname FROM users WHERE user_id=$1::int', [req.params.id],
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};

// List all users
exports.list = function (req, res) {
    db(function(err, client, done){
        client.query('SELECT id, firstname, lastname FROM users',
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};