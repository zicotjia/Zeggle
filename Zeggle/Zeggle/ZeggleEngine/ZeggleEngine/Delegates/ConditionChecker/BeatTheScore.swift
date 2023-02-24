//
//  BeatTheScore.swift
//  Zeggle
//
//  Created by Zico on 24/2/23.
//

class BeatTheScore: ConditionChecker {
    private unowned var level: Level

    init(level: Level) {
        self.level = level
        level.setTarget(to: checkMaximumScore() / 2)
        level.setTimer(time: level.items.count * 2)
    }

    private func checkMaximumScore() -> Int {
        var count = 0
        for item in level.items {
            count += item.point
        }
        return count
    }

    func checkCondition() {
        level.timer -= Float(1.0 / 120)
        checkWinCondition()
        checkLoseCondition()
    }

    func checkWinCondition() {
        guard level.timer >= 0 else {
            return
        }

        if level.score >= level.target {
            level.triggerWin()
        }
    }

    func checkLoseCondition() {
        if level.timer < 0 {
            level.triggerLose()
        }
    }

}
