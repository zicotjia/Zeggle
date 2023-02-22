//
//  ComplexItem.swift
//  Zeggle
//
//  Created by Zico on 21/2/23.
//

class ComplexItem: ZeggleItem {

    private(set) var sides: [LineBody]

    init(centre: PhysicsVector2D) {
        sides = []
        super.init(centre: centre, hSpeed: 0, vSpeed: 0,
                   radius: 0, height: 200, width: 200,
                   mass: 1000, isFixed: true, elasticity: BlockConstants.defaultElasticity,
                   shape: .rectangle)
    }

    func addSide(side: LineBody) {
        sides.append(side)
    }
}
