//
//  Level.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import CoreGraphics

class Level: Hashable {

    private(set) var name: String
    private var physicsWorld: PhysicsWorld
    private(set) var itemRemover: ObjectRemover?
    private(set) var gameMode: ConditionChecker?
    private(set) var isMusical = false
    var timer: Float
    var timerLock = false
    private(set) var numberOfStandardBalls: Int = 5
    private(set) var numberOfSpookyBalls: Int = 5
    private(set) var items: Set<ZeggleItem>
    private(set) var ball: Ball?
    private(set) var ballType: BallType = .standard
    private(set) var bucket: Bucket?
    private(set) var winFlag = false
    private(set) var loseFlag = false
    var score = 0
    private(set) var target = 0

    var numberOfBalls: Int {
        numberOfSpookyBalls + numberOfStandardBalls
    }

    init(name: String = "", zeggleItems: Set<ZeggleItem>) {
        self.name = name
        let levelBoundaries = WorldBoundaries(ceiling: DimensionsConstants.ceiling,
                                              floor: DimensionsConstants.floor,
                                              leftWall: DimensionsConstants.leftWall,
                                              rightWall: DimensionsConstants.rightWall)

        self.items = zeggleItems
        let physicsBodies = zeggleItems.map {$0.physicsBody}
        self.physicsWorld = PhysicsWorld(entities: Set(physicsBodies), boundaries: levelBoundaries,
                                       gravity: WorldConstants.defaultGravity, wind: PhysicsVector1D.nullVector)
        physicsWorld.setCollisionResolver(use: CollisionResolverA(physicsWorld: physicsWorld))
        self.timer = WorldConstants.defaultTimer
        self.setItemRemover(itemRemover: StandardRemover(level: self))
        self.changeGameMode(gameMode: .standard)
    }

    func rename(newName: String) {
        name = newName
    }

    func toggleMusicOn() {
        self.isMusical = true
        self.setItemRemover(itemRemover: RhythmRemover(level: self))
    }

    func toggleMusicOff() {
        self.isMusical = false
        self.setItemRemover(itemRemover: StandardRemover(level: self))
    }

    func changeGameMode(gameMode: GameMode) {
        switch gameMode {
        case .standard:
            setGameMode(conditionChecker: StandardMode(level: self))
        case .timeAttack:
            setGameMode(conditionChecker: TimeAttack(level: self))
        case .beatTheScore:
            setGameMode(conditionChecker: BeatTheScore(level: self))
        case .dodgeBall:
            setGameMode(conditionChecker: DodgeBall(level: self))
        }
    }

    func setGameMode(conditionChecker: ConditionChecker) {
        self.gameMode = conditionChecker
    }

    func setItemRemover(itemRemover: ObjectRemover) {
        self.itemRemover = itemRemover
    }

    func setNumberOfBall(to amount: Int) {
        numberOfStandardBalls = amount
    }

    func setNumberOfSpookyBall(to amount: Int) {
        numberOfSpookyBalls = amount
    }

    func setTarget(to amount: Int) {
        target = amount
    }

    func switchBallType(to type: BallType) {
        ballType = type
    }

    func createBucket() {
        guard bucket == nil else {
            return
        }
        let newBucket = Bucket(centre: PhysicsVector2D(horizontal: 400, vertical: 800))
        addItem(zeggleItem: newBucket)
        bucket = newBucket
    }

    func shootCannon(angle: Float) {
        guard ball == nil else {
            return
        }

        let totalSpeed = BallConstants.ballInitialVelocity
        let verticalSpeed = sin(CGFloat(angle) * Double.pi / 180) * totalSpeed
        let horizontalSpeed = cos(CGFloat(angle) * Double.pi / 180) * totalSpeed
        if ballType == .standard {
            guard numberOfStandardBalls > 0 else {
                return
            }
            let newBall = Ball(centre: BallConstants.ballInitialPosition, hSpeed: horizontalSpeed,
                               vSpeed: verticalSpeed, type: ballType)
            addItem(zeggleItem: newBall)
            numberOfStandardBalls -= 1
            ball = newBall
        }
        if ballType == .spooky {
            guard numberOfSpookyBalls > 0 else {
                return
            }
            let newBall = Ball(centre: BallConstants.ballInitialPosition, hSpeed: horizontalSpeed,
                               vSpeed: verticalSpeed, type: ballType)
            addItem(zeggleItem: newBall)
            numberOfSpookyBalls -= 1
            ball = newBall
        }

    }

    func removeBall() {
        guard let currentBall = ball else {
            return
        }
        physicsWorld.deleteEntity(entity: currentBall.physicsBody)
        ball = nil
        deleteItem(zeggleItem: currentBall)
    }

    func deleteItem(zeggleItem: ZeggleItem) {
        guard items.contains(zeggleItem) else {
            return
        }
        items.remove(zeggleItem)
        physicsWorld.deleteEntity(entity: zeggleItem.physicsBody)
    }

    func addItem(zeggleItem: ZeggleItem) {
        guard zeggleItem is Ball || !items.contains(zeggleItem) &&
                !physicsWorld.entityIsColliding(entity: zeggleItem.physicsBody) else {
            return
        }
        items.insert(zeggleItem)
        physicsWorld.addEntity(entity: zeggleItem.physicsBody)
    }

    func reset() {
        items = []
        score = 0
        physicsWorld.reset()
    }

    func triggerWin() {
        winFlag = true
    }

    func triggerLose() {
        loseFlag = true
    }

    func getMaximumPoints() -> Int {
        var count = 0
        for item in items {
            count += item.point
        }
        return count
    }

    func setTimer(time: Int) {
        timer = Float(time)
    }

    func updateSelf(timeElapsed: Float) {
        for item in items {
            item.updatePosition(timeElapsed: timeElapsed)
        }
        physicsWorld.updateSelf(timeElapsed: timeElapsed)

        guard let itemRemover = itemRemover else {
            return
        }

        itemRemover.resolve()

        guard gameMode?.checkCondition() != nil else {
            return
        }
        gameMode?.checkCondition()
    }

    func lockTime() {
        timerLock = true
    }

    func unlockTime() {
        timerLock = false
    }

    static func == (lhs: Level, rhs: Level) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

}
