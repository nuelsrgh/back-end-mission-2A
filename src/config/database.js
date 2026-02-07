const {Client} = require('pg')

const db = new Client({
    host:"localhost",
    user:"postgres",
    port: 5432,
    password:"admin123",
    database:"edu_course"
})

db.connect();

module.exports = db;

// client.connect();
// client.query(`Select * from users`, (err, res)=>{
//     if(!err){
//         console.log(res.rows);
//     }else{
//         console.log(err.message);
//     }

//     client.end;
// })