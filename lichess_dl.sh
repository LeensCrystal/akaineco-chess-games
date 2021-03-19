#!/usr/bin/env bash

cd ~/Desktop/test_curl && { curl -O "https://lichess.org/game/export/$1?evals=0&clocks=0" -H "Accept: application/json" ; cd -; }

for file in *; do
    if [ ! "${file: -3}" == ".sh" ]
    then
        game="$file";
    fi
done

cat "$game" | jq '.players'

# white player information
whiteUsername=$(cat "$game" | jq '.players.white.user.name' --raw-output)
whiteTitle=$(cat "$game" | jq '.players.white.user.title' --raw-output)
whiteRating=$(cat "$game" | jq '.players.white.rating' --raw-output)

# black player information
blackUsername=$(cat "$game" | jq '.players.black.user.name' --raw-output)
blackTitle=$(cat "$game" | jq '.players.black.user.title' --raw-output)
blackRating=$(cat "$game" | jq '.players.black.rating' --raw-output)

if [ "$whiteTitle" == null ]
then
    whiteTitle=""
else
    whiteUsername=" $whiteUsername"
fi

if [ "$blackTitle" == null ]
then
    blackTitle=""
else
    blackUsername=" $blackUsername"
fi

echo "White username is: $whiteUsername"
echo "White title is: $whiteTitle"
echo "White rating is: $whiteRating"

echo "Black username is: $blackUsername"
echo "Black title is: $blackTitle"
echo "Black rating is: $blackRating"

rm "$game"
cd ~/Desktop/test_curl && { curl -O "https://lichess.org/game/export/$1?evals=0&clocks=0" ; cd -; }
for file in *; do
    if [ ! "${file: -3}" == ".sh" ]
    then
        game="$file";
    fi
done
mv "$game" "$whiteTitle$whiteUsername ($whiteRating) vs $blackTitle$blackUsername ($blackRating)"


