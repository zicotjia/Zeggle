//
//  SampleLevel.swift
//  Zeggle
//
//  Created by Zico on 11/2/23.
//

import Foundation

class SampleLevel {
    static let level = Level(zeggleItems: [Peg(centre: PhysicsVector2D(horizontal: 100, vertical: 300),
                                               radius: 20, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 400),
                                               radius: 30, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 500),
                                               radius: 20, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 600),
                                               radius: 30, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 700),
                                               radius: 40, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 100, vertical: 800),
                                               radius: 20, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 400, vertical: 300),
                                               radius: 30, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 300),
                                               radius: 40, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 300),
                                               radius: 20, color: .blue),
                                           Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 300),
                                               radius: 10, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 300),
                                               radius: 40, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 700, vertical: 300),
                                               radius: 30, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 400),
                                               radius: 20, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 500),
                                               radius: 10, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 600),
                                               radius: 10, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 700),
                                               radius: 20, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 700, vertical: 800),
                                               radius: 30, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 400, vertical: 400),
                                               radius: 30, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 400),
                                               radius: 20, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 400),
                                               radius: 10, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 350, vertical: 450),
                                               radius: 30, color: .orange),
                                           Peg(centre: PhysicsVector2D(horizontal: 450, vertical: 450),
                                               radius: 20, color: .orange)
                                          ])

    static let emptyLevel =  {
        let level = Level(zeggleItems: [])
        level.rename(newName: "Empty")
        return level
    }()

    static let testBlock = {
        let level = Level(zeggleItems: [Block(centre: PhysicsVector2D(horizontal: 400, vertical: 800))])
        level.rename(newName: "testBlock")
        return level
    }()

    static let testBucket: Level = {
        emptyLevel.createBucket()
        return emptyLevel
    }()

    static func generateSampleLevels() -> [Level] {
        let filledLevel = Level(zeggleItems: [Peg(centre: PhysicsVector2D(horizontal: 100, vertical: 300),
                                                  radius: 20, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 400),
                                                  radius: 30, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 500),
                                                  radius: 20, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 600),
                                                  radius: 30, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 700),
                                                  radius: 40, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 100, vertical: 800),
                                                  radius: 20, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 400, vertical: 300),
                                                  radius: 30, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 300),
                                                  radius: 40, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 300),
                                                  radius: 20, color: .blue),
                                              Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 300),
                                                  radius: 10, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 300),
                                                  radius: 40, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 700, vertical: 300),
                                                  radius: 30, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 400),
                                                  radius: 20, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 500),
                                                  radius: 10, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 600),
                                                  radius: 10, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 600, vertical: 700),
                                                  radius: 20, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 700, vertical: 800),
                                                  radius: 30, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 400, vertical: 400),
                                                  radius: 30, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 500, vertical: 400),
                                                  radius: 20, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 400),
                                                  radius: 10, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 350, vertical: 450),
                                                  radius: 30, color: .orange),
                                              Peg(centre: PhysicsVector2D(horizontal: 450, vertical: 450),
                                                  radius: 20, color: .zombie)
                                             ])
        filledLevel.rename(newName: "Sample 1")

        let filledLevel2 = Level(zeggleItems: [Peg(centre: PhysicsVector2D(horizontal: 300, vertical: 400),
                                           radius: 10, color: .orange),
                                       Peg(centre: PhysicsVector2D(horizontal: 350, vertical: 450),
                                           radius: 30, color: .orange),
                                       Peg(centre: PhysicsVector2D(horizontal: 450, vertical: 450),
                                           radius: 20, color: .orange)])
        filledLevel2.rename(newName: "Sample 2")

        let emptyLevel = Level(zeggleItems: [])
        emptyLevel.rename(newName: "emptyLevel")

        let testBlock = Level(zeggleItems: [Block(centre: PhysicsVector2D(horizontal: 400, vertical: 800))])
        testBlock.rename(newName: "testBlock")

        return [filledLevel, filledLevel2, emptyLevel, testBlock]
    }
}
