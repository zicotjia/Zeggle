//
//  Line.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//
import Foundation

class Line: ZeggleItem {

    init(collisionAction: @escaping () -> Void = {}) {

        super.init(centre: PhysicsVector2D(centre: CGPoint(x: 800, y: 800)), hSpeed: PegConstants.initialHorizontalSpeed,
                   vSpeed: PegConstants.initialVerticalSpeed, radius: PegConstants.radius,
                   height: 100, width: 100, mass: PegConstants.defaultMass, isFixed: true,
                   elasticity: PegConstants.defaultElasticity, shape: .line)

    }

}
