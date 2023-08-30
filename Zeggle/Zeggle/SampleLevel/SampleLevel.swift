//
//  SampleLevel.swift
//  Zeggle
//
//  Created by Zico on 11/2/23.
//

import Foundation
import UIKit

class SampleLevel {

    static func createFilledLevelOne() -> Level {
        let level = Level(zeggleItems: [])

        var xStart = DimensionsConstants.leftWall + DimensionsConstants.rightWall * 0.1

        let xStep = DimensionsConstants.rightWall * 0.1

        var yStart = DimensionsConstants.tappableMinY + DimensionsConstants.tappableMaxY * 0.1

        let yStep = DimensionsConstants.tappableMaxY * 0.1

        for _ in (0..<8) {
            let newPeg = Peg(centre: PhysicsVector2D(horizontal: xStart, vertical: yStart),
                             radius: 25,
                             color: .blue)

            level.addItem(zeggleItem: newPeg)
            xStart += xStep
            yStart += yStep
        }

        level.rename(newName: "Level 1")

        return level
    }

    static func createColorfulLevel() -> Level {
        let pallete: [PegColor] = [.blue, .pink, .red, .yellow]

        let level = Level(zeggleItems: [])

        var xStart = DimensionsConstants.leftWall + DimensionsConstants.rightWall * 0.1

        let xStep = DimensionsConstants.rightWall * 0.1

        var yStart = DimensionsConstants.tappableMinY + DimensionsConstants.tappableMaxY * 0.1

        let yStep = DimensionsConstants.tappableMaxY * 0.1

        var pointer = 0

        for _ in (0..<8) {
            for _ in (0..<8) {
                let newPeg = Peg(centre: PhysicsVector2D(horizontal: xStart, vertical: yStart),
                                 radius: 25,
                                 color: pallete[pointer])
                level.addItem(zeggleItem: newPeg)
                xStart += xStep
                pointer += 1
                if pointer == 4 {
                    pointer = 0
                }
            }
            xStart = DimensionsConstants.leftWall + DimensionsConstants.rightWall * 0.1
            yStart += yStep
        }

        level.rename(newName: "Rock")

        return level

    }

    static func createZombieLevel() -> Level {
        let pallete: [PegColor] = [.blue, .pink, .red, .yellow]

        let level = Level(zeggleItems: [])

        var xStart = DimensionsConstants.leftWall + DimensionsConstants.rightWall * 0.1

        let xStep = DimensionsConstants.rightWall * 0.1

        var yStart = DimensionsConstants.tappableMinY + DimensionsConstants.tappableMaxY * 0.1

        let yStep = DimensionsConstants.tappableMaxY * 0.1

        var pointer = 0

        for _ in (0..<8) {
            for _ in (0..<8) {
                if pointer == 4 {
                    let newPeg = Peg(centre: PhysicsVector2D(horizontal: xStart, vertical: yStart),
                                     radius: 25,
                                     color: .zombie)
                    level.addItem(zeggleItem: newPeg)
                    pointer = 0
                    continue
                }
                let newPeg = Peg(centre: PhysicsVector2D(horizontal: xStart, vertical: yStart),
                                 radius: 25,
                                 color: pallete[pointer])
                level.addItem(zeggleItem: newPeg)
                xStart += xStep
                pointer += 1
                if pointer == 5 {
                    pointer = 0
                }
            }
            xStart = DimensionsConstants.leftWall + DimensionsConstants.rightWall * 0.1
            yStart += yStep
        }

        level.rename(newName: "Zombie")

        return level
    }

    static func createBlockAndBucketLevel() -> Level {
        let level = Level(zeggleItems: [])

        var xStart = DimensionsConstants.leftWall + DimensionsConstants.rightWall * 0.1

        let xStep = DimensionsConstants.rightWall * 0.1

        var yStart = DimensionsConstants.tappableMinY + DimensionsConstants.tappableMaxY * 0.1

        let yStep = DimensionsConstants.tappableMaxY * 0.1

        for _ in (0..<8) {
            let block = Block(centre: PhysicsVector2D(horizontal: xStart, vertical: yStart), height: 50)
            level.addItem(zeggleItem: block)
            xStart += xStep
            yStart += yStep
        }

        level.rename(newName: "Test block and bucket")
        level.createBucket()

        return level
    }

    static let emptyLevel =  {
        let level = Level(zeggleItems: [])
        level.rename(newName: "Empty")
        return level
    }()

    static let testBlock = {
        let level = Level(zeggleItems: [Block(centre: PhysicsVector2D(horizontal: 400, vertical: 800), height: 50)])
        level.rename(newName: "testBlock")
        return level
    }()

    static let testBucket: Level = {
        emptyLevel.createBucket()
        return emptyLevel
    }()

    static func generateSampleLevels() -> [Level] {

        let filledLevel = createFilledLevelOne()

        let filledLevel2 = createColorfulLevel()

        let zombieLevel = createZombieLevel()

        return [filledLevel, filledLevel2, zombieLevel]
    }
}
