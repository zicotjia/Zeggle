//
//  Level.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import CoreGraphics

class Level {

    private var physicsWorld: PhysicsWorld<PhysicsBody>
    private var itemRemover: EventResolver?
    private(set) var items: Set<ZeggleItem>
    private(set) var ball: Ball?

    init(zeggleItems: Set<ZeggleItem>) {
        let levelBoundaries = WorldBoundaries(ceiling: DimensionsConstants.ceiling,
                                              floor: DimensionsConstants.floor,
                                              leftWall: DimensionsConstants.leftWall,
                                              rightWall: DimensionsConstants.rightWall)

        self.items = zeggleItems
        let physicsBodies = zeggleItems.map {$0.physicsBody}
        self.physicsWorld = PhysicsWorld(entities: Set(physicsBodies), boundaries: levelBoundaries,
                                       gravity: WorldConstants.defaultGravity, wind: PhysicsVector1D.nullVector)
        physicsWorld.setCollisionResolver(use: CollisionResolverA(physicsWorld: physicsWorld))
        self.setItemRemover(itemRemover: ItemRemoverA(level: self))
    }

    func setItemRemover(itemRemover: EventResolver) {
        self.itemRemover = itemRemover
    }

    func shootCannon(angle: Float) {
        guard ball == nil else {
            return
        }
        let totalSpeed = BallConstants.ballInitialVelocity
        let verticalSpeed = sin(CGFloat(angle) * Double.pi / 180) * totalSpeed
        let horizontalSpeed = cos(CGFloat(angle) * Double.pi / 180) * totalSpeed
        let newBall = Ball(centre: BallConstants.ballInitialPosition, hSpeed: horizontalSpeed, vSpeed: verticalSpeed)
        addItem(zeggleItem: newBall)
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

    func updateSelf(timeElapsed: Float) {
        for item in items {
            item.updatePosition(timeElapsed: timeElapsed)
        }
        physicsWorld.updateSelf(timeElapsed: timeElapsed)
        guard itemRemover != nil else {
            return
        }
        itemRemover?.resolve()
    }

}
