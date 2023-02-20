//
//  BodiesCollision.swift
//  Zeggle
//
//  Created by Zico on 8/2/23.
//

import Foundation
import CoreGraphics

class BodiesCollision: Resolvable {
    private var entityOne: PhysicsBody
    private var entityTwo: PhysicsBody

    init(entityOne: PhysicsBody, entityTwo: PhysicsBody) {
        self.entityOne = entityOne
        self.entityTwo = entityTwo
    }

    func resolve() {

        entityTwo.collisionAction()
        entityOne.collisionAction()
        applyVelocityChanges()
    }

    func areColliding() -> Bool {

        // upcast to trigger dynamic dispatch for double dispatch
        let collidableOne: Collidable = entityOne
        let collidableTwo: Collidable = entityTwo
        return collidableOne.isColliding(with: collidableTwo)
    }

    private func findNormal() -> PhysicsVector2D? {
        let entityOneCentre = entityOne.centre
        let entityTwoCentre = entityTwo.centre

        if let line = entityOne as? LineBody {
            return line.normal
        }

        if let line = entityTwo as? LineBody {
            return line.normal
        }

        if let rect = entityOne as? RectangleBody {
            guard let line = rect.getSideThatCollide(with: entityTwo) else {
                return nil
            }
            return line.normal
        }

        if let rect = entityTwo as? RectangleBody {
            guard let line = rect.getSideThatCollide(with: entityOne) else {
                return nil
            }
            return line.normal
        }

        let differenceVector = entityOneCentre.substract(vector: entityTwoCentre)
        return differenceVector.normalize()
    }

    private func applyVelocityChanges() {
        let minElasticity: Float = min(entityOne.elasticity, entityTwo.elasticity)
        let relativeVelocity = entityTwo.velocity.substract(vector: entityOne.velocity)

        guard let normal = findNormal() else {
            return
        }

        let velocityAlongNormal = relativeVelocity.dotProduct(vector: normal)
        let inverseOfMassOne = 1.0 / entityOne.mass
        let inverseOfMassTwo = 1.0 / entityTwo.mass

        var scalarImpulse = -(1.0 + minElasticity) * velocityAlongNormal
        scalarImpulse /= (inverseOfMassOne + inverseOfMassTwo)

        let impulse = normal.multiply(by: CGFloat(scalarImpulse))

        if !entityOne.isFixed {
            immediatelyDisplaceCollidingItem(entity: entityOne)
            let velocityChange = impulse.multiply(by: 1 / CGFloat((entityOne.mass * -1)))
            entityOne.addVelocity(with: velocityChange)
        }

        if !entityTwo.isFixed {
            immediatelyDisplaceCollidingItem(entity: entityTwo)
            let velocityChange = impulse.multiply(by: 1 / CGFloat((entityTwo.mass)))
            entityTwo.addVelocity(with: velocityChange)
        }

    }

    // quick fix for when bodies are stuck into each other due to overlap, to fix move back bodies to a previous state.
    private func immediatelyDisplaceCollidingItem(entity: PhysicsBody) {
        entity.updatePosition(timeElapsed: -0.15)
    }
}
