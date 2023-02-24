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
    private var itemRemover: EventResolver?
    private var scoreCalculator: EventResolver?
    private(set) var gameMode: ConditionChecker?
    var timer: Float
    private(set) var numberOfBalls: Int
    private(set) var items: Set<ZeggleItem>
    private(set) var ball: Ball?
    private(set) var bucket: Bucket?
    private(set) var winFlag = false
    private(set) var loseFlag = false
    var score = 0
    private(set) var target = 0

    init(name: String = "untitled", zeggleItems: Set<ZeggleItem>) {
        self.name = name
        let levelBoundaries = WorldBoundaries(ceiling: DimensionsConstants.ceiling,
                                              floor: DimensionsConstants.floor,
                                              leftWall: DimensionsConstants.leftWall,
                                              rightWall: DimensionsConstants.rightWall)

        self.items = zeggleItems
        self.numberOfBalls = 5
        let physicsBodies = zeggleItems.map {$0.physicsBody}
        self.physicsWorld = PhysicsWorld(entities: Set(physicsBodies), boundaries: levelBoundaries,
                                       gravity: WorldConstants.defaultGravity, wind: PhysicsVector1D.nullVector)
        physicsWorld.setCollisionResolver(use: CollisionResolverA(physicsWorld: physicsWorld))
        self.timer = WorldConstants.defaultTimer
        self.setItemRemover(itemRemover: ItemRemoverA(level: self))
        self.setScoreCalculator(calculator: StandardCalculator(level: self))
        self.changeGameMode(gameMode: .standard)
    }

    func rename(newName: String) {
        name = newName
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

    func setItemRemover(itemRemover: EventResolver) {
        self.itemRemover = itemRemover
    }

    func setScoreCalculator(calculator: EventResolver) {
        self.scoreCalculator = calculator
    }

    func setNumberOfBall(to amount: Int) {
        numberOfBalls = amount
    }

    func setTarget(to amount: Int) {
        target = amount
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
        guard ball == nil && numberOfBalls != 0 else {
            return
        }
        let totalSpeed = BallConstants.ballInitialVelocity
        let verticalSpeed = sin(CGFloat(angle) * Double.pi / 180) * totalSpeed
        let horizontalSpeed = cos(CGFloat(angle) * Double.pi / 180) * totalSpeed
        let newBall = Ball(centre: BallConstants.ballInitialPosition, hSpeed: horizontalSpeed, vSpeed: verticalSpeed)
        addItem(zeggleItem: newBall)
        numberOfBalls -= 1
        ball = newBall
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

        guard scoreCalculator != nil else {
            return
        }
        scoreCalculator?.resolve()

        guard itemRemover != nil else {
            return
        }
        itemRemover?.resolve()

        guard gameMode?.checkCondition() != nil else {
            return
        }
        gameMode?.checkCondition()
    }

    static func == (lhs: Level, rhs: Level) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

}
