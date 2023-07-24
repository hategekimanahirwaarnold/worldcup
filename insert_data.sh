#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# DELETE EVERYTHING IN THE TABLE
$($PSQL "
  TRUNCATE teams, games RESTART IDENTITY;
  SELECT setval('teams_team_id_seq', 1, false);
  SELECT setval('games_game_id_seq', 1, false);
")
#LOOP OVER EVERY LINE IN THE GAME.CSV FILE
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do 
#REMOVE THE FIRST LINE
if [[ $YEAR != 'year' ]]
then 
#get winner id
winner_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
#IF IT IS NOT IN THE TABLE ADD IT
if [[ -z $winner_id ]]
then
$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
winner_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
fi
#get opponent id
opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
#IF IT IS NOT IN THE TABLE ADD IT
if [[ -z $opponent_id ]]
then
$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
fi
#INSERT YEAR,ROUND, W-ID, O_ID, WINNER_GOALS, OPPONENT_GOALS OF THE GAME INTO THE GAME TABLE
$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $winner_id, $opponent_id, $W_GOALS, $O_GOALS)")

fi
done