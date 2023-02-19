//
//  Collidable.swift
//  Zeggle
//
//  Created by Zico on 12/2/23.
//

protocol Collidable {

    func isColliding(with body: Collidable) -> Bool

    func isColliding(with body: PhysicsBody) -> Bool

    func isColliding(with body: RoundBody) -> Bool
}
