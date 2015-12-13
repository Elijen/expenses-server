var db = require('expenses/db/db.js');
var sql = require('sql');

var expenses = sql.define({
    name: 'expenses',
    columns: ['id', 'user_id', 'category_id', 'year', 'month', 'week', 'day', 'amount', 'note']
});


// List expenses for a user
exports.list = function (req, res) {
    db(function(err, client, done) {
        client.query('SELECT * FROM expenses WHERE user_id=$1::int ORDER BY year DESC, month DESC, day DESC, id DESC', [req.params.userId],
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};

// List expenses grouped by month
exports.listMonthly = function (req, res) {
    db(function(err, client, done) {
        client.query('SELECT SUM(amount) AS amount, COUNT(*) AS count, month, year ' +
            'FROM expenses WHERE user_id=$1::int ' +
            'GROUP BY year, month ' +
            'ORDER BY year DESC, month DESC', [req.params.userId],
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};

// Add a new expense
exports.post = function (req, res) {
    db(function(err, client, done) {
        var expense = req.body;
        expense.user_id = req.params.userId;
        expense.date = new Date(expense.date);
        expense.year = expense.date.getFullYear();
        expense.day = expense.date.getDate();
        expense.month = expense.date.getMonth() + 1;
        delete expense.date;

        var query = expenses.insert(expense).toQuery();

        client.query(query.text, query.values,
            function(err, result) {
                done();
            }
        );

        client.query("SELECT * FROM expenses WHERE id=currval('expenses_id_seq')",
            function(err, result) {
                done();
                res.json(result.rows[0]);
            }
        );
    });
};

// Edit a category name
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
    db(function(err, client, done) {
        client.query('DELETE FROM expenses WHERE id=$1::int', [req.params.id],
            function(err, result) {
                done();
                res.json(result.rows);
            }
        );
    });
};