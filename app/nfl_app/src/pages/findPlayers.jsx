import React, { useState } from "react";
import axios from 'axios';
import './findPlayers.css';

const FindPlayers = () => {
  const [fields, setFields] = useState({
    division: "",
    team: "",
    position_type: "",
    position_name: "",
    lname: "",
  });

  const [players, setPlayers] = useState([]);

  const handleChange = (e) => {
    setFields((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.get('http://localhost:8800/findPlayers', {
        params: fields
      });
      setPlayers(response.data);  // Update the state with the response data
      setFields({ division: "", team: "", position_type: "", position_name: "", lname: "" }); // Clear the fields
    } catch (err) {
      console.log(err);
    }
  };

  return (
    <div className="find_players_form">
      <h1>Find Players</h1>
      <form onSubmit={handleSubmit}>
        <input type="text" placeholder="Division" onChange={handleChange} name="division" value={fields.division} />
        <input type="text" placeholder="Team" onChange={handleChange} name="team" value={fields.team} />
        <input type="text" placeholder="Position Type" onChange={handleChange} name="position_type" value={fields.position_type} />
        <input type="text" placeholder="Position" onChange={handleChange} name="position_name" value={fields.position_name} />
        <input type="text" placeholder="Last Name" onChange={handleChange} name="lname" value={fields.lname} />
        <button type="submit"> Search </button>
      </form>

      <div>
        {players.length > 0 && (
          <table>
            <thead>
              <tr>
                <th>Player Name</th>
                <th>Team</th>
                <th>Division</th>
                <th>Position</th>
                {/* Add other relevant headers here */}
              </tr>
            </thead>
            <tbody>
              {players.map((player, index) => (
                <tr key={index}>
                  <td>{`${player.fname} ${player.lname}`}</td>
                  <td>{player.team_name}</td>
                  <td>{player.division_name}</td>
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
