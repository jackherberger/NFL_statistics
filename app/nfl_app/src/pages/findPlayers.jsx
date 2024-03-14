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
  const [showStats, setShowStats] = useState({});
  const [showOnlyWithStats, setShowOnlyWithStats] = useState(false);


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
      setShowStats({}); // Reset showStats state
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

  const handleCheckboxChange = () => {
    setShowOnlyWithStats(!showOnlyWithStats);
  };

  const toggleStats = (playerId) => {
    setShowStats((prevStats) => ({
      ...prevStats,
      [playerId]: !prevStats[playerId],
    }));
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
        <div>
          <input
            type="checkbox"
            checked={showOnlyWithStats}
            onChange={handleCheckboxChange}
          />
          <label>Show only players with stats</label>
        </div>
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
                <th>Stats</th>
              </tr>
            </thead>
            <tbody>
              {players
              .filter(player => !showOnlyWithStats || player.has_stats)
              .map((player, index) => (
                <React.Fragment key={index}>
                  <tr>
                    {/* Player details here */}
                    <td>{`${player.fname} ${player.lname}`}</td>
                    <td>{player.team_name}</td>
                    <td>{player.division_name}</td>
                    <td>{player.position_name}</td>
                    <td>
                      {player.has_stats ? (
                        <button onClick={() => toggleStats(player.player_id)}>
                          {showStats[player.player_id] ? "Hide" : "Show"}
                        </button>
                      ) : (
                        <span>Unavailable</span>
                      )}
                    </td>
                  </tr>
                  {showStats[player.player_id] && (
                  <tr>
                    <td colSpan="5">
                      {/* Conditional rendering based on player's position abbreviation */}
                      {player.position_name === "QB" && (
                        <>
                          <td>Passing Yards</td>
                          <td>Passing Touchdowns</td>
                          <td>Interceptions</td>
                          <td>Pass Attempts</td>
                          <td>Pass Completions</td>
                          <tr>
                            <td>{player.Pass_Yds}</td>
                            <td>{player.Pass_TD}</td>
                            <td>{player.Pass_Int}</td>
                            <td>{player.Pass_Att}</td>
                            <td>{player.Pass_Cmp}</td>
                          </tr>
                        </>
                      )}
                      {player.position_name === "RB" && (
                        <>
                          <td>Rushing Yards</td>
                          <td>Rushing Attempts</td>
                          <td>Rushing Touchdowns</td>
                          <td>Receptions</td>
                          <td>Receiving Yards</td>
                          <tr>
                            <td>{player.Rush_Yds}</td>
                            <td>{player.Rush_Att}</td>
                            <td>{player.Rush_TD}</td>
                            <td>{player.Rec}</td>
                            <td>{player.Rec_Yds}</td>
                          </tr>
                        </>
                      )}
                      {player.position_name === "WR" && (
                        <>
                          <td>Receiving Yards</td>
                          <td>Receptions</td>
                          <td>Receiving Touchdowns</td>
                          <td>Targets</td>
                          <td>Yards After Catch</td>
                          <tr>
                            <td>{player.Rec_Yds}</td>
                            <td>{player.Rec}</td>
                            <td>{player.Rec_TD}</td>
                            <td>{player.Rec_Tar}</td>
                            <td>{player.Rec_YAC}</td>
                          </tr>
                        </>
                      )}
                      {player.position_name === "TE" && (
                        <>
                          <td>Receiving Yards</td>
                          <td>Receptions</td>
                          <td>Receiving Touchdowns</td>
                          <td>Targets</td>
                          <td>Lost Yards</td>
                          <tr>
                            <td>{player.Rec_Yds}</td>
                            <td>{player.Rec}</td>
                            <td>{player.Rec_TD}</td>
                            <td>{player.Rec_Tar}</td>
                            <td>{player.Loss}</td>
                          </tr>
                        </>
                      )}
                      {/* Default case for positions not specified */}
                      {!(["QB", "RB", "WR", "TE"].includes(player.position_name)) && (
                        <>
                          <tr>
                            <td colSpan="5">No Stats Available</td>
                          </tr>
                        </>
                      )}
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
