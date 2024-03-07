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








