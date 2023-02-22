//
//  EmptyBody.swift
//  Zeggle
//
//  Created by Zico on 21/2/23.
//

import CoreGraphics
import Foundation

class EmptyBody: PhysicsBody {

    init(centre: PhysicsVector2D, hSpeed: CGFloat, vSpeed: CGFloat,
         mass: Float, height: CGFloat, width: CGFloat, isFixed: Bool, elasticity: Float,
         collisionAction: @escaping () -> Void = {}) {

        super.init(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                   radius: 0, height: height, width: width,
                   mass: mass, isFixed: isFixed, elasticity: elasticity)
        self.disableCollision()
    }
}
