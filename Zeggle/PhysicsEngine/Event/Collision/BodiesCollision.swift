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
        guard !entityOne.isFixed || !entityTwo.isFixed else {
            return
        }

        guard let normal = findNormal() else {
            return
        }

        guard let depth = findDepth() else {
            return
        }

        let direction = entityOne.centre.substract(vector: entityTwo.centre).normalize()

        // resolvePosition(direction: direction, depth: depth)
        applyVelocityChanges(normal: normal)

        entityTwo.collisionAction()
        entityOne.collisionAction()
    }

    func areColliding() -> Bool {

        // upcast to trigger dynamic dispatch for double dispatch
        let collidableOne: Collidable = entityOne
        let collidableTwo: Collidable = entityTwo
        return collidableOne.isColliding(with: collidableTwo)
    }

    private func applyDiplacement(entityOneDisplacement: PhysicsVector2D, entityTwoDisplacement: PhysicsVector2D) {
        let entityOneCentre = entityOne.centre
        let entityTwoCentre = entityTwo.centre
        let finalEntityOnePosition = entityOneCentre.add(vector: entityOneDisplacement)
        let finalEntityTwoPosition = entityTwoCentre.add(vector: entityTwoDisplacement)

        let totalRadius = entityOne.radius.substract(vector: entityTwo.radius)

        guard finalEntityOnePosition.distance(with: finalEntityTwoPosition) >= totalRadius.magnitude else {
            entityOne.moveBy(diplacement: entityOneDisplacement.reverse())
            entityTwo.moveBy(diplacement: entityTwoDisplacement.reverse())
            return
        }
        entityOne.moveBy(diplacement: entityOneDisplacement)
        entityTwo.moveBy(diplacement: entityTwoDisplacement)
    }

    private func resolvePosition(direction: PhysicsVector2D, depth: CGFloat) {
        guard !entityOne.isFixed || entityTwo.isFixed else {
            return
        }

        let movingDistance = direction.multiply(by: depth * 1.0)
        let noMovement = PhysicsVector2D(horizontal: 0, vertical: 0)

        guard !entityOne.isFixed else {
            applyDiplacement(entityOneDisplacement: noMovement, entityTwoDisplacement: movingDistance)
            return
        }

        guard !entityTwo.isFixed else {
            applyDiplacement(entityOneDisplacement: movingDistance, entityTwoDisplacement: noMovement)
            return
        }

        let halfMovingDistance = movingDistance.divide(by: 1.5)
        applyDiplacement(entityOneDisplacement: halfMovingDistance, entityTwoDisplacement: halfMovingDistance.reverse())
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

    private func findDepth() -> CGFloat? {
        let entityOneCentre = entityOne.centre
        let entityTwoCentre = entityTwo.centre

        if let line = entityOne as? LineBody {
            return line.distance(to: entityTwoCentre)
        }

        if let line = entityTwo as? LineBody {
            return line.distance(to: entityOneCentre)
        }

        if let rect = entityOne as? RectangleBody {
            guard let line = rect.getSideThatCollide(with: entityTwo) else {
                return nil
            }
            return line.distance(to: entityTwoCentre)
        }

        if let rect = entityTwo as? RectangleBody {
            guard let line = rect.getSideThatCollide(with: entityOne) else {
                return nil
            }
            return line.distance(to: entityOneCentre)
        }

        let distance = entityOneCentre.distance(with: entityTwoCentre)
        let totalRadius = entityOne.radius.add(vector: entityTwo.radius)
        return totalRadius.magnitude - distance
    }

    private func applyVelocityChanges(normal: PhysicsVector2D) {
        let minElasticity: Float = min(entityOne.elasticity, entityTwo.elasticity)
        let relativeVelocity = entityTwo.velocity.substract(vector: entityOne.velocity)

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
