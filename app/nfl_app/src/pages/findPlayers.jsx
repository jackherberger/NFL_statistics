import React, { useState } from "react";
import axios from "axios";
import "./findPlayers.css";

const FindPlayers = () => {
  const [fields, setFields] = useState({
    division: "",
    team: "",
    position_type: "",
    position_name: "",
    lname: "",
  });

  const [players, setPlayers] = useState([]);
  const [playerStats, setPlayerStats] = useState({});

  const handleChange = (e) => {
    setFields((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.get("http://localhost:8800/findPlayers", {
        params: fields,
      });
      setPlayers(response.data); // Update the state with the response data
      setFields({
        division: "",
        team: "",
        position_type: "",
        position_name: "",
        lname: "",
      }); // Clear the fields
    } catch (err) {
      console.log(err);
    }
  };

const fetchPlayerStats = async (playerId) => {
  if (playerStats[playerId]) {
    // If stats are already loaded, toggle their visibility
    setPlayerStats(prevStats => ({ ...prevStats, [playerId]: null }));
  } else {
    // Fetch and display stats
    try {
      const response = await axios.get('http://localhost:8800/findPlayerStats', {
        params: { player_id: playerId }
      });
      setPlayerStats(prevStats => ({ ...prevStats, [playerId]: response.data }));
    } catch (err) {
      console.log(err);
    }
  }
};

  return (
    <div className="find_players_form">
      <h1>Find Players</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Division"
          onChange={handleChange}
          name="division"
          value={fields.division}
        />
        <input
          type="text"
          placeholder="Team"
          onChange={handleChange}
          name="team"
          value={fields.team}
        />
        <input
          type="text"
          placeholder="Position Type"
          onChange={handleChange}
          name="position_type"
          value={fields.position_type}
        />
        <input
          type="text"
          placeholder="Position"
          onChange={handleChange}
          name="position_name"
          value={fields.position_name}
        />
        <input
          type="text"
          placeholder="Last Name"
          onChange={handleChange}
          name="lname"
          value={fields.lname}
        />
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
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {players.map((player, index) => (
                <React.Fragment key={index}>
                  <tr>
                    <td>{`${player.fname} ${player.lname}`}</td>
                    <td>{player.team_name}</td>
                    <td>{player.division_name}</td>
                    <td>{player.position_name}</td>
                    <td>
                      <button onClick={() => fetchPlayerStats(player.player_id)}>
                        {playerStats[player.player_id] ? "Hide Stats" : "Show Stats"}
                      </button>
                    </td>
                  </tr>
                  {playerStats[player.player_id] && (
                    <tr>
                      <td colSpan="5">
                        {/* Add columns for each stat */}
                        <td>Rushing Yards</td>
                        <td>Passing Yards</td>
                        <td>Recieving Yards</td>
                        <td>Loss</td>
                        {/* Display player stats here */}
                        <tr>
                          <td>{playerStats[player.player_id].rush_yds}</td>
                          <td>{playerStats[player.player_id].pass_yds}</td>
                          <td>{playerStats[player.player_id].rec_yds}</td>
                          <td>{playerStats[player.player_id].loss}</td>
                        </tr>
                      </td>
                    </tr>
                  )}
                </React.Fragment>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
};

export default FindPlayers;
