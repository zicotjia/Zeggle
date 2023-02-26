//
//  GameItemFactory.swift
//  Zeggle
//
//  Created by Zico on 25/2/23.
//

import CoreGraphics

class GameItemFactory {

    static func createItem(itemType: ItemType, centre: CGPoint, radius: CGFloat) -> ZeggleItem {
        switch itemType {
        case .orangePeg:
            return Peg(centre: PhysicsVector2D(centre: centre), radius: radius, color: .orange)
        case .bluePeg:
            return Peg(centre: PhysicsVector2D(centre: centre), radius: radius, color: .blue)
        case .zombiePeg:
            return Peg(centre: PhysicsVector2D(centre: centre), radius: radius, color: .zombie)
        case .redPeg:
            return Peg(centre: PhysicsVector2D(centre: centre), radius: radius, color: .red)
        case .yellowPeg:
            return Peg(centre: PhysicsVector2D(centre: centre), radius: radius, color: .yellow)
        case .pinkPeg:
            return Peg(centre: PhysicsVector2D(centre: centre), radius: radius, color: .pink)
        }
    }
}
