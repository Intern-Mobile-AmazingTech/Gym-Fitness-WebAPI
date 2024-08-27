//import sql from 'mssql';
const sql = require('mssql');

const config = {
    user: 'sa',
    password: '123',
    server: 'localhost',
    database: 'gym_fitness',
    options: {
        encrypt: true, // for azure
        trustServerCertificate: true, // change to true for local dev / self-signed certs
        characterSet: 'utf8',
    }
};

async function connectDB() {
    try {
        let pool = await sql.connect(config);
        return pool;
    } catch (err) {
        console.log('Database Connection Failed! Bad Config: ', err);
        throw err;
    }
}

module.exports = {
    connectDB,
    sql // Export sql for reuse
}