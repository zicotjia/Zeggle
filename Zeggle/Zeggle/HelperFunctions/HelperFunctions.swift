//
//  HelperFunctions.swift
//  Zeggle
//
//  Created by Zico on 12/2/23.
//
import CoreGraphics

class HelperFunctions {
    static func getLaunchAngle(location: CGPoint) -> Float? {
        let tapVector = PhysicsVector2D(horizontal: location.x, vertical: location.y)
        let cannonPos = PhysicsVector2D(horizontal: CannonConstants.xPos, vertical: CannonConstants.yPos)
        let tapToCannonVector = tapVector.substract(vector: cannonPos)
        let horizontalVector = PhysicsVector2D(horizontal: 1, vertical: 0)
        let newAngle = horizontalVector.angle(with: tapToCannonVector)
        guard newAngle < 0 else {
            return nil
        }
        return newAngle
    }
}
