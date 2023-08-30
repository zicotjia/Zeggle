A peggle clone made in Swift for the NUS module CS3217. Physics Engine, Game Engine and Audio Engine is developed from scratch in Swift

## Basic
This app is a simple clone of the game Peggle made entirely in Swift. In this game, a player will shoot a ball from a cannon to hit pegs. After the ball is removed from the screen, all the hit pegs will disappear and points will be rewarded.

## Level Selector
https://github.com/zicotjia/Zeggle/assets/77394751/a89140b7-a1d3-458c-a44d-f75778af5880

Player can scroll down to pick which level to play. tapping on the any level will load the level in the level designer

There are 3 default levels: "Level 1", "Rock", "Zombie"

## Level Designer

https://github.com/zicotjia/Zeggle/assets/77394751/2e98b011-9d2a-4a9d-b95c-239fe3548a0e

Player can edit the level to their liking by adding pegs of different types and size. Players can also decide how many balls the player has access to in the level. 

https://github.com/zicotjia/Zeggle/assets/77394751/2387050b-a9ce-468d-be8a-c526f2e96f1c

Player can also pick a game mode here (Go down to "Rules of Game" section for more details). tapping on start will load the level with the selected game mode

https://github.com/zicotjia/Zeggle/assets/77394751/8a630ec3-33fb-4550-b9f9-484a98023967

To create a new level, load a level in the level designer and make edits. Name the level then tap the save button, a new level with the specified name and layouts will be created. If no name is selected, save changes made to the taped level. If a level with the same name as the selected name exist, overwrite the existing level. 

https://github.com/zicotjia/Zeggle/assets/77394751/5e34da0e-75ff-46b1-b2a8-426adb0abd97

The 3 default levels cannot be editted but you can create a new level from it by specifying a different level name to be saved.

## Load button
https://github.com/zicotjia/Zeggle/assets/77394751/116ea641-e254-427f-b3c1-4541e22cfb87

Tapping on the load button will redirect user to the level selector.

## Ball
1. Standard Ball <img width="39" alt="image" src="https://github.com/zicotjia/Zeggle/assets/77394751/d22320a4-adbe-470e-846b-7e213baee7a3">
   - A standard ball that disappear when it reaches the bottom of the screen
2. Zombie Ball <img width="39" alt="image" src="https://github.com/zicotjia/Zeggle/assets/77394751/c6622486-9c14-46c8-8aa7-78ba126427a1">
   - A ball that disappear when it reaches the bottom of the screen and reappear as a standard ball at the top of the screen where it disappeared.
  
## Pegs
1. Standard Pegs <img width="215" alt="image" src="https://github.com/zicotjia/Zeggle/assets/77394751/631f1abb-f4f7-4432-9fc1-102065a33bc3">
   - A standard round shaped Peg of different colors. Hitting a peg will reward points depending on the color of the pegs
3. Zombie Pegs <img width="43" alt="image" src="https://github.com/zicotjia/Zeggle/assets/77394751/6bdeff27-5756-4c22-8b40-074809b33925">
   - A peg that when hit, will act like a ball, hitting other pegs that is in contact with the zombie pegs.
  
## Cannon
https://github.com/zicotjia/Zeggle/assets/77394751/de106c56-efe0-4a12-a3ff-f336e28781df

Press a location in the screen and the cannon will aim and shoot a ball in the direction you tapped

## Ball Selection
https://github.com/zicotjia/Zeggle/assets/77394751/bada8693-1f4d-4d94-9637-cd7f658e628a

tap on any of the ball to select what ball to be shot by the cannon.
   
## Rules of the Game
There are currently 4 Game Modes that is selectable . They are selectable in the level designer

1. StandardMode
   -  No time limit. To win you have to clear all the pegs (including zombie pegs). You lose if you run out of ammo.
 
2. TimeAttack
   -  60 seconds time limit. Similar to StandardMode but you have to clear all the pegs before the time limit end.
   
3. BeatTheScore
   -  Time limit depends on the target to score which also depends on number of pegs and the total score. Beat the target score before the time ends. You lose if time is over or you run out of pegs.
   
4. DodgeBall
   -  60 seconds time limit. You win if you can deplete all your ammo without hitting any peg.

Different coloured pegs will award different points
   - Pink: 10
   - Red: 8
   - Blue: 6
   - Yellow: 4
   - Orange: 2

ZombiePeg does not award points

## Create level
https://github.com/zicotjia/Zeggle/assets/77394751/7cc22f5b-0511-4e9c-9e63-baf497708efd

Create level button will load a level designer with no objects, tap save after naming level to save the created level. 

## Toggle Music
https://github.com/zicotjia/Zeggle/assets/77394751/5f5c386f-c9ff-4e96-8243-9a5b432c19ba

When music is toggled on, music notes will be played when a peg is hit and when it is removed

