//
//  CollisionResolver.swift
//  Zeggle
//
//  Created by Zico on 7/2/23.
//

import Foundation

protocol CollisionResolver: AnyObject {
    func resolveCollision()
    func isEntityColliding(entity: PhysicsBody) -> Bool
}
