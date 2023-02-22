//
//  SampleLevel.swift
//  Zeggle
//
//  Created by Zico on 11/2/23.
//

import Foundation

class SampleLevel {
    static let level = Level(zeggleItems: [Peg(centre: PhysicsVector2D(horizontal: 100, vertical: 300), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 400), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 500), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 600), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 700), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 100, vertical: 800), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 400, vertical: 300), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 300), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 300), color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 300), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 300), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 700, vertical: 300), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 400), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 500), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 600), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 700), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 700, vertical: 800), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 400, vertical: 400), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 400), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 400), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 350, vertical: 450), color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 450, vertical: 450), color: .orange),
                                           Block(centre: PhysicsVector2D(horizontal: 100, vertical: 800)),
                                           Block(centre: PhysicsVector2D(horizontal: 200, vertical: 800)),
                                           Block(centre: PhysicsVector2D(horizontal: 300, vertical: 800)),
                                           Block(centre: PhysicsVector2D(horizontal: 400, vertical: 800)),
                                           Block(centre: PhysicsVector2D(horizontal: 500, vertical: 800))
                                          ])

    static let emptyLevel = Level(zeggleItems: [])

    static let testBlock = Level(zeggleItems: [Block(centre: PhysicsVector2D(horizontal: 400, vertical: 800))])

    static let testBucket: Level = {
        emptyLevel.createBucket()
        return emptyLevel
    }()
}
