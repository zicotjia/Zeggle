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

    init(physicsWorld: PhysicsWorld<T>) {
        self.physicsWorld = physicsWorld
    }

    func resolveCollision() {
        var collisionsToBeResolved: [Resolvable] = []
        let boundaries = physicsWorld.boundaries

        var hasCollided = Set<T>()

        for entityOne in physicsWorld.entities {

            for entityTwo in physicsWorld.entities where entityTwo != entityOne && !hasCollided.contains(entityTwo) {

                let collisionChecker = BodiesCollision(entityOne: entityOne, entityTwo: entityTwo)

                if collisionChecker.areColliding() {
                    collisionsToBeResolved.append(collisionChecker)
                    hasCollided.insert(entityOne)
                    hasCollided.insert(entityTwo)
                }
            }

            let boundaryCollisionChecker = BoundaryCollision(entity: entityOne, boundaries: boundaries)

            if boundaryCollisionChecker.isColliding() {
                collisionsToBeResolved.append(boundaryCollisionChecker)
            }
        }

        for collision in collisionsToBeResolved {
            collision.resolve()
        }
    }
}
