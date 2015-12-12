var db = require('db/db.js');

exports.get = function (req, res) {
    db(function(err, client, done){
        client.query('SELECT * FROM categories',
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};

exports.post = function (req, res) {
    if(!req.body.name) {
        res.status(400).send('Missing `name` parameter!');
        return;
    }

    db(function(err, client, done){
        client.query('INSERT INTO categories(name) values($1::text)', [req.body.name],
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};

// Create a new category
exports.put = function (req, res) {
    if(!req.body.name) {
        res.status(400).send('Missing `name` parameter!');
        return;
    }

    db(function(err, client, done){
        client.query('UPDATE categories SET name=$2::text WHERE id=$1:int', [req.params.id, req.body.name],
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};

// Delete a category
exports.delete = function (req, res) {
    db(function(err, client, done){
        client.query('DELETE FROM categories WHERE id=$1::int', [req.params.id],
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};