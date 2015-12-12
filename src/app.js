var express = require('express');
var bodyParser = require('body-parser');
var app = express();

var routes = {
    categories: require('expenses/routes/categories.js')
};

// parse application/json body automatically
app.use(bodyParser.json());

// Get user profile
app.get('/users/:id', function (req, res) {
    pg.connect(conString, function(err, client, done){
        client.query('SELECT id, firstname, lastname FROM users WHERE user_id=$1::int', [req.params.id],
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
});


// Get all users
app.get('/users', function (req, res) {
    pg.connect(conString, function(err, client, done){
        client.query('SELECT id, firstname, lastname FROM users',
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
});

// Users



// Categories
app.get('/categories', routes.categories.get);
app.post('/categories', routes.categories.post);
app.put('/categories/:id', routes.categories.put);
app.delete('/categories/:id', routes.categories.delete);





app.listen(3000);