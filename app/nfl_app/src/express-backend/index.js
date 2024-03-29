import express from "express";
import mysql from "mysql";
import cors from "cors";

//run backend with npm start

const app = express()

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "1234",
    database: "nfl",
})

// if there is an auth problem, run this code in the SQL file
//ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your password';

app.use(express.json())
app.use(cors())

app.get("/", (req, res) => {
    res.json("this is the backend")
})

//get all teams (no dynamic query fields)
app.get("/teams", (req, res) => {
    const q = `
      SELECT Team.*, Coach.*
      FROM Team
      INNER JOIN Coach ON Team.team_id = Coach.team_id`

    db.query(q, (err, data) => {
        if(err) return res.json(err)
        return res.json(data)
    })
})

//select from DB with fields specified in find_player_form
app.get("/findPlayers", (req, res) => {
    let { division, team, position_type, position_name, lname } = req.query;
  
    let q = `
      SELECT Player.*, Player_Stats.*, Team.team_name, Player_Position.position_name, Division.division_name,
      CASE WHEN Player_Stats.player_id IS NOT NULL THEN TRUE ELSE FALSE END AS has_stats
      FROM Player
      INNER JOIN Team ON Player.team_id = Team.team_id
      INNER JOIN Player_Position ON Player.position_id = Player_Position.position_id
      INNER JOIN Division ON Team.division_id = Division.division_id
      LEFT JOIN Player_Stats ON Player.player_id = Player_Stats.player_id

      WHERE 1=1
    `;
  
    if (team) {
      q += ` AND Team.team_name LIKE '%${team}%'`;
    }
  
    if (position_type) {
      q += ` AND Player_Position.position_type LIKE '%${position_type}%'`;
    }
  
    if (position_name) {
      q += ` AND Player_Position.position_name LIKE '%${position_name}%'`;
    }

    if (lname) {
        q += ` AND Player.lname LIKE '%${lname}%'`;
      }

    if (division) {
        q += ` AND Division.division_name LIKE '%${division}%'`;
    }
  
    db.query(q, (err, data) => {
      if (err) return res.json(err);
      return res.json(data);
    });
  });

  

app.listen(8800, ()=> {
    console.log("connected to backend")
})