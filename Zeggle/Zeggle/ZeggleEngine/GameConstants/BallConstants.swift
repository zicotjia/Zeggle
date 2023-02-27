//
//  BallConstants.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//
import CoreGraphics

struct BallConstants {
    static let defaultIsFixed = false
    static let radius: CGFloat = 27 * DimensionsConstants.resolutionRatio
    static let defaultMass = Float(10.0)
    static let elasticity = Float(0.6)
    static let ballInitialVelocity = CGFloat(100)
    static let ballSpeedWhenSpawned = CGFloat(0)
    static let ballInitialPosition = PhysicsVector2D(
        horizontal: CannonConstants.xPos,
        vertical: CannonConstants.yPos)
    static let ballInitialXPosition = DimensionsConstants.horizontalCentrePosition
    static let ballInitialYPosition = 50
    static let VelocityStuckRange = (-5...5)
    static let timeToBeConsideredStuck: Int = 20
}
