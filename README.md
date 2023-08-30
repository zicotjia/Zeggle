A peggle clone made in Swift for the NUS module CS3217

## Navigation 
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

### Cannon Direction
Press a location in the screen and the cannon will aim and shoot a ball in the direction you tapped

### Win and Lose Conditions
Depends on the gameMode

## Level Designer Additional Features
- Can select gameMode and resize item with item preview. Can select how many balls does the player start with in the level.

- Reset now restore the previously saved state of that level.

- Reset also works as a quick load feature. Filling another level name and clicking reset will automatically load the level with said name, beware that you will lose all unsaved progress if you quick load without saving beforehand.

- Quick loading a sample level will create an empty level.

- There is a create new level button at the bottom of the level picker.

- Cannot save a level with name similar to the sample levels or empty name.

- Editting level B but saving with level A in the textBox will overwrite level A and B will remain uneditted.

- Starting a level will also saves the level
