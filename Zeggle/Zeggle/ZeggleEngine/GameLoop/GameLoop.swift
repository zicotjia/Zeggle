//
//  GameLoop.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import Foundation
import QuartzCore

class GameLoop: ObservableObject {
    @Published var time = Float(0.0)
    @Published private(set) var level: Level
    @Published var state: GameState

    var displayLink: CADisplayLink!

    init(level: Level) {
        self.level = level
        state = GameState.inGame
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

    func getNumberOfBallsLeft() -> Int {
        level.numberOfBalls
    }

    func startGame() {
        state = .inGame
    }

    func changeState(state: GameState) {
        self.state = state
    }

    func gameHasEnded() -> Bool {
        state == .lose || state == .win
    }

    func checkGameState() {
        if level.winFlag {
            state = .win
        }

        if level.loseFlag {
            state = .lose
        }
    }

    @objc func step(displaylink: CADisplayLink) {
        guard state == .inGame else {
            return
        }
        time += Float(1.0 / 60)
        level.updateSelf(timeElapsed: GameLoopConstants.standardSPF)
        checkGameState()
    }
}
