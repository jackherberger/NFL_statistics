DROP database NFL;
CREATE database NFL;

USE NFL;

-- Create Conference table
CREATE TABLE Conference (
    conference_id INT PRIMARY KEY,
    conference_name VARCHAR(255) NOT NULL
);

-- Create Division table
CREATE TABLE Division (
    division_id INT PRIMARY KEY,
    division_name VARCHAR(255) NOT NULL,
    conference_id INT,
    FOREIGN KEY (conference_id) REFERENCES Conference(conference_id)
);
-- Create Team table
CREATE TABLE Team (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    wins INT,
    losses INT,
    ties INT,
    standing INT,
    division_id INT,
    coach_id INT,
    FOREIGN KEY (division_id) REFERENCES Division(division_id)
    -- coach_id foreign key will be added after the Coach table is created
);

-- Create Position table
CREATE TABLE Player_Position (
    position_id INT PRIMARY KEY,
    position_name VARCHAR(2) NOT NULL,
    position_type VARCHAR(255) NOT NULL
);


-- Create Coach table
CREATE TABLE Coach (
    coach_id INT PRIMARY KEY,
    coach_fname VARCHAR(255) NOT NULL,
    coach_lname VARCHAR(255) NOT NULL,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);

-- Now we can add the foreign key for coach_id in the Team table
ALTER TABLE Team
ADD FOREIGN KEY (coach_id) REFERENCES Coach(coach_id);

-- Create Player table
CREATE TABLE Player (
    player_id INT PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    height INT,
    weight INT,
    draft_year INT,
    age INT,
    college VARCHAR(255),
    team_id INT,
    position_id INT,
    FOREIGN KEY (team_id) REFERENCES Team(team_id),
    FOREIGN KEY (position_id) REFERENCES Player_Position(position_id)
);

-- Create Game table
CREATE TABLE Game (
    game_id INT PRIMARY KEY,
    week INT NOT NULL,
    Field VARCHAR(255) NOT NULL,
    time TIME NOT NULL,
    date DATE NOT NULL,
    home_team_score INT,
    away_team_score INT,
    result VARCHAR(50),
    home_team_id INT,
    away_team_id INT,
    FOREIGN KEY (home_team_id) REFERENCES Team(team_id),
    FOREIGN KEY (away_team_id) REFERENCES Team(team_id)
);

-- Create Player_Game_Statistics table
CREATE TABLE Player_Game_Statistics (
	stats_id INT,
    player_id INT,
    game_id INT,
    rushing_yds INT,
    passing_yds INT,
    receiving_yds INT,
    interceptions INT,
    PRIMARY KEY (stats_id),
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
    -- FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- Populate conference table
INSERT INTO Conference (conference_id, conference_name)
VALUES
(1, 'National Football Conference'),
(2, 'American Football Conference');

-- NFC Divisions
INSERT INTO Division (division_id, division_name, conference_id)
VALUES
(1, 'NFC East', 1),
(2, 'NFC North', 1),
(3, 'NFC South', 1),
(4, 'NFC West', 1);

-- AFC Divisions
INSERT INTO Division (division_id, division_name, conference_id)
VALUES
(5, 'AFC East', 2),
(6, 'AFC North', 2),
(7, 'AFC South', 2),
(8, 'AFC West', 2);

-- Insert NFC East teams
INSERT INTO Team (team_id, team_name, city, state, wins, losses, ties, standing, division_id, coach_id)
VALUES
(1, 'Eagles', 'Philadelphia', 'PA', 11, 6, 0, 2, 1, NULL),
(2, 'Cowboys', 'Dallas', 'TX', 12, 5, 0, 2, 1, NULL),
(3, 'Giants', 'New York', 'NY', 6, 11, 1, 3, 1, NULL),
(4, 'Commanders', 'Washington', 'DC', 4, 13, 0, 4, 1, NULL);

-- Insert NFC North teams
INSERT INTO Team (team_id, team_name, city, state, wins, losses, ties, standing, division_id, coach_id)
VALUES
(5, 'Vikings', 'Minnesota', 'MN', 7, 10, 0, 4, 2, NULL),
(6, 'Lions', 'Detroit', 'MI', 12, 5, 0, 1, 2, NULL),
(7, 'Packers', 'Green Bay', 'WI', 9, 8, 0, 2, 2, NULL),
(8, 'Bears', 'Chicago', 'IL', 7, 10, 0, 4, 2, NULL);

-- Insert NFC South teams
INSERT INTO Team (team_id, team_name, city, state, wins, losses, ties, standing, division_id, coach_id)
VALUES
(9, 'Buccaneers', 'Tampa Bay', 'FL', 9, 8, 0, 1, 3, NULL),
(10, 'Saints', 'New Orleans', 'LA', 9, 8, 0, 1, 3, NULL),
(11, 'Falcons', 'Atlanta', 'GA', 7, 10, 0, 3, 3, NULL),
(12, 'Panthers', 'Carolina', 'NC', 2, 15, 0, 4, 3, NULL);

-- Insert NFC West teams
INSERT INTO Team (team_id, team_name, city, state, wins, losses, ties, standing, division_id, coach_id)
VALUES
(13, '49ers', 'San Francisco', 'CA', 12, 5, 0, 1, 4, NULL),
(14, 'Seahawks', 'Seattle', 'WA', 9, 8, 0, 3, 4, NULL),
(15, 'Cardinals', 'Phoenix', 'AZ', 4, 13, 0, 4, 4, NULL),
(16, 'Rams', 'Los Angeles', 'CA', 10, 7, 0, 2, 4, NULL);

-- Insert AFC East teams
INSERT INTO Team (team_id, team_name, city, state, wins, losses, ties, standing, division_id, coach_id)
VALUES
(17, 'Bills', 'Buffalo', 'NY', 11, 6, 0, 1, 5, NULL),
(18, 'Dolphins', 'Miami', 'FL', 11, 6, 0, 1, 5, NULL),
(19, 'Patriots', 'New England', 'MA', 4, 13, 0, 4, 5, NULL),
(20, 'Jets', 'New York', 'NY', 7, 10, 0, 3, 5, NULL);

-- Insert AFC North teams
INSERT INTO Team (team_id, team_name, city, state, wins, losses, ties, standing, division_id, coach_id)
VALUES
(21, 'Bengals', 'Cincinnati', 'OH', 9, 8, 0, 4, 6, NULL),
(22, 'Ravens', 'Baltimore', 'MD', 13, 4, 0, 1, 6, NULL),
(23, 'Steelers', 'Pittsburgh', 'PA', 10, 7, 0, 3, 6, NULL),
(24, 'Browns', 'Cleveland', 'OH', 11, 6, 0, 2, 6, NULL);

-- Insert AFC South teams
INSERT INTO Team (team_id, team_name, city, state, wins, losses, ties, standing, division_id, coach_id)
VALUES
(25, 'Jaguars', 'Jacksonville', 'FL', 9, 8, 0, 3, 7, NULL),
(26, 'Titans', 'Tennessee', 'TN', 6, 11, 0, 4, 7, NULL),
(27, 'Colts', 'Indianapolis', 'IN', 9, 8, 0, 3, 7, NULL),
(28, 'Texans', 'Houston', 'TX', 10, 7, 0, 1, 7, NULL);

-- Insert AFC West teams
INSERT INTO Team (team_id, team_name, city, state, wins, losses, ties, standing, division_id, coach_id)
VALUES
(29, 'Chiefs', 'Kansas City', 'MO', 11, 6, 0, 1, 8, NULL),
(30, 'Chargers', 'Los Angeles', 'CA', 5, 12, 0, 4, 8, NULL),
(31, 'Broncos', 'Denver', 'CO', 8, 9, 0, 3, 8, NULL),
(32, 'Raiders', 'Las Vegas', 'NV', 8, 9, 0, 3, 8, NULL);

-- Insert positions
INSERT INTO Player_Position (position_id, position_name, position_type)
VALUES
(1, 'QB', 'Offensive'),
(2, 'RB', 'Offensive'),
(3, 'WR', 'Offensive'),
(4, 'TE', 'Offensive'),
(5, 'OT', 'Offensive'),
(6, 'OG', 'Offensive'),
(7, 'C', 'Offensive'),
(8, 'DT', 'Defensive'),
(9, 'DE', 'Defensive'),
(10, 'LB', 'Defensive'),
(11, 'CB', 'Defensive'),
(12, 'S', 'Defensive'),
(13, 'K', 'Special Teams'),
(14, 'P', 'Special Teams'),
(15, 'LS', 'Special Teams'),
(16, 'KR', 'Special Teams'),
(17, 'PR', 'Special Teams');


INSERT INTO Coach (coach_id, coach_fname, coach_lname, team_id)
VALUES
-- AFC Head Coaches
(1, 'John', 'Harbaugh', (SELECT team_id FROM Team WHERE team_name = 'Ravens')),
(2, 'Sean', 'McDermott', (SELECT team_id FROM Team WHERE team_name = 'Bills')),
(3, 'Zac', 'Taylor', (SELECT team_id FROM Team WHERE team_name = 'Bengals')),
(4, 'Kevin', 'Stefanski', (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(5, 'Sean', 'Payton', (SELECT team_id FROM Team WHERE team_name = 'Broncos')),
(6, 'DeMeco', 'Ryans', (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(7, 'Shane', 'Steichen', (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(8, 'Doug', 'Pederson', (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(9, 'Andy', 'Reid', (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(10, 'Josh', 'McDaniels', (SELECT team_id FROM Team WHERE team_name = 'Raiders')),
(11, 'Brandon', 'Staley', (SELECT team_id FROM Team WHERE team_name = 'Chargers')),
(12, 'Mike', 'McDaniel', (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(13, 'Bill', 'Belichick', (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(14, 'Robert', 'Saleh', (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(15, 'Mike', 'Tomlin', (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(16, 'Mike', 'Vrabel', (SELECT team_id FROM Team WHERE team_name = 'Titans')),

-- NFC Head Coaches
(17, 'Jonathan', 'Gannon', (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(18, 'Arthur', 'Smith', (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(19, 'Frank', 'Reich', (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(20, 'Matt', 'Eberflus', (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(21, 'Mike', 'McCarthy', (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(22, 'Dan', 'Campbell', (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(23, 'Matt', 'LaFleur', (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(24, 'Sean', 'McVay', (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(25, 'Kevin', 'O''Connell', (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(26, 'Dennis', 'Allen', (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(27, 'Brian', 'Daboll', (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(28, 'Nick', 'Sirianni', (SELECT team_id FROM Team WHERE team_name = 'Eagles')),
(29, 'Kyle', 'Shanahan', (SELECT team_id FROM Team WHERE team_name = '49ers')),
(30, 'Pete', 'Carroll', (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(31, 'Todd', 'Bowles', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(32, 'Ron', 'Rivera', (SELECT team_id FROM Team WHERE team_name = 'Commanders'));

-- Turn off safemode 
SET SQL_SAFE_UPDATES = 0;

-- Add coach_id into Team table
UPDATE Team t
JOIN Coach c ON t.team_id = c.team_id
SET t.coach_id = c.coach_id;

-- Insert game data
-- Week 1
INSERT INTO Game (game_id, week, Field, time, date, home_team_score, away_team_score, result, home_team_id, away_team_id)
VALUES
(1, 1, 'GEHA Field at Arrowhead Stadium', '00:00:00', '2023-09-07', 20, 21, 'L', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(2, 1, 'U.S. Bank Stadium', '00:00:00', '2023-09-10', 17, 20, 'L', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(3, 1, 'Acrisure Stadium', '00:00:00', '2023-09-10', 7, 30, 'L', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = '49ers')),
(4, 1, 'FedExField', '00:00:00', '2023-09-10', 20, 16, 'W', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(5, 1, 'Lucas Oil Stadium', '00:00:00', '2023-09-10', 21, 31, 'L', (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(6, 1, 'M&T Bank Stadium', '00:00:00', '2023-09-10', 25, 9, 'W', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(7, 1, 'Mercedes-Benz Stadium', '00:00:00', '2023-09-10', 24, 10, 'W', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(8, 1, 'Cleveland Browns Stadium', '00:00:00', '2023-09-10', 24, 3, 'W', (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = 'Bengals')),
(9, 1, 'Caesars Superdome', '00:00:00', '2023-09-10', 16, 15, 'W', (SELECT team_id FROM Team WHERE team_name = 'Saints'), (SELECT team_id FROM Team WHERE team_name = 'Titans')),
(10, 1, 'Soldier Field', '00:00:00', '2023-09-10', 20, 38, 'L', (SELECT team_id FROM Team WHERE team_name = 'Bears'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(11, 1, 'Lumen Field', '00:00:00', '2023-09-10', 13, 30, 'L', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(12, 1, 'SoFi Stadium', '00:00:00', '2023-09-10', 34, 36, 'L', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(13, 1, 'Empower Field at Mile High', '00:00:00', '2023-09-10', 16, 17, 'L', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Raiders')),
(14, 1, 'Gillette Stadium', '00:00:00', '2023-09-10', 20, 25, 'L', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Eagles')),
(15, 1, 'MetLife Stadium', '00:00:00', '2023-09-10', 0, 40, 'L', (SELECT team_id FROM Team WHERE team_name = 'Giants'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(16, 1, 'MetLife Stadium', '00:00:00', '2023-09-11', 22, 16, 'W', (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Bills'));

-- Altering table, no data for time, result doesn't make sense here
ALTER TABLE Game
DROP COLUMN result,
DROP COLUMN time;

-- Week 2
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(17, 2, 'Lincoln Financial Field', '2023-09-14', 34, 28, (SELECT team_id FROM Team WHERE team_name = 'Eagles'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(18, 2, 'Ford Field', '2023-09-17', 31, 37, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(19, 2, 'Raymond James Stadium', '2023-09-17', 27, 17, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(20, 2, 'Paycor Stadium', '2023-09-17', 24, 27, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Ravens')),
(21, 2, 'Mercedes-Benz Stadium', '2023-09-17', 25, 24, (SELECT team_id FROM Team WHERE team_name = 'Falcons'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(22, 2, 'NRG Stadium', '2023-09-17', 20, 31, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(23, 2, 'EverBank Stadium', '2023-09-17', 9, 17, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(24, 2, 'Highmark Stadium', '2023-09-17', 38, 10, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Raiders')),
(25, 2, 'Nissan Stadium', '2023-09-17', 27, 24, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Chargers')),
(26, 2, 'State Farm Stadium', '2023-09-17', 28, 31, (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(27, 2, 'SoFi Stadium', '2023-09-17', 23, 30, (SELECT team_id FROM Team WHERE team_name = 'Rams'), (SELECT team_id FROM Team WHERE team_name = '49ers')),
(28, 2, 'Empower Field at Mile High', '2023-09-17', 33, 35, (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(29, 2, 'AT&T Stadium', '2023-09-17', 30, 10, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(30, 2, 'Gillette Stadium', '2023-09-17', 17, 24, (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(31, 2, 'Bank of America Stadium', '2023-09-18', 17, 20, (SELECT team_id FROM Team WHERE team_name = 'Panthers'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(32, 2, 'Acrisure Stadium', '2023-09-18', 26, 22, (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = 'Browns'));

-- Week 3
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(33, 3, 'Levi''s Stadium', '2023-09-21', 30, 12, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(34, 3, 'M&T Bank Stadium', '2023-09-24', 19, 22, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(35, 3, 'U.S. Bank Stadium', '2023-09-24', 24, 28, (SELECT team_id FROM Team WHERE team_name = 'Vikings'), (SELECT team_id FROM Team WHERE team_name = 'Chargers')),
(36, 3, 'Hard Rock Stadium', '2023-09-24', 70, 20, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Broncos')),
(37, 3, 'Ford Field', '2023-09-24', 20, 6, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(38, 3, 'Lambeau Field', '2023-09-24', 18, 17, (SELECT team_id FROM Team WHERE team_name = 'Packers'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(39, 3, 'FedExField', '2023-09-24', 3, 37, (SELECT team_id FROM Team WHERE team_name = 'Commanders'), (SELECT team_id FROM Team WHERE team_name = 'Bills')),
(40, 3, 'EverBank Stadium', '2023-09-24', 17, 37, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(41, 3, 'Cleveland Browns Stadium', '2023-09-24', 27, 3, (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = 'Titans')),
(42, 3, 'MetLife Stadium', '2023-09-24', 10, 15, (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(43, 3, 'Lumen Field', '2023-09-24', 37, 27, (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(44, 3, 'GEHA Field at Arrowhead Stadium', '2023-09-24', 41, 10, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(45, 3, 'State Farm Stadium', '2023-09-24', 28, 16, (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(46, 3, 'Allegiant Stadium', '2023-09-24', 18, 23, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(47, 3, 'Raymond James Stadium', '2023-09-25', 11, 25, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Eagles')),
(48, 3, 'Paycor Stadium', '2023-09-25', 19, 16, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Rams'));

-- Week 4
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(49, 4, 'Lambeau Field', '2023-09-28', 20, 34, (SELECT team_id FROM Team WHERE team_name = 'Packers'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(50, 4, 'Wembley Stadium', '2023-10-01', 23, 7, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(51, 4, 'Soldier Field', '2023-10-01', 28, 31, (SELECT team_id FROM Team WHERE team_name = 'Bears'), (SELECT team_id FROM Team WHERE team_name = 'Broncos')),
(52, 4, 'NRG Stadium', '2023-10-01', 30, 6, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(53, 4, 'Cleveland Browns Stadium', '2023-10-01', 3, 28, (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = 'Ravens')),
(54, 4, 'Lincoln Financial Field', '2023-10-01', 34, 31, (SELECT team_id FROM Team WHERE team_name = 'Eagles'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(55, 4, 'Bank of America Stadium', '2023-10-01', 13, 21, (SELECT team_id FROM Team WHERE team_name = 'Panthers'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(56, 4, 'Caesars Superdome', '2023-10-01', 9, 26, (SELECT team_id FROM Team WHERE team_name = 'Saints'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(57, 4, 'Lucas Oil Stadium', '2023-10-01', 23, 29, (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(58, 4, 'Highmark Stadium', '2023-10-01', 48, 20, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(59, 4, 'Nissan Stadium', '2023-10-01', 27, 3, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Bengals')),
(60, 4, 'SoFi Stadium', '2023-10-01', 24, 17, (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Raiders')),
(61, 4, 'AT&T Stadium', '2023-10-01', 38, 3, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(62, 4, 'Levi''s Stadium', '2023-10-01', 35, 16, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(63, 4, 'MetLife Stadium', '2023-10-01', 20, 23, (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(64, 4, 'MetLife Stadium', '2023-10-02', 3, 24, (SELECT team_id FROM Team WHERE team_name = 'Giants'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks'));

-- Week 5 
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(65, 5, 'FedExField', '2023-10-05', 20, 40, (SELECT team_id FROM Team WHERE team_name = 'Commanders'), (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(66, 5, 'Tottenham Hotspur Stadium', '2023-10-08', 20, 25, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(67, 5, 'Lucas Oil Stadium', '2023-10-08', 23, 16, (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Titans')),
(68, 5, 'Mercedes-Benz Stadium', '2023-10-08', 21, 19, (SELECT team_id FROM Team WHERE team_name = 'Falcons'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(69, 5, 'Acrisure Stadium', '2023-10-08', 17, 10, (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = 'Ravens')),
(70, 5, 'Hard Rock Stadium', '2023-10-08', 31, 16, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(71, 5, 'Ford Field', '2023-10-08', 42, 24, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(72, 5, 'Gillette Stadium', '2023-10-08', 0, 34, (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(73, 5, 'SoFi Stadium', '2023-10-08', 14, 23, (SELECT team_id FROM Team WHERE team_name = 'Rams'), (SELECT team_id FROM Team WHERE team_name = 'Eagles')),
(74, 5, 'State Farm Stadium', '2023-10-08', 20, 34, (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), (SELECT team_id FROM Team WHERE team_name = 'Bengals')),
(75, 5, 'U.S. Bank Stadium', '2023-10-08', 20, 27, (SELECT team_id FROM Team WHERE team_name = 'Vikings'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(76, 5, 'Empower Field at Mile High', '2023-10-08', 21, 31, (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(77, 5, 'Levi''s Stadium', '2023-10-08', 42, 10, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(78, 5, 'Allegiant Stadium', '2023-10-09', 17, 13, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Packers'));

-- Week 6 
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(79, 6, 'GEHA Field at Arrowhead Stadium', '2023-10-12', 19, 8, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Broncos')),
(80, 6, 'Tottenham Hotspur Stadium', '2023-10-15', 16, 24, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Ravens')),
(81, 6, 'Paycor Stadium', '2023-10-15', 17, 13, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(82, 6, 'NRG Stadium', '2023-10-15', 20, 13, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(83, 6, 'EverBank Stadium', '2023-10-15', 37, 20, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(84, 6, 'Cleveland Browns Stadium', '2023-10-15', 19, 17, (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = '49ers')),
(85, 6, 'Soldier Field', '2023-10-15', 13, 19, (SELECT team_id FROM Team WHERE team_name = 'Bears'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(86, 6, 'Mercedes-Benz Stadium', '2023-10-15', 16, 24, (SELECT team_id FROM Team WHERE team_name = 'Falcons'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(87, 6, 'Hard Rock Stadium', '2023-10-15', 42, 21, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(88, 6, 'Allegiant Stadium', '2023-10-15', 21, 17, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(89, 6, 'SoFi Stadium', '2023-10-15', 26, 9, (SELECT team_id FROM Team WHERE team_name = 'Rams'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(90, 6, 'Raymond James Stadium', '2023-10-15', 6, 20, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(91, 6, 'MetLife Stadium', '2023-10-15', 20, 14, (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Eagles')),
(92, 6, 'Highmark Stadium', '2023-10-15', 14, 9, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(93, 6, 'SoFi Stadium', '2023-10-16', 17, 20, (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys'));

-- Week 7 
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(94, 7, 'Caesars Superdome', '2023-10-19', 24, 31, (SELECT team_id FROM Team WHERE team_name = 'Saints'), (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(95, 7, 'Gillette Stadium', '2023-10-22', 29, 25, (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Bills')),
(96, 7, 'Lucas Oil Stadium', '2023-10-22', 38, 39, (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(97, 7, 'Raymond James Stadium', '2023-10-22', 13, 16, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(98, 7, 'M&T Bank Stadium', '2023-10-22', 38, 6, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(99, 7, 'Soldier Field', '2023-10-22', 30, 12, (SELECT team_id FROM Team WHERE team_name = 'Bears'), (SELECT team_id FROM Team WHERE team_name = 'Raiders')),
(100, 7, 'MetLife Stadium', '2023-10-22', 14, 7, (SELECT team_id FROM Team WHERE team_name = 'Giants'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(101, 7, 'Lumen Field', '2023-10-22', 20, 10, (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(102, 7, 'SoFi Stadium', '2023-10-22', 17, 24, (SELECT team_id FROM Team WHERE team_name = 'Rams'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(103, 7, 'Empower Field at Mile High', '2023-10-22', 19, 17, (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(104, 7, 'GEHA Field at Arrowhead Stadium', '2023-10-22', 31, 17, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Chargers')),
(105, 7, 'Lincoln Financial Field', '2023-10-22', 31, 17, (SELECT team_id FROM Team WHERE team_name = 'Eagles'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(106, 7, 'U.S. Bank Stadium', '2023-10-23', 22, 17, (SELECT team_id FROM Team WHERE team_name = 'Vikings'), (SELECT team_id FROM Team WHERE team_name = '49ers'));

-- Week 8
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(107, 8, 'Highmark Stadium', '2023-10-26', 24, 18, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(108, 8, 'Lucas Oil Stadium', '2023-10-29', 27, 38, (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(109, 8, 'Acrisure Stadium', '2023-10-29', 10, 20, (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(110, 8, 'Bank of America Stadium', '2023-10-29', 15, 13, (SELECT team_id FROM Team WHERE team_name = 'Panthers'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(111, 8, 'MetLife Stadium', '2023-10-29', 10, 13, (SELECT team_id FROM Team WHERE team_name = 'Giants'), (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(112, 8, 'Hard Rock Stadium', '2023-10-29', 31, 17, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(113, 8, 'Lambeau Field', '2023-10-29', 10, 24, (SELECT team_id FROM Team WHERE team_name = 'Packers'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(114, 8, 'Nissan Stadium', '2023-10-29', 28, 23, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(115, 8, 'AT&T Stadium', '2023-10-29', 43, 20, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(116, 8, 'FedExField', '2023-10-29', 31, 38, (SELECT team_id FROM Team WHERE team_name = 'Commanders'), (SELECT team_id FROM Team WHERE team_name = 'Eagles')),
(117, 8, 'Lumen Field', '2023-10-29', 24, 20, (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(118, 8, 'Empower Field at Mile High', '2023-10-29', 24, 9, (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(119, 8, 'State Farm Stadium', '2023-10-29', 24, 31, (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), (SELECT team_id FROM Team WHERE team_name = 'Ravens')),
(120, 8, 'Levi\'s Stadium', '2023-10-29', 17, 31, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Bengals')),
(121, 8, 'SoFi Stadium', '2023-10-29', 30, 13, (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(122, 8, 'Ford Field', '2023-10-30', 26, 14, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Raiders'));

-- Week 9
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(123, 9, 'Acrisure Stadium', '2023-11-02', 20, 16, (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = 'Titans')),
(124, 9, 'Deutsche Bank Park', '2023-11-05', 21, 14, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(125, 9, 'Cleveland Browns Stadium', '2023-11-05', 27, 0, (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(126, 9, 'M&T Bank Stadium', '2023-11-05', 37, 3, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(127, 9, 'Gillette Stadium', '2023-11-05', 17, 20, (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(128, 9, 'Lambeau Field', '2023-11-05', 20, 3, (SELECT team_id FROM Team WHERE team_name = 'Packers'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(129, 9, 'Caesars Superdome', '2023-11-05', 24, 17, (SELECT team_id FROM Team WHERE team_name = 'Saints'), (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(130, 9, 'Mercedes-Benz Stadium', '2023-11-05', 28, 31, (SELECT team_id FROM Team WHERE team_name = 'Falcons'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(131, 9, 'NRG Stadium', '2023-11-05', 39, 37, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(132, 9, 'Bank of America Stadium', '2023-11-05', 13, 27, (SELECT team_id FROM Team WHERE team_name = 'Panthers'), (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(133, 9, 'Allegiant Stadium', '2023-11-05', 30, 6, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(134, 9, 'Lincoln Financial Field', '2023-11-05', 28, 23, (SELECT team_id FROM Team WHERE team_name = 'Eagles'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(135, 9, 'Paycor Stadium', '2023-11-05', 24, 18, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Bills')),
(136, 9, 'MetLife Stadium', '2023-11-06', 6, 27, (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Chargers'));

-- Week 10
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(137, 10, 'Soldier Field', '2023-11-09', 16, 13, (SELECT team_id FROM Team WHERE team_name = 'Bears'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(138, 10, 'Deutsche Bank Park', '2023-11-12', 6, 10, (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(139, 10, 'EverBank Stadium', '2023-11-12', 3, 34, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = '49ers')),
(140, 10, 'Acrisure Stadium', '2023-11-12', 23, 19, (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(141, 10, 'Raymond James Stadium', '2023-11-12', 20, 6, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Titans')),
(142, 10, 'Paycor Stadium', '2023-11-12', 27, 30, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(143, 10, 'U.S. Bank Stadium', '2023-11-12', 27, 19, (SELECT team_id FROM Team WHERE team_name = 'Vikings'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(144, 10, 'M&T Bank Stadium', '2023-11-12', 31, 33, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(145, 10, 'SoFi Stadium', '2023-11-12', 38, 41, (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(146, 10, 'State Farm Stadium', '2023-11-12', 25, 23, (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(147, 10, 'AT&T Stadium', '2023-11-12', 49, 17, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(148, 10, 'Lumen Field', '2023-11-12', 29, 26, (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(149, 10, 'Allegiant Stadium', '2023-11-12', 16, 12, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(150, 10, 'Highmark Stadium', '2023-11-13', 22, 24, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Broncos'));

-- Week 11
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(151, 11, 'M&T Bank Stadium', '2023-11-16', 34, 20, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Bengals')),
(152, 11, 'Hard Rock Stadium', '2023-11-19', 20, 13, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Raiders')),
(153, 11, 'NRG Stadium', '2023-11-19', 21, 16, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(154, 11, 'FedExField', '2023-11-19', 19, 31, (SELECT team_id FROM Team WHERE team_name = 'Commanders'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(155, 11, 'Lambeau Field', '2023-11-19', 23, 20, (SELECT team_id FROM Team WHERE team_name = 'Packers'), (SELECT team_id FROM Team WHERE team_name = 'Chargers')),
(156, 11, 'Cleveland Browns Stadium', '2023-11-19', 13, 10, (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(157, 11, 'EverBank Stadium', '2023-11-19', 34, 14, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = 'Titans')),
(158, 11, 'Bank of America Stadium', '2023-11-19', 10, 33, (SELECT team_id FROM Team WHERE team_name = 'Panthers'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(159, 11, 'Ford Field', '2023-11-19', 31, 26, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(160, 11, 'Levi\'s Stadium', '2023-11-19', 27, 14, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(161, 11, 'SoFi Stadium', '2023-11-19', 17, 16, (SELECT team_id FROM Team WHERE team_name = 'Rams'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(162, 11, 'Highmark Stadium', '2023-11-19', 32, 6, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(163, 11, 'Empower Field at Mile High', '2023-11-19', 21, 20, (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(164, 11, 'GEHA Field at Arrowhead Stadium', '2023-11-20', 17, 21, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Eagles'));

-- Week 12
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(165, 12, 'Ford Field', '2023-11-23', 22, 29, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(166, 12, 'AT&T Stadium', '2023-11-23', 45, 10, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(167, 12, 'Lumen Field', '2023-11-23', 13, 31, (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), (SELECT team_id FROM Team WHERE team_name = '49ers')),
(168, 12, 'MetLife Stadium', '2023-11-24', 13, 34, (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(169, 12, 'Paycor Stadium', '2023-11-26', 10, 16, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(170, 12, 'Mercedes-Benz Stadium', '2023-11-26', 24, 15, (SELECT team_id FROM Team WHERE team_name = 'Falcons'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(171, 12, 'Nissan Stadium', '2023-11-26', 17, 10, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(172, 12, 'NRG Stadium', '2023-11-26', 21, 24, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(173, 12, 'Lucas Oil Stadium', '2023-11-26', 27, 20, (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(174, 12, 'MetLife Stadium', '2023-11-26', 10, 7, (SELECT team_id FROM Team WHERE team_name = 'Giants'), (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(175, 12, 'State Farm Stadium', '2023-11-26', 14, 37, (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(176, 12, 'Empower Field at Mile High', '2023-11-26', 29, 12, (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(177, 12, 'Allegiant Stadium', '2023-11-26', 17, 31, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(178, 12, 'Lincoln Financial Field', '2023-11-26', 37, 34, (SELECT team_id FROM Team WHERE team_name = 'Eagles'), (SELECT team_id FROM Team WHERE team_name = 'Bills')),
(179, 12, 'SoFi Stadium', '2023-11-27', 10, 20, (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Ravens')),
(180, 12, 'U.S. Bank Stadium', '2023-11-27', 10, 12, (SELECT team_id FROM Team WHERE team_name = 'Vikings'), (SELECT team_id FROM Team WHERE team_name = 'Bears'));

-- Week 13
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(181, 13, 'AT&T Stadium', '2023-11-30', 41, 35, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(182, 13, 'FedExField', '2023-12-03', 15, 45, (SELECT team_id FROM Team WHERE team_name = 'Commanders'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(183, 13, 'Gillette Stadium', '2023-12-03', 0, 6, (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Chargers')),
(184, 13, 'MetLife Stadium', '2023-12-03', 8, 13, (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(185, 13, 'Caesars Superdome', '2023-12-03', 28, 33, (SELECT team_id FROM Team WHERE team_name = 'Saints'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(186, 13, 'Acrisure Stadium', '2023-12-03', 10, 24, (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(187, 13, 'Nissan Stadium', '2023-12-03', 28, 31, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(188, 13, 'NRG Stadium', '2023-12-03', 22, 17, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Broncos')),
(189, 13, 'Raymond James Stadium', '2023-12-03', 21, 18, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(190, 13, 'Lincoln Financial Field', '2023-12-03', 19, 42, (SELECT team_id FROM Team WHERE team_name = 'Eagles'), (SELECT team_id FROM Team WHERE team_name = '49ers')),
(191, 13, 'SoFi Stadium', '2023-12-03', 36, 19, (SELECT team_id FROM Team WHERE team_name = 'Rams'), (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(192, 13, 'Lambeau Field', '2023-12-03', 27, 19, (SELECT team_id FROM Team WHERE team_name = 'Packers'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(193, 13, 'EverBank Stadium', '2023-12-04', 31, 34, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = 'Bengals'));

-- Week 14
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(194, 14, 'Acrisure Stadium', '2023-12-07', 18, 21, (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(195, 14, 'MetLife Stadium', '2023-12-10', 30, 6, (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(196, 14, 'M&T Bank Stadium', '2023-12-10', 37, 31, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(197, 14, 'Paycor Stadium', '2023-12-10', 34, 14, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(198, 14, 'Cleveland Browns Stadium', '2023-12-10', 31, 27, (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(199, 14, 'Soldier Field', '2023-12-10', 28, 13, (SELECT team_id FROM Team WHERE team_name = 'Bears'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(200, 14, 'Caesars Superdome', '2023-12-10', 28, 6, (SELECT team_id FROM Team WHERE team_name = 'Saints'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(201, 14, 'Mercedes-Benz Stadium', '2023-12-10', 25, 29, (SELECT team_id FROM Team WHERE team_name = 'Falcons'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(202, 14, 'Allegiant Stadium', '2023-12-10', 0, 3, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(203, 14, 'Levi\'s Stadium', '2023-12-10', 28, 16, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(204, 14, 'SoFi Stadium', '2023-12-10', 7, 24, (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Broncos')),
(205, 14, 'GEHA Field at Arrowhead Stadium', '2023-12-10', 17, 20, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Bills')),
(206, 14, 'AT&T Stadium', '2023-12-10', 33, 13, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Eagles')),
(207, 14, 'MetLife Stadium', '2023-12-11', 24, 22, (SELECT team_id FROM Team WHERE team_name = 'Giants'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(208, 14, 'Hard Rock Stadium', '2023-12-11', 27, 28, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Titans'));

-- Week 15
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(209, 15, 'Allegiant Stadium', '2023-12-14', 63, 21, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Chargers')),
(210, 15, 'Paycor Stadium', '2023-12-16', 27, 24, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(211, 15, 'Lucas Oil Stadium', '2023-12-16', 30, 13, (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(212, 15, 'Ford Field', '2023-12-16', 42, 17, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Broncos')),
(213, 15, 'Caesars Superdome', '2023-12-17', 24, 6, (SELECT team_id FROM Team WHERE team_name = 'Saints'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(214, 15, 'Lambeau Field', '2023-12-17', 20, 34, (SELECT team_id FROM Team WHERE team_name = 'Packers'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(215, 15, 'Gillette Stadium', '2023-12-17', 17, 27, (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(216, 15, 'Nissan Stadium', '2023-12-17', 16, 19, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(217, 15, 'Hard Rock Stadium', '2023-12-17', 30, 0, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(218, 15, 'Bank of America Stadium', '2023-12-17', 9, 7, (SELECT team_id FROM Team WHERE team_name = 'Panthers'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(219, 15, 'Cleveland Browns Stadium', '2023-12-17', 20, 17, (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(220, 15, 'SoFi Stadium', '2023-12-17', 28, 20, (SELECT team_id FROM Team WHERE team_name = 'Rams'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(221, 15, 'State Farm Stadium', '2023-12-17', 29, 45, (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), (SELECT team_id FROM Team WHERE team_name = '49ers')),
(222, 15, 'Highmark Stadium', '2023-12-17', 31, 10, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(223, 15, 'EverBank Stadium', '2023-12-17', 7, 23, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = 'Ravens')),
(224, 15, 'Lumen Field', '2023-12-18', 20, 17, (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), (SELECT team_id FROM Team WHERE team_name = 'Eagles'));

-- Week 16
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(225, 16, 'SoFi Stadium', '2023-12-21', 30, 22, (SELECT team_id FROM Team WHERE team_name = 'Rams'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(226, 16, 'Acrisure Stadium', '2023-12-23', 34, 11, (SELECT team_id FROM Team WHERE team_name = 'Steelers'), (SELECT team_id FROM Team WHERE team_name = 'Bengals')),
(227, 16, 'SoFi Stadium', '2023-12-23', 22, 24, (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Bills')),
(228, 16, 'NRG Stadium', '2023-12-24', 22, 36, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(229, 16, 'Nissan Stadium', '2023-12-24', 17, 20, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(230, 16, 'Bank of America Stadium', '2023-12-24', 30, 33, (SELECT team_id FROM Team WHERE team_name = 'Panthers'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(231, 16, 'MetLife Stadium', '2023-12-24', 30, 28, (SELECT team_id FROM Team WHERE team_name = 'Jets'), (SELECT team_id FROM Team WHERE team_name = 'Commanders')),
(232, 16, 'U.S. Bank Stadium', '2023-12-24', 24, 30, (SELECT team_id FROM Team WHERE team_name = 'Vikings'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(233, 16, 'Mercedes-Benz Stadium', '2023-12-24', 29, 10, (SELECT team_id FROM Team WHERE team_name = 'Falcons'), (SELECT team_id FROM Team WHERE team_name = 'Colts')),
(234, 16, 'Raymond James Stadium', '2023-12-24', 30, 12, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(235, 16, 'Hard Rock Stadium', '2023-12-24', 22, 20, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(236, 16, 'Soldier Field', '2023-12-24', 27, 16, (SELECT team_id FROM Team WHERE team_name = 'Bears'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(237, 16, 'Empower Field at Mile High', '2023-12-24', 23, 26, (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(238, 16, 'GEHA Field at Arrowhead Stadium', '2023-12-25', 14, 20, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Raiders')),
(239, 16, 'Lincoln Financial Field', '2023-12-25', 33, 25, (SELECT team_id FROM Team WHERE team_name = 'Eagles'), (SELECT team_id FROM Team WHERE team_name = 'Giants')),
(240, 16, 'Levi\'s Stadium', '2023-12-25', 19, 33, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Ravens'));

-- Week 17
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(241, 17, 'Cleveland Browns Stadium', '2023-12-28', 37, 20, (SELECT team_id FROM Team WHERE team_name = 'Browns'), (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(242, 17, 'AT&T Stadium', '2023-12-30', 20, 19, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Lions')),
(243, 17, 'M&T Bank Stadium', '2023-12-31', 56, 19, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(244, 17, 'FedExField', '2023-12-31', 10, 27, (SELECT team_id FROM Team WHERE team_name = 'Commanders'), (SELECT team_id FROM Team WHERE team_name = '49ers')),
(245, 17, 'Highmark Stadium', '2023-12-31', 27, 21, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Patriots')),
(246, 17, 'Lincoln Financial Field', '2023-12-31', 31, 35, (SELECT team_id FROM Team WHERE team_name = 'Eagles'), (SELECT team_id FROM Team WHERE team_name = 'Cardinals')),
(247, 17, 'NRG Stadium', '2023-12-31', 26, 3, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Titans')),
(248, 17, 'EverBank Stadium', '2023-12-31', 26, 0, (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), (SELECT team_id FROM Team WHERE team_name = 'Panthers')),
(249, 17, 'Soldier Field', '2023-12-31', 37, 17, (SELECT team_id FROM Team WHERE team_name = 'Bears'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(250, 17, 'Raymond James Stadium', '2023-12-31', 13, 23, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Saints')),
(251, 17, 'MetLife Stadium', '2023-12-31', 25, 26, (SELECT team_id FROM Team WHERE team_name = 'Giants'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(252, 17, 'Lucas Oil Stadium', '2023-12-31', 23, 20, (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Raiders')),
(253, 17, 'Lumen Field', '2023-12-31', 23, 30, (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(254, 17, 'Empower Field at Mile High', '2023-12-31', 16, 9, (SELECT team_id FROM Team WHERE team_name = 'Broncos'), (SELECT team_id FROM Team WHERE team_name = 'Chargers')),
(255, 17, 'GEHA Field at Arrowhead Stadium', '2023-12-31', 25, 17, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Bengals')),
(256, 17, 'U.S. Bank Stadium', '2023-12-31', 10, 33, (SELECT team_id FROM Team WHERE team_name = 'Vikings'), (SELECT team_id FROM Team WHERE team_name = 'Packers'));

-- Week 18
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(257, 18, 'M&T Bank Stadium', '2023-01-06', 10, 17, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(258, 18, 'Lucas Oil Stadium', '2023-01-06', 19, 23, (SELECT team_id FROM Team WHERE team_name = 'Colts'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(259, 18, 'Gillette Stadium', '2023-01-07', 3, 17, (SELECT team_id FROM Team WHERE team_name = 'Patriots'), (SELECT team_id FROM Team WHERE team_name = 'Jets')),
(260, 18, 'Paycor Stadium', '2023-01-07', 31, 14, (SELECT team_id FROM Team WHERE team_name = 'Bengals'), (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(261, 18, 'Caesars Superdome', '2023-01-07', 48, 17, (SELECT team_id FROM Team WHERE team_name = 'Saints'), (SELECT team_id FROM Team WHERE team_name = 'Falcons')),
(262, 18, 'Bank of America Stadium', '2023-01-07', 0, 9, (SELECT team_id FROM Team WHERE team_name = 'Panthers'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(263, 18, 'Ford Field', '2023-01-07', 30, 20, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Vikings')),
(264, 18, 'Nissan Stadium', '2023-01-07', 28, 20, (SELECT team_id FROM Team WHERE team_name = 'Titans'), (SELECT team_id FROM Team WHERE team_name = 'Jaguars')),
(265, 18, 'FedExField', '2023-01-07', 10, 38, (SELECT team_id FROM Team WHERE team_name = 'Commanders'), (SELECT team_id FROM Team WHERE team_name = 'Cowboys')),
(266, 18, 'SoFi Stadium', '2023-01-07', 12, 13, (SELECT team_id FROM Team WHERE team_name = 'Chargers'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(267, 18, 'Levi\'s Stadium', '2023-01-07', 20, 21, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(268, 18, 'Allegiant Stadium', '2023-01-07', 27, 14, (SELECT team_id FROM Team WHERE team_name = 'Raiders'), (SELECT team_id FROM Team WHERE team_name = 'Broncos')),
(269, 18, 'Lambeau Field', '2023-01-07', 17, 9, (SELECT team_id FROM Team WHERE team_name = 'Packers'), (SELECT team_id FROM Team WHERE team_name = 'Bears')),
(270, 18, 'MetLife Stadium', '2023-01-07', 27, 10, (SELECT team_id FROM Team WHERE team_name = 'Giants'), (SELECT team_id FROM Team WHERE team_name = 'Eagles')),
(271, 18, 'State Farm Stadium', '2023-01-07', 20, 21, (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), (SELECT team_id FROM Team WHERE team_name = 'Seahawks')),
(272, 18, 'Hard Rock Stadium', '2023-01-07', 14, 21, (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), (SELECT team_id FROM Team WHERE team_name = 'Bills'));

-- Week 19
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(273, 19, 'NRG Stadium', '2023-01-13', 45, 14, (SELECT team_id FROM Team WHERE team_name = 'Texans'), (SELECT team_id FROM Team WHERE team_name = 'Browns')),
(274, 19, 'GEHA Field at Arrowhead Stadium', '2023-01-13', 26, 7, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = 'Dolphins')),
(275, 19, 'AT&T Stadium', '2023-01-14', 32, 48, (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(276, 19, 'Ford Field', '2023-01-14', 24, 23, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Rams')),
(277, 19, 'Highmark Stadium', '2023-01-15', 31, 17, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Steelers')),
(278, 19, 'Raymond James Stadium', '2023-01-15', 32, 9, (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), (SELECT team_id FROM Team WHERE team_name = 'Eagles'));

-- Week 20
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(279, 20, 'M&T Bank Stadium', '2023-01-20', 34, 10, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Texans')),
(280, 20, 'Levi\'s Stadium', '2023-01-20', 24, 21, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Packers')),
(281, 20, 'Ford Field', '2023-01-21', 31, 23, (SELECT team_id FROM Team WHERE team_name = 'Lions'), (SELECT team_id FROM Team WHERE team_name = 'Buccaneers')),
(282, 20, 'Highmark Stadium', '2023-01-21', 24, 27, (SELECT team_id FROM Team WHERE team_name = 'Bills'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs'));

-- Week 21
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(283, 21, 'M&T Bank Stadium', '2023-01-28', 10, 17, (SELECT team_id FROM Team WHERE team_name = 'Ravens'), (SELECT team_id FROM Team WHERE team_name = 'Chiefs')),
(284, 21, 'Levi\'s Stadium', '2023-01-28', 34, 31, (SELECT team_id FROM Team WHERE team_name = '49ers'), (SELECT team_id FROM Team WHERE team_name = 'Lions'));

-- Week 22
INSERT INTO Game (game_id, week, Field, date, home_team_score, away_team_score, home_team_id, away_team_id)
VALUES
(285, 22, 'Allegiant Stadium', '2023-02-11', 25, 22, (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), (SELECT team_id FROM Team WHERE team_name = '49ers'));


-- Quaterbacks
-- Insert Player data
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
(1, 'Tua', 'Tagovailoa', 73, 217, 2020, 26, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 1),
(2, 'Jared', 'Goff', 76, 217, 2016, 29, 'Cal', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 1),
(3, 'Dak', 'Prescott', 74, 238, 2016, 30, 'Miss St', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 1),
(4, 'Josh', 'Allen', 77, 237, 2018, 27, 'Wyoming', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 1),
(5, 'Brock', 'Purdy', 73, 220, 2022, 24, 'Iowa State', (SELECT team_id FROM Team WHERE team_name = '49ers'), 1),
(6, 'Patrick', 'Mahomes', 74, 225, 2017, 28, 'Texas Tech', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 1),
(7, 'Jordan', 'Love', 76, 219, 2020, 25, 'Utah State', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 1),
(8, 'C.J.', 'Stroud', 75, 218, 2023, 22, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 1),
(9, 'Baker', 'Mayfield', 73, 215, 2018, 28, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 1),
(10, 'Trevor', 'Lawrence', 78, 220, 2021, 24, 'Clemson', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 1),
(11, 'Matthew', 'Stafford', 75, 220, 2009, 36, 'Georgia', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 1),
(12, 'Sam', 'Howell', 73, 220, 2022, 23, 'North Carolina', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 1),
(13, 'Derek', 'Carr', 75, 215, 2014, 32, 'Fresno State', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 1),
(14, 'Jalen', 'Hurts', 73, 223, 2020, 25, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 1),
(15, 'Lamar', 'Jackson', 74, 212, 2018, 27, 'Louisville', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 1),
(16, 'Geno', 'Smith', 75, 221, 2013, 33, 'West Virginia', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 1),
(17, 'Gardner', 'Minshew', 73, 225, 2019, 27, 'Washington St', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 1),
(18, 'Justin', 'Herbert', 78, 236, 2020, 25, 'Oregon', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 1),
(19, 'Russell', 'Wilson', 71, 215, 2012, 35, 'Wisconsin', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 1),
(20, 'Bryce', 'Young', 70, 194, 2023, 22, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 1),
(21, 'Desmond', 'Ridder', 75, 207, 2022, 24, 'Cincinnati', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 1),
(22, 'Justin', 'Fields', 75, 228, 2021, 25, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 1),
(23, 'Joshua', 'Dobbs', 75, 216, 2017, 29, 'Tennessee', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 1),
(24, 'Joe', 'Burrow', 76, 215, 2020, 27, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 1),
(25, 'Zach', 'Wilson', 74, 214, 2021, 24, 'BYU', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 1),
(26, 'Aidan', 'O\'Connell', 75, 210, 2023, 25, 'Purdue', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 1),
(27, 'Mac', 'Jones', 75, 220, 2021, 25, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 1),
(28, 'Kenny', 'Pickett', 75, 220, 2022, 25, 'Pitt', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 1),
(29, 'Will', 'Levis', 76, 229, 2023, 24, 'Kentucky', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 1),
(30, 'Tyrod', 'Taylor', 73, 217, 2011, 34, 'VT', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 1),
(31, 'Kyler', 'Murray', 70, 207, 2019, 26, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 1);

-- Running backs
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
(33, 'Ezekiel', 'Elliott', 72, 228, 2016, 26, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 2),
(34, 'Saquon', 'Barkley', 72, 233, 2018, 25, 'Penn State', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 2),
(35, 'Antonio', 'Gibson', 72, 228, 2020, 24, 'Memphis', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 2),
(36, 'Miles', 'Sanders', 71, 211, 2019, 24, 'Penn State', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 2),
(37, 'Dalvin', 'Cook', 70, 210, 2017, 26, 'Florida State', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 2),
(38, 'DAndre', 'Swift', 70, 215, 2020, 23, 'Georgia', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 2),
(39, 'David', 'Montgomery', 71, 222, 2019, 24, 'Iowa State', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 2),
(40, 'Aaron', 'Jones', 69, 208, 2017, 27, 'UTEP', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 2),
(41, 'Alvin', 'Kamara', 70, 215, 2017, 26, 'Tennessee', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 2),
(42, 'Christian', 'McCaffrey', 71, 205, 2017, 26, 'Stanford', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 2),
(43, 'Mike', 'Davis', 70, 221, 2015, 29, 'South Carolina', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 2),
(44, 'Leonard', 'Fournette', 73, 228, 2017, 27, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 2),
(45, 'Raheem', 'Mostert', 69, 205, 2015, 29, 'Purdue', (SELECT team_id FROM Team WHERE team_name = '49ers'), 2),
(46, 'Chris', 'Carson', 71, 222, 2017, 28, 'Oklahoma State', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 2),
(47, 'James', 'Conner', 73, 233, 2017, 26, 'Pittsburgh', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 2),
(48, 'Cam', 'Akers', 71, 217, 2020, 23, 'Florida State', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 2),
(49, 'Devin', 'Singletary', 68, 203, 2019, 24, 'Florida Atlantic', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 2),
(50, 'Myles', 'Gaskin', 69, 194, 2019, 24, 'Washington', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 2),
(51, 'Damien', 'Harris', 70, 213, 2019, 25, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 2),
(52, 'Michael', 'Carter', 68, 201, 2021, 22, 'North Carolina', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 2),
(53, 'Joe', 'Mixson', 73, 228, 2017, 26, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 2),
(54, 'J.K.', 'Dobbins', 70, 212, 2020, 23, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 2),
(55, 'Najee', 'Harris', 73, 230, 2021, 23, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 2),
(56, 'Kareem', 'Hunt', 70, 216, 2017, 26, 'Toledo', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 2),
(57, 'Jonathan', 'Taylor', 70, 226, 2020, 23, 'Wisconsin', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 2),
(58, 'Derrick', 'Henry', 75, 247, 2016, 28, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 2),
(59, 'James', 'Robinson', 71, 220, 2020, 23, 'Illinois State', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 2),
(60, 'Mark', 'Ingram', 69, 215, 2011, 33, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 2),
(61, 'Clyde', 'Edwards-Helaire', 68, 207, 2020, 23, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 2),
(62, 'Austin', 'Ekeler', 69, 200, 2017, 27, 'Western Colorado', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 2),
(63, 'Javonte', 'Williams', 71, 220, 2021, 22, 'North Carolina', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 2),
(64, 'Josh', 'Jacobs', 70, 220, 2019, 24, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 2);

-- Insert Wide Receivers
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(65, 'DeVonta', 'Smith', 72, 166, 2021, 23, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 3), 
(66, 'Amari', 'Cooper', 73, 210, 2015, 28, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 3),
(67, 'Kenny', 'Golladay', 76, 218, 2017, 29, 'Northern Illinois', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 3),
(68, 'Terry', 'McLaurin', 72, 210, 2019, 26, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 3),

-- NFC North
(69, 'Justin', 'Jefferson', 73, 202, 2020, 22, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 3),
(70, 'Tyrell', 'Williams', 75, 204, 2015, 30, 'Western Oregon', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 3),
(71, 'Davante', 'Adams', 73, 215, 2014, 30, 'Fresno State', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 3),
(72, 'Darnell', 'Mooney', 71, 175, 2020, 24, 'Tulane', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 3),

-- NFC South
(73, 'Mike', 'Evans', 77, 231, 2014, 29, 'Texas A&M', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 3),
(74, 'Michael', 'Thomas', 75, 212, 2016, 29, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 3),
(75, 'Calvin', 'Ridley', 73, 190, 2018, 27, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 3),
(76, 'Robbie', 'Anderson', 75, 190, 2016, 29, 'Temple', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 3),

-- NFC West
(77, 'Deebo', 'Samuel', 71, 214, 2019, 25, 'South Carolina', (SELECT team_id FROM Team WHERE team_name = '49ers'), 3),
(78, 'DK', 'Metcalf', 76, 229, 2019, 24, 'Ole Miss', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 3),
(79, 'Christian', 'Kirk', 70, 200, 2018, 26, 'Texas A&M', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 3),
(80, 'Cooper', 'Kupp', 74, 198, 2017, 28, 'Eastern Washington', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 3),

-- AFC East
(81, 'Stefon', 'Diggs', 74, 191, 2015, 28, 'Maryland', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 3),
(82, 'Jaylen', 'Waddle', 68, 182, 2021, 23, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 3),
(83, 'Nelson', 'Agholor', 72, 198, 2015, 29, 'USC', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 3),
(84, 'Corey', 'Davis', 75, 209, 2017, 27, 'Western Michigan', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 3),

-- AFC North
(85, 'Ja\'Marr', 'Chase', 72, 201, 2021, 22, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 3),
(86, 'Marquise', 'Brown', 69, 180, 2019, 24, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 3),
(87, 'Chase', 'Claypool', 76, 238, 2020, 23, 'Notre Dame', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 3),
(88, 'Odell', 'Beckham Jr.', 72, 205, 2014, 29, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 3),

-- AFC South
(89, 'A.J.', 'Brown', 74, 226, 2019, 24, 'Ole Miss', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 3),
(90, 'Julio', 'Jones', 75, 220, 2011, 33, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 3),
(91, 'D.J.', 'Chark', 75, 198, 2018, 25, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 3),
(92, 'Chris', 'Conley', 75, 213, 2015, 29, 'Georgia', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 3),

-- AFC West
(93, 'Tyreek', 'Hill', 68, 185, 2016, 28, 'West Alabama', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 3),
(94, 'Keenan', 'Allen', 74, 211, 2013, 30, 'Cal', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 3),
(95, 'Courtland', 'Sutton', 76, 216, 2018, 26, 'SMU', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 3),
(96, 'Hunter', 'Renfrow', 70, 185, 2019, 26, 'Clemson', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 3);

-- Insert Tight Ends
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(97, 'Zach', 'Ertz', 77, 250, 2013, 31, 'Stanford', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 4), 
(98, 'Blake', 'Jarwin', 76, 260, 2017, 27, 'Oklahoma State', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 4),
(99, 'Evan', 'Engram', 76, 240, 2017, 27, 'Mississippi', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 4),
(100, 'Logan', 'Thomas', 78, 248, 2014, 30, 'Virginia Tech', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 4),

-- NFC North
(101, 'Kyle', 'Rudolph', 78, 265, 2011, 32, 'Notre Dame', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 4),
(102, 'T.J.', 'Hockenson', 77, 248, 2019, 24, 'Iowa', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 4),
(103, 'Robert', 'Tonyan', 76, 237, 2017, 27, 'Indiana State', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 4),
(104, 'Jimmy', 'Graham', 78, 268, 2010, 35, 'Miami (FL)', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 4),

-- NFC South
(105, 'Rob', 'Gronkowski', 78, 268, 2010, 33, 'Arizona', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 4),
(106, 'Adam', 'Trautman', 78, 253, 2020, 24, 'Dayton', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 4),
(107, 'Kyle', 'Pitts', 80, 245, 2021, 21, 'Florida', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 4),
(108, 'Ian', 'Thomas', 78, 260, 2018, 26, 'Indiana', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 4),

-- NFC West
(109, 'George', 'Kittle', 77, 250, 2017, 28, 'Iowa', (SELECT team_id FROM Team WHERE team_name = '49ers'), 4),
(110, 'Will', 'Dissly', 76, 265, 2018, 25, 'Washington', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 4),
(111, 'Maxx', 'Williams', 78, 252, 2015, 27, 'Minnesota', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 4),
(112, 'Tyler', 'Higbee', 78, 255, 2016, 29, 'Western Kentucky', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 4),

-- AFC East
(113, 'Dawson', 'Knox', 78, 254, 2019, 24, 'Ole Miss', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 4),
(114, 'Mike', 'Gesicki', 77, 250, 2018, 26, 'Penn State', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 4),
(115, 'Hunter', 'Henry', 78, 250, 2016, 27, 'Arkansas', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 4),
(116, 'Chris', 'Herndon', 76, 253, 2018, 25, 'Miami (FL)', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 4),

-- AFC North
(117, 'C.J.', 'Uzomah', 78, 260, 2015, 29, 'Auburn', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 4),
(118, 'Mark', 'Andrews', 78, 256, 2018, 26, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 4),
(119, 'Eric', 'Ebron', 77, 250, 2014, 29, 'North Carolina', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 4),
(120, 'Austin', 'Hooper', 76, 255, 2016, 27, 'Stanford', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 4),

-- AFC South
(121, 'Rob', 'Gronkowski', 78, 268, 2010, 33, 'Arizona', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 4),
(122, 'Anthony', 'Firkser', 76, 244, 2017, 26, 'Harvard', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 4),
(123, 'Chris', 'Manhertz', 78, 255, 2016, 29, 'Canisius', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 4),
(124, 'Jordan', 'Akins', 76, 243, 2018, 29, 'UCF', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 4),

-- AFC West
(125, 'Travis', 'Kelce', 77, 260, 2013, 32, 'Cincinnati', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 4),
(126, 'Jared', 'Cook', 78, 254, 2009, 35, 'South Carolina', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 4),
(127, 'Noah', 'Fant', 76, 249, 2019, 24, 'Iowa', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 4),
(128, 'Darren', 'Waller', 78, 255, 2015, 29, 'Georgia Tech', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 4);

-- Insert Offensive Linemen
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(129, 'Lane', 'Johnson', 79, 317, 2013, 32, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 5), -- OL
(130, 'Zack', 'Martin', 76, 315, 2014, 31, 'Notre Dame', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 5),
(131, 'Andrew', 'Thomas', 78, 315, 2020, 22, 'Georgia', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 5),
(132, 'Brandon', 'Scherff', 77, 315, 2015, 30, 'Iowa', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 5),

-- NFC North
(133, 'Brian', 'O\'Neill', 80, 297, 2018, 26, 'Pittsburgh', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 5),
(134, 'Taylor', 'Decker', 81, 312, 2016, 28, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 5),
(135, 'David', 'Bakhtiari', 76, 310, 2013, 30, 'Colorado', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 5),
(136, 'Cody', 'Whitehair', 76, 310, 2016, 30, 'Kansas State', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 5),

-- NFC South
(137, 'Tristan', 'Wirfs', 80, 320, 2020, 22, 'Iowa', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 5),
(138, 'Terron', 'Armstead', 81, 330, 2013, 30, 'Arkansas-Pine Bluff', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 5),
(139, 'Jake', 'Matthews', 77, 309, 2014, 30, 'Texas A&M', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 5),
(140, 'Taylor', 'Motom', 77, 318, 2019, 24, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 5),

-- NFC West
(141, 'Trent', 'Williams', 80, 320, 2010, 33, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = '49ers'), 5),
(142, 'Duane', 'Brown', 76, 315, 2008, 36, 'Virginia Tech', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 5),
(143, 'Rodger', 'Saffold', 78, 323, 2010, 33, 'Indiana', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 5),
(144, 'Andrew', 'Whitworth', 79, 330, 2006, 40, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 5),

-- AFC East
(145, 'Dion', 'Dawkins', 79, 321, 2017, 27, 'Temple', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 5),
(146, 'Austin', 'Jackson', 80, 324, 2020, 22, 'USC', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 5),
(147, 'Isaiah', 'Wynn', 77, 310, 2018, 26, 'Georgia', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 5),
(148, 'Mekhi', 'Becton', 80, 363, 2020, 23, 'Louisville', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 5),

-- AFC North
(149, 'Jonah', 'Williams', 77, 305, 2019, 24, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 5),
(150, 'Orlando', 'Brown Jr.', 82, 345, 2018, 25, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 5),
(151, 'Kevin', 'Dotson', 76, 321, 2020, 23, 'Louisiana', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 5),
(152, 'Jack', 'Conklin', 78, 308, 2016, 27, 'Michigan State', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 5),

-- AFC South
(153, 'Quenton', 'Nelson', 76, 330, 2018, 25, 'Notre Dame', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 5),
(154, 'Rodger', 'Saffold', 78, 323, 2010, 33, 'Indiana', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 5),
(155, 'Cam', 'Robinson', 78, 320, 2017, 26, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 5),
(156, 'Laremy', 'Tunsil', 78, 313, 2016, 27, 'Ole Miss', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 5),

-- AFC West
(157, 'Orlando', 'Brown', 82, 345, 2018, 25, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 5),
(158, 'Rashawn', 'Slater', 77, 315, 2021, 22, 'Northwestern', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 5),
(159, 'Garett', 'Bolles', 79, 300, 2017, 30, 'Utah', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 5),
(160, 'Kolton', 'Miller', 80, 325, 2018, 26, 'UCLA', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 5);

-- Insert Defensive Linemen
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(161, 'Fletcher', 'Cox', 77, 310, 2012, 31, 'Mississippi State', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 6),
(162, 'Demarcus', 'Lawrence', 76, 265, 2014, 29, 'Boise State', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 6),
(163, 'Leonard', 'Williams', 77, 255, 2015, 28, 'USC', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 6),
(164, 'Chase', 'Young', 78, 264, 2020, 22, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 6),

-- NFC North
(165, 'Danielle', 'Hunter', 77, 252, 2015, 27, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 6),
(166, 'Trey', 'Flowers', 76, 265, 2015, 29, 'Arkansas', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 6),
(167, 'Kenny', 'Clark', 75, 314, 2016, 26, 'UCLA', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 6),
(168, 'Akiem', 'Hicks', 76, 332, 2012, 33, 'Regina', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 6),

-- NFC South
(169, 'Vita', 'Vea', 76, 347, 2018, 26, 'Washington', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 6),
(170, 'Cameron', 'Jordan', 76, 287, 2011, 33, 'California', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 6),
(171, 'Grady', 'Jarrett', 73, 305, 2015, 29, 'Clemson', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 6),
(172, 'Derrick', 'Brown', 76, 325, 2020, 23, 'Auburn', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 6),

-- NFC West
(173, 'Nick', 'Bosa', 76, 278, 2019, 24, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = '49ers'), 6),
(174, 'Carlos', 'Dunlap', 78, 285, 2010, 33, 'Florida', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 6),
(175, 'J.J.', 'Watt', 77, 288, 2011, 33, 'Wisconsin', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 6),
(176, 'Aaron', 'Donald', 73, 280, 2014, 30, 'Pittsburgh', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 6),

-- AFC East
(177, 'Ed', 'Oliver', 73, 287, 2019, 24, 'Houston', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 6),
(178, 'Christian', 'Wilkins', 76, 309, 2019, 25, 'Clemson', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 6),
(179, 'Matthew', 'Judon', 76, 275, 2016, 29, 'Grand Valley State', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 6),
(180, 'Quinnen', 'Williams', 76, 303, 2019, 24, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 6),

-- AFC North
(181, 'Sam', 'Hubbard', 76, 265, 2018, 26, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 6),
(182, 'Calais', 'Campbell', 79, 300, 2008, 36, 'Miami (FL)', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 6),
(183, 'Cameron', 'Heyward', 76, 295, 2011, 33, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 6),
(184, 'Myles', 'Garrett', 76, 272, 2017, 26, 'Texas A&M', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 6),

-- AFC South
(185, 'DeForest', 'Buckner', 77, 287, 2016, 26, 'Oregon', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 6),
(186, 'Jeffery', 'Simmons', 76, 305, 2019, 25, 'Mississippi State', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 6),
(187, 'Josh', 'Allen', 76, 262, 2019, 25, 'Kentucky', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 6),
(188, 'Whitney', 'Mercilus', 76, 265, 2012, 31, 'Illinois', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 6),

-- AFC West
(189, 'Chris', 'Jones', 78, 310, 2016, 27, 'Mississippi State', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 6),
(190, 'Joey', 'Bosa', 77, 280, 2016, 26, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 6),
(191, 'Maxx', 'Crosby', 77, 260, 2019, 24, 'Eastern Michigan', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 6),
(192, 'Yannick', 'Ngakoue', 75, 245, 2016, 26, 'Maryland', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 6);

-- Insert Linebackers
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(193, 'Darius', 'Leonard', 74, 230, 2018, 26, 'South Carolina State', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 7),
(194, 'Leighton', 'Vander Esch', 77, 256, 2018, 25, 'Boise State', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 7),
(195, 'Blake', 'Martinez', 74, 237, 2016, 28, 'Stanford', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 7),
(196, 'Cole', 'Holcomb', 74, 234, 2019, 25, 'North Carolina', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 7),

-- NFC North
(197, 'Eric', 'Kendricks', 72, 232, 2015, 29, 'UCLA', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 7),
(198, 'Jamie', 'Collins Sr.', 75, 250, 2013, 32, 'Southern Miss', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 7),
(199, 'DeVondre', 'Campbell', 76, 232, 2016, 29, 'Minnesota', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 7),
(200, 'Roquan', 'Smith', 73, 232, 2018, 24, 'Georgia', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 7),

-- NFC South
(201, 'Lavonte', 'David', 73, 233, 2012, 31, 'Nebraska', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 7),
(202, 'Demario', 'Davis', 74, 248, 2012, 32, 'Arkansas State', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 7),
(203, 'Deion', 'Jones', 73, 227, 2016, 27, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 7),
(204, 'Haason', 'Reddick', 73, 235, 2017, 27, 'Temple', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 7),

-- NFC West
(205, 'Fred', 'Warner', 74, 236, 2018, 25, 'BYU', (SELECT team_id FROM Team WHERE team_name = '49ers'), 7),
(206, 'Bobby', 'Wagner', 74, 243, 2012, 31, 'Utah State', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 7),
(207, 'Isaiah', 'Simmons', 76, 238, 2020, 22, 'Clemson', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 7),
(208, 'Kenny', 'Young', 74, 236, 2018, 27, 'UCLA', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 7),

-- AFC East
(209, 'Tremaine', 'Edmunds', 76, 250, 2018, 24, 'Virginia Tech', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 7),
(210, 'Jerome', 'Baker', 74, 215, 2018, 25, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 7),
(211, 'Donta', 'Hightower', 75, 260, 2012, 31, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 7),
(212, 'C.J.', 'Mosley', 74, 238, 2014, 29, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 7),

-- AFC North
(213, 'Logan', 'Wilson', 74, 230, 2020, 25, 'Wyoming', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 7),
(214, 'Patrick', 'Queen', 72, 232, 2020, 22, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 7),
(215, 'T.J.', 'Watt', 76, 252, 2017, 27, 'Wisconsin', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 7),
(216, 'Anthony', 'Walker', 74, 245, 2017, 26, 'Northwestern', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 7),

-- AFC South
(217, 'Darius', 'Leonard', 74, 230, 2018, 26, 'South Carolina State', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 7),
(218, 'Jayon', 'Brown', 74, 226, 2017, 26, 'UCLA', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 7),
(219, 'Myles', 'Jack', 75, 244, 2016, 26, 'UCLA', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 7),
(220, 'Zach', 'Cunningham', 74, 230, 2017, 27, 'Vanderbilt', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 7),

-- AFC West
(221, 'Denzel', 'Perryman', 71, 240, 2015, 29, 'Miami (FL)', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 7),
(222, 'Kenneth', 'Murray', 75, 241, 2020, 23, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 7),
(223, 'Alexander', 'Johnson', 74, 240, 2018, 30, 'Tennessee', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 7),
(224, 'Nick', 'Kwiatkoski', 74, 242, 2016, 29, 'West Virginia', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 7);

-- Insert Cornerbacks
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(225, 'Darius', 'Slay', 72, 190, 2013, 31, 'Mississippi State', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 8),
(226, 'Trevon', 'Diggs', 74, 205, 2020, 23, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 8),
(227, 'James', 'Bradberry', 73, 212, 2016, 28, 'Samford', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 8),
(228, 'Kendall', 'Fuller', 71, 198, 2016, 27, 'Virginia Tech', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 8),

-- NFC North
(229, 'Patrick', 'Peterson', 73, 203, 2011, 32, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 8),
(230, 'Jeff', 'Okudah', 73, 200, 2020, 22, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 8),
(231, 'Jaire', 'Alexander', 71, 196, 2018, 25, 'Louisville', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 8),
(232, 'Jaylon', 'Johnson', 72, 195, 2020, 23, 'Utah', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 8),

-- NFC South
(233, 'Carlton', 'Davis', 74, 206, 2018, 25, 'Auburn', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 8),
(234, 'Marshon', 'Lattimore', 72, 192, 2017, 26, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 8),
(235, 'A.J.', 'Terrell', 74, 195, 2020, 22, 'Clemson', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 8),
(236, 'Donte', 'Jackson', 71, 180, 2018, 25, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 8),

-- NFC West
(237, 'Jalen', 'Ramsey', 73, 208, 2016, 27, 'Florida State', (SELECT team_id FROM Team WHERE team_name = '49ers'), 8),
(238, 'Quandre', 'Diggs', 71, 198, 2015, 29, 'Texas', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 8),
(239, 'Byron', 'Murphy', 71, 185, 2019, 24, 'Washington', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 8),
(240, 'Jalen', 'Ramsey', 73, 208, 2016, 27, 'Florida State', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 8),

-- AFC East
(241, 'Tre', 'Davious White', 71, 198, 2017, 27, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 8),
(242, 'Xavien', 'Howard', 72, 198, 2016, 28, 'Baylor', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 8),
(243, 'J.C.', 'Jackson', 71, 198, 2018, 26, 'Maryland', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 8),
(244, 'Bryce', 'Hall', 74, 202, 2020, 23, 'Virginia', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 8),

-- AFC North
(245, 'Marlon', 'Humphrey', 72, 197, 2017, 25, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 8),
(246, 'Marcus', 'Peters', 72, 197, 2015, 29, 'Washington', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 8),
(247, 'Joe', 'Haden', 71, 195, 2010, 33, 'Florida', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 8),
(248, 'Greg', 'Newsome II', 73, 192, 2021, 21, 'Northwestern', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 8),

-- AFC South
(249, 'Kenny', 'Moore II', 69, 190, 2017, 26, 'Valdosta State', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 8),
(250, 'Caleb', 'Farley', 74, 197, 2021, 21, 'Virginia Tech', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 8),
(251, 'A.J.', 'Bouye', 72, 191, 2013, 30, 'Central Florida', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 8),
(252, 'Terrance', 'Mitchell', 71, 191, 2014, 29, 'Oregon', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 8),

-- AFC West
(253, 'Chris', 'Harris Jr.', 69, 199, 2011, 32, 'Kansas', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 8),
(254, 'Casey', 'Hayward', 71, 192, 2012, 32, 'Vanderbilt', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 8),
(255, 'Bryce', 'Callahan', 68, 188, 2015, 30, 'Rice', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 8),
(256, 'Damon', 'Arnette', 72, 195, 2020, 25, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 8);

-- Insert Safeties
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(257, 'DAndre', 'Dinwiddie', 72, 202, 2019, 24, 'Tuskegee', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 9),
(258, 'Donovan', 'Wilson', 73, 206, 2019, 24, 'Texas A&M', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 9),
(259, 'Logan', 'Ryan', 71, 195, 2013, 31, 'Rutgers', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 9),
(260, 'Landon', 'Collins', 72, 218, 2015, 28, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 9),

-- NFC North
(261, 'Harrison', 'Smith', 74, 214, 2012, 33, 'Notre Dame', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 9),
(262, 'Tracy', 'Walker', 73, 206, 2018, 27, 'Louisiana', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 9),
(263, 'Adrian', 'Amos', 72, 214, 2015, 29, 'Penn State', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 9),
(264, 'Eddie', 'Jackson', 72, 204, 2017, 27, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 9),

-- NFC South
(265, 'Antoine', 'Winfield Jr.', 70, 203, 2020, 23, 'Minnesota', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 9),
(266, 'Malcolm', 'Jenkins', 72, 204, 2009, 34, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 9),
(267, 'Jaycee', 'Horn', 73, 205, 2021, 22, 'South Carolina', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 9),
(268, 'Jeremy', 'Chinn', 76, 212, 2020, 23, 'Southern Illinois', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 9),

-- NFC West
(269, 'Tyrann', 'Mathieu', 69, 180, 2013, 30, 'LSU', (SELECT team_id FROM Team WHERE team_name = '49ers'), 9),
(270, 'Quandre', 'Diggs', 71, 198, 2015, 29, 'Texas', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 9),
(271, 'Budda', 'Baker', 70, 195, 2017, 26, 'Washington', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 9),
(272, 'Jordan', 'Fuller', 72, 203, 2020, 24, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 9),

-- AFC East
(273, 'Micah', 'Hyde', 72, 196, 2013, 31, 'Iowa', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 9),
(274, 'Justin', 'Coleman', 71, 190, 2015, 29, 'Tennessee', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 9),
(275, 'Devin', 'McCourty', 71, 205, 2010, 34, 'Rutgers', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 9),
(276, 'Marcus', 'Maye', 72, 207, 2017, 28, 'Florida', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 9),

-- AFC North
(277, 'Jessie', 'Bates III', 73, 200, 2018, 25, 'Wake Forest', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 9),
(278, 'Chuck', 'Clark', 72, 205, 2017, 26, 'Virginia Tech', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 9),
(279, 'Minkah', 'Fitzpatrick', 72, 207, 2018, 25, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 9),
(280, 'John', 'Johnson III', 72, 205, 2017, 26, 'Boston College', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 9),

-- AFC South
(281, 'Kenny', 'Moore II', 69, 190, 2017, 26, 'Valdosta State', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 9),
(282, 'Kevin', 'Byard', 71, 216, 2016, 28, 'Middle Tennessee', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 9),
(283, 'Jarrod', 'Wilson', 74, 200, 2016, 28, 'Michigan', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 9),
(284, 'Lonnie', 'Johnson Jr.', 74, 213, 2019, 24, 'Kentucky', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 9),

-- AFC West
(285, 'Tyrann', 'Mathieu', 69, 180, 2013, 30, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 9),
(286, 'Derwin', 'James', 74, 212, 2018, 25, 'Florida State', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 9),
(287, 'Justin', 'Simmons', 74, 201, 2016, 27, 'Boston College', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 9),
(288, 'Johnathan', 'Abram', 72, 205, 2019, 25, 'Mississippi State', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 9);

-- Insert Kickers
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(289, 'Jake', 'Elliott', 70, 167, 2017, 26, 'Memphis', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 10), -- K
(290, 'Greg', 'Zuerlein', 72, 194, 2012, 34, 'Missouri Western', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 10),
(291, 'Graham', 'Gano', 72, 202, 2009, 35, 'Florida State', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 10),
(292, 'Chris', 'Boswell', 72, 185, 2014, 30, 'Rice', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 10),

-- NFC North
(293, 'Greg', 'Joseph', 74, 210, 2018, 27, 'Florida Atlantic', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 10),
(294, 'Riley', 'Patterson', 73, 185, 2021, 22, 'Memphis', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 10),
(295, 'Mason', 'Crosby', 73, 207, 2007, 37, 'Colorado', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 10),
(296, 'Eddy', 'Pineiro', 72, 182, 2018, 26, 'Florida', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 10),

-- NFC South
(297, 'Ryan', 'Succop', 74, 218, 2009, 35, 'South Carolina', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 10),
(298, 'Wil', 'Lutz', 72, 184, 2016, 27, 'Georgia State', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 10),
(299, 'Younghoe', 'Koo', 68, 185, 2017, 27, 'Georgia Southern', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 10),
(300, 'Joey', 'Slye', 73, 213, 2019, 25, 'Virginia Tech', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 10),

-- NFC West
(301, 'Robbie', 'Gould', 72, 219, 2005, 39, 'Penn State', (SELECT team_id FROM Team WHERE team_name = '49ers'), 10),
(302, 'Jason', 'Myers', 73, 190, 2012, 31, 'Marist', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 10),
(303, 'Matt', 'Prater', 75, 205, 2006, 37, 'UCF', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 10),
(304, 'Matt', 'Gay', 73, 232, 2019, 24, 'Utah', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 10),

-- AFC East
(305, 'Tyler', 'Bass', 70, 183, 2020, 24, 'Georgia Southern', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 10),
(306, 'Jason', 'Sanders', 71, 185, 2018, 26, 'New Mexico', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 10),
(307, 'Nick', 'Folk', 73, 211, 2007, 37, 'Arizona', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 10),
(308, 'Eddy', 'Pineiro', 72, 182, 2018, 26, 'Florida', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 10),

-- AFC North
(309, 'Evan', 'McPherson', 73, 185, 2021, 22, 'Florida', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 10),
(310, 'Justin', 'Tucker', 72, 183, 2012, 32, 'Texas', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 10),
(311, 'Chris', 'Boswell', 72, 185, 2014, 30, 'Rice', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 10),
(312, 'Chase', 'McLaughlin', 71, 180, 2019, 25, 'Illinois', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 10),

-- AFC South
(313, 'Rodrigo', 'Blankenship', 72, 198, 2020, 24, 'Georgia', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 10),
(314, 'Randall', 'Bullock', 69, 205, 2012, 32, 'Texas A&M', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 10),
(315, 'Josh', 'Lambo', 73, 215, 2015, 31, 'Texas A&M', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 10),
(316, 'Kaimi', 'Fairbairn', 73, 183, 2016, 27, 'UCLA', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 10),

-- AFC West
(317, 'Harrison', 'Butker', 72, 205, 2017, 26, 'Georgia Tech', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 10),
(318, 'Daniel', 'Carlson', 77, 215, 2018, 27, 'Auburn', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 10),
(319, 'Brandon', 'McManus', 74, 201, 2014, 30, 'Temple', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 10),
(320, 'Daniel', 'Carlson', 77, 215, 2018, 27, 'Auburn', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 10);

-- Insert Punters
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(321, 'Cameron', 'Johnston', 74, 190, 2017, 29, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 11), 
(322, 'Bryan', 'Anger', 76, 208, 2012, 33, 'California', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 11),
(323, 'Riley', 'Dixon', 74, 221, 2016, 28, 'Syracuse', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 11),
(324, 'Tress', 'Way', 74, 220, 2014, 31, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 11),

-- NFC North
(325, 'Jordan', 'Berry', 74, 185, 2015, 30, 'Eastern Kentucky', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 11),
(326, 'Jack', 'Fox', 74, 208, 2020, 24, 'Rice', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 11),
(327, 'J.K.', 'Scott', 78, 208, 2018, 25, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 11),
(328, 'Pat', 'ODonnell', 76, 217, 2014, 30, 'Miami (FL)', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 11),

-- NFC South
(329, 'Bradley', 'Pinion', 78, 240, 2015, 27, 'Clemson', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 11),
(330, 'Thomas', 'Morstead', 76, 235, 2009, 36, 'SMU', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 11),
(331, 'Dom', 'Maggio', 72, 213, 2021, 24, 'Wake Forest', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 11),
(332, 'Joseph', 'Charlton', 76, 257, 2020, 25, 'South Carolina', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 11),

-- NFC West
(333, 'Mitch', 'Wishnowsky', 72, 220, 2019, 28, 'Utah', (SELECT team_id FROM Team WHERE team_name = '49ers'), 11),
(334, 'Michael', 'Dickson', 76, 208, 2018, 25, 'Texas', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 11),
(335, 'Andy', 'Lee', 74, 185, 2004, 39, 'Pittsburgh', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 11),
(336, 'Johnny', 'Hekker', 76, 241, 2012, 31, 'Oregon State', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 11),

-- AFC East
(337, 'Matt', 'Haack', 76, 218, 2017, 27, 'Arizona State', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 11),
(338, 'Michael', 'Palardy', 73, 199, 2016, 29, 'Tennessee', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 11),
(339, 'Jake', 'Bailey', 73, 205, 2019, 24, 'Stanford', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 11),
(340, 'Thomas', 'Morstead', 76, 235, 2009, 36, 'SMU', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 11),

-- AFC North
(341, 'Kevin', 'Huber', 74, 214, 2009, 36, 'Cincinnati', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 11),
(342, 'Jordan', 'Berry', 74, 185, 2015, 30, 'Eastern Kentucky', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 11),
(343, 'Pressley', 'Harvin III', 72, 255, 2021, 23, 'Georgia Tech', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 11),
(344, 'Jamie', 'Gillan', 74, 207, 2019, 24, 'Arkansas-Pine Bluff', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 11),

-- AFC South
(345, 'Rigoberto', 'Sanchez', 73, 195, 2017, 27, 'Hawaii', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 11),
(346, 'Brett', 'Kern', 74, 214, 2008, 35, 'Toledo', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 11),
(347, 'Logan', 'Cooke', 74, 230, 2018, 26, 'Mississippi State', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 11),
(348, 'Cameron', 'Johnston', 74, 190, 2017, 29, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 11),

-- AFC West
(349, 'Tom', 'Townsend', 74, 207, 2018, 25, 'Florida', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 11),
(350, 'Ty', 'Long', 73, 212, 2019, 26, 'Alabama-Birmingham', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 11),
(351, 'Sam', 'Martin', 73, 211, 2013, 32, 'Appalachian State', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 11),
(352, 'A.J.', 'Cole III', 73, 220, 2019, 26, 'North Carolina State', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 11);

-- Insert Long Snappers
INSERT INTO Player (player_id, fname, lname, height, weight, draft_year, age, college, team_id, position_id)
VALUES
-- NFC East
(353, 'Rick', 'Lovelato', 73, 248, 2015, 30, 'Old Dominion', (SELECT team_id FROM Team WHERE team_name = 'Eagles'), 12), 
(354, 'Jake', 'McQuaide', 75, 244, 2011, 33, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Cowboys'), 12),
(355, 'Casey', 'Kreiter', 76, 250, 2014, 31, 'Iowa', (SELECT team_id FROM Team WHERE team_name = 'Giants'), 12),
(356, 'Cheyenne', 'OGrady', 76, 240, 2019, 25, 'Arkansas', (SELECT team_id FROM Team WHERE team_name = 'Commanders'), 12),

-- NFC North
(357, 'Andrew', 'DePaola', 76, 230, 2012, 34, 'Rutgers', (SELECT team_id FROM Team WHERE team_name = 'Vikings'), 12),
(358, 'Scott', 'Daly', 75, 252, 2019, 26, 'Notre Dame', (SELECT team_id FROM Team WHERE team_name = 'Lions'), 12),
(359, 'Hunter', 'Bradley', 76, 242, 2018, 25, 'Mississippi State', (SELECT team_id FROM Team WHERE team_name = 'Packers'), 12),
(360, 'Patrick', 'Scales', 76, 242, 2011, 33, 'Utah State', (SELECT team_id FROM Team WHERE team_name = 'Bears'), 12),

-- NFC South
(361, 'Zach', 'Wood', 73, 240, 2016, 29, 'Southern Methodist', (SELECT team_id FROM Team WHERE team_name = 'Buccaneers'), 12),
(362, 'Zach', 'Wood', 73, 240, 2016, 29, 'Southern Methodist', (SELECT team_id FROM Team WHERE team_name = 'Saints'), 12),
(363, 'Josh', 'Harris', 75, 224, 2012, 34, 'Auburn', (SELECT team_id FROM Team WHERE team_name = 'Falcons'), 12),
(364, 'J.J.', 'Jansen', 76, 252, 2009, 36, 'Notre Dame', (SELECT team_id FROM Team WHERE team_name = 'Panthers'), 12),

-- NFC West
(365, 'Kyle', 'Nelson', 74, 240, 2011, 31, 'New Mexico State', (SELECT team_id FROM Team WHERE team_name = '49ers'), 12),
(366, 'Tyler', 'Ott', 76, 253, 2014, 31, 'Harvard', (SELECT team_id FROM Team WHERE team_name = 'Seahawks'), 12),
(367, 'Aaron', 'Brewer', 74, 232, 2012, 35, 'San Diego State', (SELECT team_id FROM Team WHERE team_name = 'Cardinals'), 12),
(368, 'Jake', 'McQuaide', 75, 244, 2011, 33, 'Ohio State', (SELECT team_id FROM Team WHERE team_name = 'Rams'), 12),

-- AFC East
(369, 'Reid', 'Ferguson', 74, 235, 2016, 25, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Bills'), 12),
(370, 'Blake', 'Ferguson', 75, 229, 2019, 25, 'LSU', (SELECT team_id FROM Team WHERE team_name = 'Dolphins'), 12),
(371, 'Joe', 'Cardona', 75, 240, 2015, 29, 'Navy', (SELECT team_id FROM Team WHERE team_name = 'Patriots'), 12),
(372, 'Thomas', 'Hennessy', 75, 245, 2017, 25, 'Duke', (SELECT team_id FROM Team WHERE team_name = 'Jets'), 12),

-- AFC North
(373, 'Clark', 'Harris', 76, 250, 2007, 35, 'Rutgers', (SELECT team_id FROM Team WHERE team_name = 'Bengals'), 12),
(374, 'Morgan', 'Cox', 76, 241, 2010, 32, 'Tennessee', (SELECT team_id FROM Team WHERE team_name = 'Ravens'), 12),
(375, 'Kameron', 'Canaday', 76, 245, 2016, 29, 'Portland State', (SELECT team_id FROM Team WHERE team_name = 'Steelers'), 12),
(376, 'Charley', 'Hughlett', 76, 248, 2012, 33, 'Central Florida', (SELECT team_id FROM Team WHERE team_name = 'Browns'), 12),

-- AFC South
(377, 'Luke', 'Rhodes', 76, 238, 2016, 29, 'William & Mary', (SELECT team_id FROM Team WHERE team_name = 'Colts'), 12),
(378, 'Morgan', 'Cox', 76, 241, 2010, 32, 'Tennessee', (SELECT team_id FROM Team WHERE team_name = 'Titans'), 12),
(379, 'Matt', 'Overton', 76, 243, 2007, 35, 'Western Washington', (SELECT team_id FROM Team WHERE team_name = 'Jaguars'), 12),
(380, 'Jon', 'Weeks', 76, 248, 2008, 36, 'Baylor', (SELECT team_id FROM Team WHERE team_name = 'Texans'), 12),

-- AFC West
(381, 'James', 'Winchester', 76, 237, 2015, 31, 'Oklahoma', (SELECT team_id FROM Team WHERE team_name = 'Chiefs'), 12),
(382, 'Cole', 'Mazza', 75, 237, 2019, 26, 'Alabama', (SELECT team_id FROM Team WHERE team_name = 'Chargers'), 12),
(383, 'Jacob', 'Bobenmoyer', 75, 245, 2019, 25, 'Northern Colorado', (SELECT team_id FROM Team WHERE team_name = 'Broncos'), 12),
(384, 'Trent', 'Sieg', 76, 238, 2018, 25, 'Colorado State', (SELECT team_id FROM Team WHERE team_name = 'Raiders'), 12);


-- Insert passing data
CREATE TABLE passing_data (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Player VARCHAR(255),
    Age INT,
    G INT,
    GS INT,
    Cmp INT,
    Att INT,
    CmpPercent FLOAT,
    Yds INT,
    TD INT,
    TDPercent FLOAT,
    interception INT,
    interceptionPercentage FLOAT,
    FirstDowns INT,
    Lng INT,
    YPerA FLOAT,
    AYPerA FLOAT,
    YPerC FLOAT,
    YPerG FLOAT,
    Rating FLOAT,
    Sk INT,
    YdsS INT,
    SkPercent FLOAT,
    NYPerA FLOAT,
    ANYPerA FLOAT,
    Year INT
);

-- Create offensive player table, need to export
CREATE TABLE OffensivePlayer AS
SELECT *
FROM Player
WHERE position_id < 8;

-- Create quarterback player table, need to export
CREATE TABLE Quarterbacks AS
SELECT *
FROM Player
WHERE position_id = 1;

 /*
LOAD DATA LOCAL INFILE 'Users/Jack/calpoly/csc365/project/NFL_statistics/data/passing_cleaned.csv'
INTO TABLE passing_data 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (Player, Age, G, GS, Cmp, Att, CmpPercent, Yds, TD, TDPercent, interception, interceptionPercentage, FirstDowns, Lng, YPerA, AYPerA, YPerC, YPerG, Rating, Sk, YdsS, SkPercent, NYPerA, ANYPerA, Year);
*/



