# CS3217 Problem Set 4

**Name:** Zico

**Matric No:** A0239156Y

## Tips
1. CS3217's docs is at https://cs3217.github.io/cs3217-docs. Do visit the docs often, as
   it contains all things relevant to CS3217.
2. A Swiftlint configuration file is provided for you. It is recommended for you
   to use Swiftlint and follow this configuration. We opted in all rules and
   then slowly removed some rules we found unwieldy; as such, if you discover
   any rule that you think should be added/removed, do notify the teaching staff
   and we will consider changing it!

   In addition, keep in mind that, ultimately, this tool is only a guideline;
   some exceptions may be made as long as code quality is not compromised.
3. Do not burn out. Have fun!

## Dev Guide
The entire project can be broken up to 5 components

![High Level Diagram](https://github.com/cs3217-2223/problem-set-4-zicotjia/blob/master/Diagrams/HighLevelDiagram.png)

## Features Not Implemented 
1. Rectangle Block (poorly implemented collision logic)
2. Bucket (cannot implement collision logic)
3. Rotatable Item (cannot implement physics engine logic)
4. Ka-Boom powerup (cannot implement physics engine logic)
5. Spicy Peg confusion peg (cannot implement correctly)
6. Preloaded Level (no time to implement)
7. Integration (no main menu)

## Rules of the Game
There are currently 4 Game Modes that is selectable . They are selectable in the level designer

1. StandardMode
   -  No time limit. To win you have to clear all the pegs (including zombie pegs). You lose if you run out of ammo.
 
2. TimeAttack
   -  60 seconds time limit. Similar to StandardMode but you have to clear all the pegs before the time limit end.
   
3. BeatTheScore
   -  60 seconds time limit. Beat the target score before the time ends. You lose if time is over or you run out of pegs. All pegs reward 2 points when hit
   
4. DodgeBall
   -  60 seconds time limit. You win if you can deplete all your ammo without hitting any peg.

### Cannon Direction
Press a location in the screen and the cannon will aim and shoot a ball in the direction you tapped

### Win and Lose Conditions
Depends on the gameMode

## Level Designer Additional Features
Can select gameMode and resize item. Can select how many balls does the player start with in the level.

### Peg Rotation
Not implemented

### Peg Resizing
There is a slider that allow you to adjust the size of the peg in the level designer

## Bells and Whistles
For Bells and Whistles the biggest feature I want to implement is an entirely independent audio engine that can be used by the game without any coupling. It play audio by assembling of MIDI notes and then playing it. Having self learnt up to the beginning of grade 2 music theory, I cannot assure that the audio engine technical implementation adhere correctly to music theory concepts that is used (I may use the wrong term here and there).

1. Audio Engine that can generate and play simple tunes using MIDI and through building an abstraction layer on top of Swift AudioToolBox, also provided the app with a default soundFont in case the device has no soundFont. Sound played by the Audio Engine should imitate an acoustic guitar with nylon string.
2. MusicalPeg modifier, play music when the peg is hit and an arpegio depending on the number of pegs hit. 
3. Standard GameMode and timeAttack GameMode. Number of Balls is also edittable by the player.

## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

## Written Answers

### Reflecting on your Design
> Now that you have integrated the previous parts, comment on your architecture
> in problem sets 2 and 3. Here are some guiding questions:
> - do you think you have designed your code in the previous problem sets well
>   enough?
> - is there any technical debt that you need to clean in this problem set?
> - if you were to redo the entire application, is there anything you would
>   have done differently?

Your answer here
