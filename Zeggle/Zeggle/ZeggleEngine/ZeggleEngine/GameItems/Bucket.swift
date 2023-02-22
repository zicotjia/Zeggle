//
//  Bucket.swift
//  Zeggle
//
//  Created by Zico on 21/2/23.
//

class Bucket: ComplexItem {

    override init(centre: PhysicsVector2D) {
        super.init(centre: centre)

        guard let body = physicsBody as? RectangleBody else {
            return
        }

        body.top.disableCollision()
        physicsBody = body
    }
}
