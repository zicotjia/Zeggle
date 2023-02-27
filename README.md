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


## Features Not Fully Implemented 
1. Rectangle Block, there is a test level with it (poorly implemented collision logic)
2. Bucket, there is a test level with it (cannot implement collision logic)
3. Rotatable Item (cannot implement physics engine logic)
4. Ka-Boom powerup (cannot implement physics engine logic)
5. Spicy Peg confusion peg (cannot implement correctly)
7. Integration (no main menu)

## Notes & Change in specification
1. Check that soundFont is properly downloaded, it can be found in the AudioEngine Folder
2. If there is no soundFont the music player will play a sine wave instead of guitar
3. It is highly recommended to play in music mode. The non music mode is still there in case I will still be graded by PS3 integration in PS4
4. The reset button has been changed to reset the level to its previously saved state instead of clearing the level for convenience sake.
5. There are 3 sample levels and 1 test level. The sample levels and all other levels are made to scale correctly to all iPad size while the test level is not necessarily made to scale correctly. 
6. Deleting level is not implemented
7. The level editor won't be able to place item down the lower portion of the level. This is by design. It is to accomodate for the bucket which I fail to implement as of now and may come back to it in the future. There should be no item near the bucket so the bucket will not collide or overlap with other item as it is oscillating.
8. There is no rectangle block in the level editor

## Dev Guide
The entire project can be broken up to 5 components

![High Level Diagram](https://github.com/cs3217-2223/problem-set-4-zicotjia/blob/master/Diagrams/High-Level.png)

### Game Engine
![Game Engine Diagram](https://github.com/cs3217-2223/problem-set-4-zicotjia/blob/master/Diagrams/Zeggle.png)

The Game Engine is responsible for handling all the game logic such as checking if the game is over, launching the cannon, removing objects. 

It is consisted of a level which hold all the information about the game such as the game modes and the items in the game. It has several delegates that is used to separate game logic that is being handled

The ConditionChecker delegate refers to delegate that check whether the win condition or lose condition is met, it will then trigger the win flag or lose flag of the level to signal if the game is won or lost. Depending on the game mode, the level will have different delegate to do this checks,

The ObjectRemover delegate refers to delegate that handle the object removal logic in the game. Depending on the game mode, different delegates is used.

StandardRemover is the normal remover delegate that is used in PS3. RhythmRemover is a special remover that sequentially remove item to be removed following an arpeggio played by the audio engine.

The LevelListViewModel is a view-model that holds the information of all the levels currently in the game and to provide this information to the rendered, it also communicate with the database to handle saving and loading of level.

### Physics Engine
![Physics Engine Diagram](https://github.com/cs3217-2223/problem-set-4-zicotjia/blob/master/Diagrams/PhysicsEngine.png)

The Physics Engine holds the positional information and shape information of the game item and also handle collision events.

It consists of a world that hold all the information about the physics objects. It utilise a collisionResolver delegate to handle the collision detection and resolving

There are 3 Physics Bodies type that can be used to represent object.
- RoundBody refers to an object with round body shape
- LineBody refers to an object with a line shape
- RectangleBody refers to a quadrilateral object comprising of 4 LineBodies

### Audio Engine 
![Audio Engine Diagram](https://github.com/cs3217-2223/problem-set-4-zicotjia/blob/master/Diagrams/Audio-Engine.png)\

Audio Engine is a package that allow the game to play music and assemble sequence of notes by abstracting the functionalities of Swift's AudioToolBox package. 

#### Note
Note refers to musical note. A musical note to MIDI note number mapper is provided for convenience in assembling MIDI notes. 

#### Beat
Beat refers to a duration of a note. There are currently 4 beats in the audio engine which are: half, one, two, four. A beat to float mapper is provided to translate the beat to its respective duration ratio.

#### NoteBeat
NoteBeat refers to a pair consisting of a note and its beat. 

#### Rest
Rest refers to no notes for a duration of time. It extends NoteBeat and is used to signal a period where no notes is played in a track.

#### Scale
Scale refers to a musical scale. It holds a collection of notes in said scale ordered from the lowest pitch to the highest pitch. It has a ppointer that return the notes in the scale and had functionalities to return an arpeggio of differing length. Can be extended to produce different pattern of notes.

#### CMajorScale
Scale comprising of the notes in the CMajorScale

#### Track
Track refers to a sequence of NoteBeat. It can construct a musicalSequence from the sequence of NoteBeat by translating them into MIDI notes with the corresponding duration to be played by the music player.

#### MyMusicPlayer
MyMusicPlayer refer to a music player. It consume a track and produce a sound based on the track. It will load a soundFont in the bundle to give a standardised soundFont to be used by all devices. The sound profile used is currently that of an acoustic guitar. Its abstracts the process of creating the AUGraph.

### Renderer
Renderer holds all the views in the game.

The GameView is the high-level view that pick which scene to render depending on the state of the game. The 3 scenes correspond to the Level Picker, Level Editor and Game scene.

GameScene is the same as PS3 it shows the level that is being played and details of the game such as how many balls are left, time left or points scored.

LevelEditorView shows the level editor similar to PS2. It communicates with the level and view-model to signal changes in the level or saving of level into storage, it also tells the level if there is a change in the game mode to be played. The levelEditor allow the user to pick what object to put into the level and also the size of the objects.

LevelPickerScene shows the list of level in the game. It communicates with the LevelListViewModel to get the levels stored in the game. Clicking on any of the level preview will load the levelEditor for that level


### GameLoop
GameLoop handle the logic of the game as it is being run, the level interact with the game loop to update its states as the game goes on. It also hold the state of the game such as whether it is in the middle of gameplay, is it in level picker or level designer to tell the renderer what to render.


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

### Physics Engine 

#### PhysicsVector1D
-  init(magnitude: CGFloat) 
   - init(magnitude: 0.0) should produce a PhysicsVector1D with magnitude 0.0
   - init(magnitude: 1.0) should produce a PhysicsVector1D with magnitude 1.0
   - init(magnitude: -1.0) should produce a PhysicsVector1D with magnitude -1.0
   
let testVector = PhysicsVector(magnitude: 10.0)
let emptyVector = PhysicsVector(magnitude: 0.0)
let negVector = PhysicsVector(magnitude: -10.0)

- reverse() 
   -  testVector().reverse should return a vector with magnitude -10.0
   -  emptyVector().reverse should returna a vector with magnitude 0.0
   -  negVector().reverse should return a vector with magnitude 10.0
- add()
   -  testVector().add(vector: testVector) should return a vector with magnitude 20.0
   -  testVector().add(vector: negVector) should return a vector with magnitude 10.0
- addMagnitude(by value: CGFloat)
   -  testVector().addMagnitude(by: 10) should return a vector with magnitude 20.0
   -  testVector().addMagnitude(by: 0) should return a vector with magnitude 10.0
   -  testVector().addMagnitude(by: -10) should return a vector with magnitude 0.0
- substract(vector: PhysicsVector1D) 
   - testVector().substract(vector: testVector) should return a vector with magnitude 0.0
   - testVector().substract(vector: emptyVector) should return a vector with magnitude 10.0
   - testVector().substract(vector: negVector) should return a vector with magnitude 20.0
- multiply(vector: PhysicsVector1D)
   - testVector().multiply(vector: testVector) should return a vector with magnitude 100.0
   - testVector().multiply(vector: emptyVector) should return a vector with magnitude 0.0
   - testVector().multiply(vector: negVector) should return a vector with magnitude -100.0
- divideMagnitude(by divisor: CGFloat)
   -  testVector().divideMagnitude(by: 10) should return a vector with magnitude 1.0
   -  testVector().divideMagnitude(by: 2) should return a vector with magnitude 5.0
   -  testVector().divideMagnitude(by: -10) should return a vector with magnitude -1.0
- multiplyMagnitude(by multiple: CGFloat)  
   -  testVector().multiplyMagnitude(by: 10) should return a vector with magnitude 100.0
   -  testVector().multiplyMagnitude(by: 0) should return a vector with magnitude 0.0
   -  testVector().multiplyMagnitude(by: -10) should return a vector with magnitude -100.0

#### PhysicsVector2D
-  init(horizontal: CGFloat, vertical: CGFloat)
   - init(horizontal: 100, vertical: 100) should return a 2d vector with horizontal magnitude of 100 and vertical magnitude of 100
-  init(horizontalVector: PhysicsVector1D, verticalVector: PhysicsVector1D)
   - init(horizontalVector: PhysicsVector1D(magnitude: 100), verticalVector: PhysicsVector(magnitude: 100)) should return a 2d vector with horizontal magnitude of 100 and vertical magnitude of 100
-  init(horizontalVector: PhysicsVector1D)
   - init(horizontalVector: PhysicsVector1d(magnitude: 100) should return a 2d vector with horizontal magnitude of 100 and vertical magnitude of 0
-  init(verticalVector: PhysicsVector1D) 
   - init(verticalVector: PhysicsVector1D(magnitude: 100) should return a 2d vector with horizontal magnitude of  and vertical magnitude of 100

Test each of the inits with value 0 and -100 too

let rightAngledVector = PhysicsVector2D(horizontal: 100, vertical: -100)
let angledVector = PhysicsVector2D(horizontal: 3, vertical: 4)
let verticalVector = PhysicsVector2D(horizontal: 0, vertical: 100)
let horizontalVector = PhysicsVector2D(horizontal: 100, vertical: 0)
let emptyVector = PhysicsVector(horizontal: 0, vertical: 0)

-  magnitude
   - angledVector.magnitude = 5.0
   - angledVector.magnitude = 100.0
-  add
   - verticalVector.add(vector: horizontalVector) should return PhysicsVector2D(horizontal: 100, vertical: 100)
-  substract
   - verticalVector.substract(vector: horizontalVector) should return PhysicsVector2D(horizontal: -100, vertical: -100)
-  multiply
   - angledVector.multiply(by: 20) should return PhysicsVector2D(horizontal: 60, vertical: 80)
-  divide
   - rightAngledVector.divide(by: 10) should return PhysicsVector2D(horizontal: 10, vertical: -10)
-  distance
   - rightAngledVector.distance(with: horizontalVector) should return 100
-  normalize
   - angledVector.normalize() should return PhysicsVector2D(horizontal: 0.6, vertical: 0.8)
-  dotProduct
   - angledVector.dotProduct(vector: rightAngledVector) should return -100 
-  determinant
   - angledVector.determinant(vector: rightAngledVector) should return -700
-  angle
   - verticalVector.angle(with: horizontalVector) should return 90
-  reverse
   - verticalVector.reverse() should return PhysicsVector2D(horizontal: 0, vertical: -100)
   - angledVector.reverse() should return PhysicsVector2D(horizontal: -3, vertical: -4)

#### PhysicsBody

let testCentre = PhysicsVector2D(horizontal: 400, vertical: 400)
let newCentre = PhysicsVector2D(horizontal: 200, vertical: 200)

let staticBody = PhysicsBody(centre: testCentre, hSpeed: 0, vSpeed: 0, radius: 10, mass: 10, isFixed: false, elasticity: 1)
let movingBody = PhysicsBody(centre: testCentre, hSpeed: 30, vSpeed: 40, radius: 10, mass: 10, isFixed: false, elasticity: 1)
let fixedBody = PhysicsBody(centre: testCentre, hSpeed: 0, vSpeed: 0, radius: 10, mass: 10, isFixed: true, elasticity: 1)

- init
   - PhysicsBody(centre: testCentre, hSpeed: 0, vSpeed: 0, radius: 10, mass: 10, isFixed: false, elasticity: 1) should have the testAttribute = testCentre, hSpeed = PhysicsVector1D(magnitude: 0), vSpeed = PhysicsVector1D(magnitude: 0), radius: PhysicsVector1D(magnitude: 10), mass = 10.0, isFixed = false, elasticity = 1.0
 
-  velocity
   -  staticBody.velocity = PhysicsVector2D(horizontal: 0, vertical: 0)
   -  movingBody.velocity = PhysicsVector2D(horizontal: 30, vertical: 40)
-  moveTo
   -  staticBody.moveTo(centre: newCentre) should lead to staticBody.centre = newCentre
-  moveBy
   -  staticBody.moveBy(xDisplacement: PhysicsVector1D(magnitude: 20), yDisplacement: PhysicsVector1D(magnitude: 30)) should lead to staticBody.centre = PhysicsVector2D(horizontal: 420, vertical: 430)
-  addHorizontalSpeed
   -  movingBody.addHorizontalSpeed(by: PhysicsVector1D(magnitude: 20)) should lead to movingBody.hSpeed.magnitude = 50
   -  staticBody.addHorizontalSpeed(by: PhysicsVector1D(magnitude: -20)) should lead to movingBody.hSpeed.magnitude = -20
-  addVerticalSpeed
   -  movingBody.addVerticalSpeed(by: PhysicsVector1D(magnitude: 20)) should lead to movingBody.vSpeed.magnitude = 60
   -  staticBody.addVerticalSpeed(by: PhysicsVector1D(magnitude: -20)) should lead to movingBody.vSpeed.magnitude = -20
- removeHorizontalSpeed
   -  movingBody.removerHorizontalSpeed() should lead to movingBody.hSpeed.magnitude = 0
- removeVerticalSpeed
   -  movingBody.removerVerticalSpeed() should lead to movingBody.vSpeed.magnitude = 0
- addVelocity
   -  movingBody.addVelocity(PhysicsVector2D(horizontal: 50, vertical: 50)) should lead to movingBody.hSpeed.magnitude = 80 and movingBody.vSpeed.magnitude = 90
- applyGravity
   -  movingBody.applyGravity(force: PhysicsVector1D(magnitude: 10), for: 1) should lead to movignBody.vSpeed.magnitude = 50
   -  fixedBody.applyGravity(force: PhysicsVector1D(magnitude: 10), for: 1) should not change fixedBody vSpeed at all
- updatePosition
   -  staticBody.updatePosition(timeElapsed: 1) should not change its centre
   -  movingBody.updatePosittion(timeElapsed: 1) should lead to movingBody.centre = PhysicsVector2D(horizontal: 430, vertical: 440)
   -  fixedBody.updatePosittion(timeElapsed: 1) should not change its centre
- setDidCollide
   -  movingBody.setCollisionAction(collisionAction: () -> Print("Hi")) should cause movingBody to print "Hi" when it collided
- lockBodyInPlace
   -  movingBody.lockBodyInPlace() will cause movingBody.isFixed = true and movingBody should not move in gameplay
   -  fixedBody.lockBodyInPlace() will do nothing
-  unlockBodyInPlace
   -  movingBody.unlockBodyInPlace() will do nothing
   -  fixedBody.unlockBodyInPlace() will cause fixedBody.isFixed = false and it will start going down due to gravity
-  all isColliding methods
   -  Used for double dispatch check if method of its subclasse is called instead of itself
   
#### RoundBody
-  init
   - Same test as PhysicsBodies
 
-  isColliding(with body: Collidable)
   - check that argument called its correct isColliding method

-  isColliding(with body: RoundBody)
   - create a RoundBody 'A' with centre (100, 100) and radius 50, 'B' with centre (50, 50) and radius 50 and 'C' with centre (0, 0) and radius 30
   - 'A' should collide with 'B' but not 'C', 'B' Should collide with 'C'
   
#### PhysicsWorld
let boundaries = WorldBoundaries(ceiling: 1000, floor: 0, leftWall: 0, rightWall: 1000)
let entitiesSet set containing 3 PhysicsBodies
let gravity = PhysicsVector1D(magnitude: 10)
let wind = PhysicsVector1D(magnitude: 10)

let testWorld = PhysicsWorld(entities: entitiesSet, boundaries: boundaries, gravity: gravity, wind: wind)
let collisionResolver = CollisionResolverA(physicsWorld: testWorld)

-  init
   - init(entities: entitiesSet, boundaries: boundaries, gravity: gravity, wind: wind) should have all the properties initialised correctly with collisionResolver being nil
-  setCollisionResolver
   - testWorld.setCollisionResolver(use: collisionResolver) will assign testWorld the new collisionResolver
-  addEntity
   - when adding new entity, check that testWorld.entities.contains(newEntity) is true
   - when adding duplicate entity, check that testWorld.entities.count is unchanged
-  deleteEntity
   - when deleting an entity not in set, check that testWorld.entities.count is unchanged
   - when deleitn an entity in the set, check that testWorld.entities.contains(deletedEntity) is false
-  updateSelf
   - calling updateSelf will cause moving object to change its state and apply gravity to all of them
   - if there is no collision resolver, then object will be able to pass through each other.

#### BoundaryCollision
-  init
   -  Check that entity used as argument is initialized correctly

-  isColliding
   -  If entity is within Boundaries, return false
   -  If entity is outside Boundaries, return true
   
   Check accuracy and correctness of `resolve()` by play-testing
   
#### BodyCollision
-  init
   - Check that entity used as argument is initialized correctly
-  areColliding
   - Check that runtimeType of entityOne and entityTwo is `Collidable` 

   check accuracy and correctness of `resolve()` by play-testing
   
#### CollisionResolverA
-  init
   - Check that physicsWorld is assigned correctly.
   
   check accuracy and correctness of `resolveCollision()` by play-testing

### ZeggleEngine
#### ZeggleItem
-  init 
   - Check that all properties is assigned correctly, check isDead is false
   
-  triggerRemovalFlag
   - If removeFlag is true, do nothing
   - If removeFlas is false, set it to true

-  startDeletion
   - if undergoingDeletion is true, do nothing
   - if removeFlag is true, do nothing
   - if undergoingDeletion is false, set it to true

-  updatePosition
   - check physicsBody is updated
   - if isDead if true, do nothing
   - if undergoingDeletion is false, do nothing
   - if isDead != true, check that healthBar has decreased

#### Peg
-  init
   - Check that all properties is assigned correctly
 
#### Ball
-  init
   - Check that all properties is assigned correctly

-  stuckForTooLong
   - should always return false when not in gameplay
   - when in gameplay and stuck due to pegs, return true after some time
   - test for correctness in play-testing
-  readyForRemoval
   - return true if peg touches boundaries bottom
   - test for correctness in play-testing
-  updatePosition
   -  Checks that periodOfImmobility increase when stucked
   -  Checks that periodOfImmobility reset when moving with enough velocity
   
#### Level
-  init
   - Check that all properties is assigned correctly, check that itemRemover is not nil

-  rename
   - When rename is called and new name differ from previous name, name of level will change
   - When rename is called and new name is same as previous name, name of level will not change
   
-  setItemRemover
   - Check that itemRemover is not nil when calling init
   
-  changeGameMode
   - Check that conditionChecker assigned is of the correct type depending on the gameMode provided
   
-  setNumberOfBall
   - When amount to set is less than 1 do nothing
   - When amount to set is more than 0, change the numberOfStandardBalls to the amount specified
   
-  setNumberOfSpookyBall
   - Same as SetNumberOfBall but numberOfSpookyBalls is changed instead
   
-  setTarget
   - When called, change the target of the level to the specified number
   
-  switchBallType
   - When called, change the type of ball shot out of the cannon accordingly

-  shootCannon
   - If there is still a ball, do nothing
   - If there is no ball, check that after calling shootCannon the ball is no longer nil, items.count increase by one
   
-  removeBall
   - If there is no ball, do nothing
   - If there is a ball, check that ball is nil and items.count decrease by one
  
-  deleteItem
   - If items does not contains the item to be deleted, check items.count does not change
   - If item contains the item to be deleted, check items.count decrement by one and does not contains the deleted item

-  addItem
   - If items contains the item to add, check items.count does not change
   - If item does not contains the item to add, check items.count increment by one and contains the new item
   
-  updateSelf
   -  Check that all items are updated
   -  If there is no remover, the game should keep going on even if the ball touch the ground

#### StandardRemover

-  init
   - Check that all properties is assigned correctly, check that removableItems.count is zero
  
-  resolve
   - if level.ball is nil, do nothing
   - if conditionForRemoval is not met, do nothing
   - if level.ball is not nil and conditionForRemoval is met, check that removeFlag item in removableItems is true and all item that is dead is removed from removableItems
   - if level.ball is not dead, check that level.ball is not ni
   - if level.ball is dead, check that level.ball is nil
   
#### RhythmRemover

-  init
   - Check that all properties is assigned correctly, check that removableItems.count is zero
   
-  resolve
   - Similar to StandardRemover but item is removed sequentially instead of alltogether at once.
   - A sound is played when a peg is lit.

#### GameLoop
- init
   -  Check that level is initialised correctly and displayLink setting is correct

### Renderer
#### PegCreator

-  createPeg
   - pass in a `Peg` of color .blue
      - if peg.removeFlag is true, check it creates a glowing blue peg
      - if peg.removeFlas is false, check it creates a normal blue peg
   - pass in a peg of color .orange
      - if peg.removeFlag is true, check it creates a glowing orange peg
      - if peg.removeFlag is false, check it creates a normal orange peg
   - any `ZeggleItem` that is not `Peg` will produce an empty view
  
#### BallCreator

-  createBall
   - pass in a `Ball` and check that a ball view is created
   - any `ZeggleItem` that is not `Ball` will produce an empty view

#### GameItemCreator

-  createItemView
   - pass in a `Ball` and check it creates a ball view
   - pass in a `Peg` and check it createds a peg view
   - any other `ZeggleItem` will produce an empty view 
   
### Play Testing

#### Shoot Cannon
-  Tapping anywhere below the cannon will launch the ball and change cannon angle
   - Check that the ball leaves the cannon
-  If there is a ball in the screen, tapping anywhere below the cannon will just change the cannon angle
   - Check that the cannon angle is changed to point to the location touched
   - Check that no new ball is launched
-  Tapping anywhere above the cannon will do nothing

#### Gravity
-  Shoot the cannon almost fully horizontal and see if the ball gain downward velocity
-  or, check if ball gain downward velocity few seconds after collision

#### Boundary Collision
-  Shoot the cannon aiming at the wall
   - The launched ball will bounce when it touches the wall
   - Ensure that the ball does not stick to the wall

#### Peg Collision
-  Shoot the cannon at the pegs
   - Checked that the ball bounce off the pegs at a reasonable angle
   - Ensure that the peg remains in place after collision
   - Check that the peg is lit
   - Check that peg remains lit after repeated collision

#### Item Remover
-  Shoot the cannon at the pegs, ensuring to hit at least one peg
   - After the ball touches the ground, the ball will fade out of the screen
   - The lit peg will also fade out of the screen 
   
#### Handling Stuck Ball
-  Shoot the cannon in a location full of pegs
   - If the ball is stuck, after some time, all lit pegs will fade out of the screen
   - Ball should still remains in the screen until it hit the floor
   
#### Zombie Peg
-  Shoot the cannon into a zombie peg
   - Check that the zombie peg start moving by itself and can collide and light up other pegs,
   - When zombie peg hit other zombie peg, the other zombie peg will also become active
   - When zombie peg reach the bottom of the level, the zombie peg is removed
   
#### Spooky Ball
-  Shoot the cannon with the spooky ball equipped
   - The ball color should be purple
   - When the ball reach the ground, it will disappear and a new gray ball will appear at the top
-  Shoot until no more spooky balls
   - Cannon won't shoot if spooky balls is highlighted
   
#### Standard Ball
-  Shoot the cannon with the standard ball equipped
   - The ball color should be gray
   - When the ball reach the ground, it will disappear 
   - When the ball collide with a peg, the peg will light up
-  Shoot until no more standard balls.
   - Cannon won't shoot if standard balls is highlighted
   
#### StandardMode
-  Create a level with some pegs
   - When all the pegs in the screen is gone, check that an alert pop up showing the win screen
   - When all ammo is gone and there is still pegs in the screen, check that an alert pop up showing the lose screen
   - When all ammo is gone and there is no more peg, check that an alert pop up showing the lose screen
   
#### TimeAttack
-  Create a level with some pegs
   - Do the same check as StandardMode
   - When timer reached 0, check that an alert pop up showing the lose screen
   - When timer reached 0 and all peg has been hit but not removed, show the lose screen
   
#### BeatTheScore
-  Create a level with some pegs
   - Check that the target points is reachable
   - When timer reached 0, if the number of point is less than target, show the lose screen
   - If number of point is more than or equal target, show the win screen
   - If number of point is more than or equal target and timer reached 0, show the win screen

## Written Answers

### Reflecting on your Design
> Now that you have integrated the previous parts, comment on your architecture
> in problem sets 2 and 3. Here are some guiding questions:
> - do you think you have designed your code in the previous problem sets well
>   enough?

Not at all. Being thrusted into creating an entirely foreign app concept, its rather difficult to design the app to meet the problem set specifications while also making it highly extensible and scalable for the future problem set. I had the mindset of developing a standard CRUD app when developing the level designer, what matters is just creating the models and presenting the models with little care for how the models should interact. This is why I naturally gravitates to choosing a MV pattern in designing the app and I modeled my app to follow MVVM as I find the design most intuitive for the app. However I ignore the possibility of having to implement functionalities regarding interactions between models and the current PS2 design turns out to be rather restrictive in handling more extensive interactions.

Come PS3 and I realise that MV design is not appropriate to capture complex interactions between objects. Furthermore I had modelled the objects in a rather hierarchical structure which made them rather difficult to modify. This is not good in the context of making a video game as an object in a video game has more complicated and dynamic behaviour that may change depending on the state of the games whereas a hierarchical structure gives the object a concrete and hard to change behaviour. In the end despite my effort to decouple behaviours of objects I still have to refactor my code alot for PS4 and struggle to implement certain feature elegantly. 

By the end the app architecture was rather messy and does not even follow MVVM that thoroughly anymore to accomodate for more features. As of now its a mixture of MVVM and apple's MVC as I do not have the experience, skill or time to redesign the foundation of the app

Although the Physics Engine works alright for handling round objects, it still could not handle complex object with multiple sides. The formula and equation I used for the Physics Engine is not standard enough and in the end I spent multiple days refactoring and redesigning the physics engine yet i fail to make any design that is better than what I submit for PS4. This is a rather painful experience as I wasted too much time for no improvement, I could have used those time to implement other PS4 features.

> - is there any technical debt that you need to clean in this problem set?

The most prominent technical debt is the Physics Engine. The Physics Engine is arguably the most poorly designed component of the app. It is highly coupled with the model and the collision handling is poorly implemented. Without a total overhaul of the physics engine I will not be able to develop the game further.

Having learnt from my mistakes in designing the Physics Engine I developed the Audio Engine to not be coupled by the game engine at all. On the bright side I can use this Audio Engine for future project

> - if you were to redo the entire application, is there anything you would
>   have done differently?

Having read about ECS and a lot about game development while developing for PS3 and PS4 I would have designed my app to follow ECS instead of MVVM. ECS is more intuitive in designing video game as it follow the idea of separating codes into entity, components and system. This separation lead to high level of code reusability and flexibility, allowing more dynamic behaviour for object. "System" is also a more flexible way to implement interactions between object. While MV architecture is better in designing concrete behavaiour object. ECS is better for dynamic behaviour object

