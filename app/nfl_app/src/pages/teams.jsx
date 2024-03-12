import React from "react";
import { useState, useEffect } from "react";
import axios from 'axios'
import './teams.css';


const Teams = () => {
  const [teams, setTeams] = useState([])

  useEffect(()=> {
    const fetchAllTeams = async () => {
        try{
            const res = await axios.get("http://localhost:8800/teams")
            setTeams(res.data)
            console.log(res)
        }catch(err){
            console.log(err)
        }
    }
    fetchAllTeams()
  }, [])

  return (
    <div>
      <h1>Teams</h1>
      <table>
        <thead>
          <tr>
            <th>Team Name</th>
            <th>City</th>
            <th>State</th>
            <th>Wins</th>
            <th>Losses</th>
            <th>Ties</th>
          </tr>
        </thead>
        <tbody>
          {teams.sort((a, b) => b.wins - a.wins).map(team => (
            <tr key={team.team_id}>
              <td>{team.team_name}</td>
              <td>{team.city}</td>
              <td>{team.state}</td>
              <td>{team.wins}</td>
              <td>{team.losses}</td>
              <td>{team.ties}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
  
};

export default Teams;
