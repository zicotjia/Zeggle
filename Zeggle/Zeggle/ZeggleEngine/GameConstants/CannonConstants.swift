//
//  CannonConstants.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//
import CoreGraphics

struct CannonConstants {
    static let xPos: CGFloat = DimensionsConstants.horizontalCentrePosition
    static let yPos: CGFloat = DimensionsConstants.deviceHeight * 0.06
    static let height: CGFloat = 120 * DimensionsConstants.resolutionRatio
    static let width: CGFloat = 120 * DimensionsConstants.resolutionRatio
    static let positionVector = PhysicsVector2D(horizontal: xPos, vertical: yPos)
}
