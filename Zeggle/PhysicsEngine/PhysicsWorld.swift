//
//  PhysicsWorld.swift
//  Zeggle
//
//  Created by Zico on 5/2/23.
//

import Foundation
import CoreGraphics

class PhysicsWorld<T: PhysicsBody> {
    private(set) var entities: Set<T>
    private(set) var boundaries: WorldBoundaries
    private var collisionResolver: CollisionResolver?
    private(set) var gravity: PhysicsVector1D
    // although wind is not part of the required specification i add it for future feature
    private(set) var wind: PhysicsVector1D

    init(entities: Set<T>, boundaries: WorldBoundaries, gravity: PhysicsVector1D, wind: PhysicsVector1D) {
        self.entities = entities
        self.boundaries = boundaries
        self.gravity = gravity
        self.wind = wind
    }

    func setCollisionResolver(use resolver: CollisionResolver) {
        collisionResolver = resolver
    }

    func addEntity(entity: T) {
        guard !entities.contains(entity) else {
            return
        }
        entities.insert(entity)
    }

    func deleteEntity(entity: T) {
        guard entities.contains(entity) else {
            return
        }

        entities.remove(entity)
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
