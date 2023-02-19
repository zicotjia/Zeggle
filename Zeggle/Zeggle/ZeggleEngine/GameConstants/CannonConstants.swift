//
//  CannonConstants.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//
import CoreGraphics

struct CannonConstants {
    static let xPos: CGFloat = DimensionsConstants.horizontalCentrePosition
    static let yPos: CGFloat = 50
    static let height: CGFloat = 150
    static let width: CGFloat = 150
    static let positionVector = PhysicsVector2D(horizontal: xPos, vertical: yPos)
}
