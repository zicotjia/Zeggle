//
//  PhysicsWorld.swift
//  Zeggle
//
//  Created by Zico on 5/2/23.
//

import Foundation
import CoreGraphics

class PhysicsWorld {
    private(set) var entities: Set<PhysicsBody>
    private(set) var boundaries: WorldBoundaries
    private var collisionResolver: (any CollisionResolver)?
    private(set) var gravity: PhysicsVector1D
    // although wind is not part of the required specification i add it for future feature
    private(set) var wind: PhysicsVector1D

    init(entities: Set<PhysicsBody>, boundaries: WorldBoundaries, gravity: PhysicsVector1D, wind: PhysicsVector1D) {
        self.entities = entities
        self.boundaries = boundaries
        self.gravity = gravity
        self.wind = wind
    }

    func setCollisionResolver(use resolver: any CollisionResolver) {
        collisionResolver = resolver
    }

    func addEntity(entity: PhysicsBody) {
        guard !entities.contains(entity) else {
            return
        }
        entities.insert(entity)
    }

    func deleteEntity(entity: PhysicsBody) {
        guard entities.contains(entity) else {
            return
        }

        entities.remove(entity)
    }

    func entityIsColliding(entity: PhysicsBody) -> Bool {
        guard let isColliding = collisionResolver?.isEntityColliding(entity: entity) else {
            return false
        }
        return isColliding
    }

    func reset() {
        entities = []
    }

    func updateSelf(timeElapsed: Float) {
        for entity in entities {
            entity.applyGravity(force: gravity, for: timeElapsed)
            entity.updatePosition(timeElapsed: timeElapsed)
        }
        guard collisionResolver != nil else {
            return
        }
        collisionResolver?.resolveCollision()
    }
}
