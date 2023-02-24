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
    @Published var test = Float(0.0)

    var displayLink: CADisplayLink!

    init(level: Level) {
        self.level = level
        state = GameState.levelPicker
        createDisplayLink()
    }

    private func createDisplayLink() {
        guard displayLink == nil else {
            return
        }

        displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .current, forMode: RunLoop.Mode.default)
    }

    func setNumberOfBalls(to amount: Int) {
        level.setNumberOfBall(to: amount)
    }

    func enterLevelEditor() {
        state = .levelDesigner
    }

    func switchLevel(level: Level) {
        self.level = level
    }

    func addItem(item: ZeggleItem) {
        level.addItem(zeggleItem: item)
    }

    func resetTime() {
        time = 0
    }

    func restart() {
        resetLevel()
        resetTime()
        startGame()
    }

    func resetLevel() {
        level = Database.getLevelWithName(name: level.name)
    }

    func exitLevel() {
        state = .levelPicker
        resetTime()
    }

    func renameLevel(newName: String) {
        level.rename(newName: newName)
    }

    func shootCannon(angle: Float) {
        level.shootCannon(angle: angle)
    }

    func getNumberOfBallsLeft() -> Int {
        level.numberOfBalls
    }

    func changeGameMode(gameMode: GameMode) {
        level.changeGameMode(gameMode: gameMode)
    }

    func startGame() {
        state = .inGame
    }

    func changeState(state: GameState) {
        self.state = state
    }

    func gameHasEnded() -> Bool {
        let hasEnded = state == .lose || state == .win
        return hasEnded
    }

    func gameEndMessage() -> String {
        guard level.winFlag || level.loseFlag else {
            return ""
        }
        if level.winFlag {
            return "You Win"
        }
        if level.loseFlag {
            return "You Lose"
        }

        return ""
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
        if state == .levelDesigner {
            test += 1
        }

        guard state == .inGame else {
            return

        }
        time += Float(1.0 / 60)
        level.updateSelf(timeElapsed: GameLoopConstants.standardSPF)
        checkGameState()
    }
}
