//
//  MasterCollissionResolver.swift
//  Zeggle
//
//  Created by Zico on 8/2/23.
//

import Foundation
import CoreGraphics

// standard collision resolver
class CollisionResolverA: CollisionResolver {

    private unowned let physicsWorld: PhysicsWorld
    var collisionsToBeResolved: [Resolvable] = []
    var hasCollided = Set<PhysicsBody>()

    init(physicsWorld: PhysicsWorld) {
        self.physicsWorld = physicsWorld
    }

    private func simpleBodiesCollision(entityOne: PhysicsBody, entityTwo: PhysicsBody) {
        let collisionChecker = BodiesCollision(entityOne: entityOne, entityTwo: entityTwo)
        if collisionChecker.areColliding() {
            collisionsToBeResolved.append(collisionChecker)
            hasCollided.insert(entityOne)
            hasCollided.insert(entityTwo)
        }
    }

    func resolveCollision() {
        let boundaries = physicsWorld.boundaries

        for entityOne in physicsWorld.entities {

            for entityTwo in physicsWorld.entities where entityTwo != entityOne && !hasCollided.contains(entityTwo) {
                simpleBodiesCollision(entityOne: entityOne, entityTwo: entityTwo)
            }

            let boundaryCollisionChecker = BoundaryCollision(entity: entityOne, boundaries: boundaries)

            if boundaryCollisionChecker.isColliding() {
                collisionsToBeResolved.append(boundaryCollisionChecker)
            }
        }

        for collision in collisionsToBeResolved {
            collision.resolve()
        }

        collisionsToBeResolved = []
        hasCollided = Set<PhysicsBody>()
    }

    func isEntityColliding(entity: PhysicsBody) -> Bool {
        guard !physicsWorld.entities.contains(entity) else {
            return false
        }

        let boundaries = physicsWorld.boundaries

        let boundaryCollisionChecker = BoundaryCollision(entity: entity, boundaries: boundaries)

        if boundaryCollisionChecker.isColliding() {
            return true
        }

        for otherEntity in physicsWorld.entities {
            let collisionChecker = BodiesCollision(entityOne: entity, entityTwo: otherEntity)
            if collisionChecker.areColliding() {
                return true
            }
        }

        return false
    }
}
