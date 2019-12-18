const mongojs = require('mongojs');
const db = mongojs('mongodb://admin:admin@ds023634.mlab.com:23634/angelhackrio');
db.on('connect', () => {
    console.log('database connected');
});

module.exports = db;