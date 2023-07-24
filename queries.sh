#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals) + SUM(opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals) + AVG(opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT max(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(game_id) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM games INNER JOIN teams ON games.winner_id = teams.team_id WHERE round='Final' AND year=2018 ")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT t1.name FROM games FULL JOIN teams AS t1 ON games.winner_id = t1.team_id WHERE round = 'Eighth-Final' AND year = 2014 UNION SELECT t2.name FROM games FULL JOIN teams AS t2 ON games.opponent_id = t2.team_id WHERE round = 'Eighth-Final' AND year = 2014 ORDER BY name ")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT name FROM games INNER JOIN teams ON games.winner_id = team_id GROUP BY name ORDER BY name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM games INNER JOIN teams ON games.winner_id = teams.team_id WHERE round = 'Final' ORDER BY year ")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT t1.name FROM games INNER JOIN teams AS t1 ON games.winner_id = t1.team_id WHERE t1.name LIKE 'Co%' UNION SELECT t2.name FROM games INNER JOIN teams AS t2 ON games.opponent_id = t2.team_id WHERE t2.name LIKE 'Co%' ORDER BY name ")"

