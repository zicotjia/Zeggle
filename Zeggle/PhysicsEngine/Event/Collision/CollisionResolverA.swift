//
//  MasterCollissionResolver.swift
//  Zeggle
//
//  Created by Zico on 8/2/23.
//

import Foundation
import CoreGraphics

// standard collision resolver
class CollisionResolverA<T: PhysicsBody>: CollisionResolver {
    private unowned let physicsWorld: PhysicsWorld<T>
    var collisionsToBeResolved: [Resolvable] = []
    var hasCollided = Set<T>()

    init(physicsWorld: PhysicsWorld<T>) {
        self.physicsWorld = physicsWorld
    }

    private func simpleBodiesCollision(entityOne: T, entityTwo: T) {
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
        hasCollided = Set<T>()
    }
}
