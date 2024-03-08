import React, { useState } from "react";
import axios from 'axios';

const FindPlayers = () => {
  const [fields, setFields] = useState({
    team: "",
    position_type: "",
    position_name: "",
  });

  const [players, setPlayers] = useState([]);

  const handleChange = (e) => {
    setFields((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  const handleClick = async e => {
    e.preventDefault();
    try {
      const response = await axios.get('http://localhost:8800/findPlayers', {
        params: {
          team: fields.team,
          position_type: fields.position_type,
          position_name: fields.position_name,
          lname: fields.lname
        }
      });
      setPlayers(response.data);  // Update the state with the response data
    } catch (err) {
      console.log(err);
    }
  };

  return (
    <div className="find_players_form">
      <h1>Find Players</h1>
      <input type="text" placeholder="Team" onChange={handleChange} name="team" />
      <input type="text" placeholder="Position Type" onChange={handleChange} name="position_type" />
      <input type="text" placeholder="Position" onChange={handleChange} name="position_name" />
      <input type="text" placeholder="Last Name" onChange={handleChange} name="lname" />
      <button onClick={handleClick}> Search </button>

      <div>
        {players.length > 0 && (
          <table>
            <thead>
              <tr>
                <th>Player Name</th>
                <th>Team</th>
                <th>Position</th>
                {/* Add other relevant headers here */}
              </tr>
            </thead>
            <tbody>
              {players.map((player, index) => (
                <tr key={index}>
                  <td>{`${player.fname} ${player.lname}`}</td>
                  <td>{player.team_name}</td>
                  <td>{player.position_name}</td>
                  {/* Add other player data here */}
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
};

export default FindPlayers;
