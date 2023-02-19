//
//  BoundaryCollision.swift
//  Zeggle
//
//  Created by Zico on 7/2/23.
//

import Foundation
import CoreGraphics

class BoundaryCollision: Resolvable {
    private var entity: PhysicsBody
    private var boundaries: WorldBoundaries

    init(entity: PhysicsBody, boundaries: WorldBoundaries) {
        self.entity = entity
        self.boundaries = boundaries
    }

    func resolve() {
        if isCollidingWithWalls() {
            let horizontalSpeed = entity.hSpeed
            let newHorizontalSpeed = horizontalSpeed.multiplyMagnitude(by: -1)
            entity.removeHorizontalSpeed()
            entity.addHorizontalSpeed(by: newHorizontalSpeed)
            return
        }

        if isCollidingWithFloorOrCeiling() {
            let verticalSpeed = entity.vSpeed
            let newVerticalSpeed = verticalSpeed.multiplyMagnitude(by: -1)

            entity.removeVerticalSpeed()
            entity.addVerticalSpeed(by: newVerticalSpeed)
            return
        }
    }

    func isColliding() -> Bool {
        return isCollidingWithWalls() || isCollidingWithFloorOrCeiling()
    }

    private func isCollidingWithFloorOrCeiling() -> Bool {
        let highestPointOfEntity = entity.centre.vVector.substract(vector: entity.radius)
        let isCollidingWithCeiling = highestPointOfEntity.magnitude <= boundaries.ceiling

        let lowestPointOfEntity = entity.centre.vVector.add(vector: entity.radius)
        let isCollidingWithFloor = lowestPointOfEntity.magnitude >= boundaries.floor

        let isColliding = isCollidingWithFloor || isCollidingWithCeiling

        return isColliding
    }

    private func isCollidingWithWalls() -> Bool {
        let leftMostPointOfEntity = entity.centre.hVector.substract(vector: entity.radius)
        let isCollidingWithLeftWall = leftMostPointOfEntity.magnitude <= boundaries.leftWall
        let rightMostPointOfEntity = entity.centre.hVector.add(vector: entity.radius)
        let isCollidingWithRightWall = rightMostPointOfEntity.magnitude >= boundaries.rightWall

        let isColliding = isCollidingWithLeftWall || isCollidingWithRightWall

        return isColliding
    }
}
