var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var routes = {
    categories: require('expenses/routes/categories.js'),
    users: require('expenses/routes/users.js'),
    expenses: require('expenses/routes/expenses.js')
};


// Parse application/json body automatically
app.use(bodyParser.json());

// Allow CORS
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "DELETE, GET, POST, PUT");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

// Users
app.get('/users/:id', routes.users.get);
app.get('/users', routes.users.list);

// Categories
app.get('/categories', routes.categories.list);
app.post('/categories', routes.categories.post);
app.put('/categories/:id', routes.categories.put);
app.delete('/categories/:id', routes.categories.delete);

// Expenses
app.get('/users/:userId/expenses', routes.expenses.list);
app.get('/users/:userId/expenses/monthly', routes.expenses.listMonthly);
app.post('/users/:userId/expenses', routes.expenses.post);
app.put('/users/:userId/expenses/:id', routes.expenses.put);
app.delete('/users/:userId/expenses/:id', routes.expenses.delete);


// Run the server
app.listen(3000);