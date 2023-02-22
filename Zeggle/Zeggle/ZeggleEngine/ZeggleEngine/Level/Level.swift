//
//  Level.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import CoreGraphics

class Level {

    private(set) var name: String
    private var physicsWorld: PhysicsWorld<PhysicsBody>
    private var itemRemover: EventResolver?
    private var gameMode: ConditionChecker?
    private(set) var timer: Int?
    private(set) var numberOfBalls: Int
    private(set) var items: Set<ZeggleItem>
    private(set) var ball: Ball?
    private(set) var bucket: Bucket?
    private(set) var winFlag = false
    private(set) var loseFlag = false

    init(name: String = "untitled", zeggleItems: Set<ZeggleItem>) {
        self.name = name
        let levelBoundaries = WorldBoundaries(ceiling: DimensionsConstants.ceiling,
                                              floor: DimensionsConstants.floor,
                                              leftWall: DimensionsConstants.leftWall,
                                              rightWall: DimensionsConstants.rightWall)

        self.items = zeggleItems
        self.numberOfBalls = 1
        let physicsBodies = zeggleItems.map {$0.physicsBody}
        self.physicsWorld = PhysicsWorld(entities: Set(physicsBodies), boundaries: levelBoundaries,
                                       gravity: WorldConstants.defaultGravity, wind: PhysicsVector1D.nullVector)
        physicsWorld.setCollisionResolver(use: CollisionResolverA(physicsWorld: physicsWorld))
        self.setItemRemover(itemRemover: ItemRemoverA(level: self))
        self.setGameMode(conditionChecker: StandardMode(level: self))
    }

    func setGameMode(conditionChecker: ConditionChecker) {
        self.gameMode = conditionChecker
    }

    func setItemRemover(itemRemover: EventResolver) {
        self.itemRemover = itemRemover
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
        guard !items.contains(zeggleItem) else {
            return
        }
        items.insert(zeggleItem)
        physicsWorld.addEntity(entity: zeggleItem.physicsBody)
    }

    func triggerWin() {
        winFlag = true
    }

    func triggerLose() {
        loseFlag = true
    }

    func updateSelf(timeElapsed: Float) {
        for item in items {
            item.updatePosition(timeElapsed: timeElapsed)
        }
        physicsWorld.updateSelf(timeElapsed: timeElapsed)
        guard itemRemover != nil else {
            return
        }
        itemRemover?.resolve()

        guard gameMode?.checkCondition() != nil else {
            return
        }
        gameMode?.checkCondition()
    }

}
