//
//  GameLoop.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import Foundation
import QuartzCore

class GameLoop: ObservableObject {
    @Published var time = Float(1.0)
    @Published private(set) var level: Level
    var displayLink: CADisplayLink!

    init(level: Level) {
        self.level = level
        createDisplayLink()
    }

    private func createDisplayLink() {
        guard displayLink == nil else {
            return
        }

        displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .current, forMode: RunLoop.Mode.default)
    }

    func shootCannon(angle: Float) {
        level.shootCannon(angle: angle)
    }

    @objc func step(displaylink: CADisplayLink) {
        time += Float(1.0)
        level.updateSelf(timeElapsed: GameLoopConstants.standardSPF)
    }
}
