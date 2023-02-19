//
//  WorldBoundaries.swift
//  Zeggle
//
//  Created by Zico on 7/2/23.
//

import CoreGraphics

struct WorldBoundaries {
    private(set) var ceiling: CGFloat
    private(set) var floor: CGFloat
    private(set) var leftWall: CGFloat
    private(set) var rightWall: CGFloat

    init(ceiling: CGFloat, floor: CGFloat, leftWall: CGFloat, rightWall: CGFloat) {
        self.ceiling = ceiling
        self.floor = floor
        self.leftWall = leftWall
        self.rightWall = rightWall
    }
}
