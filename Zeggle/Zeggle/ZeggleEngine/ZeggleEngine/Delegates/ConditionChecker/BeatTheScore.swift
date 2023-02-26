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
        level.setTarget(to: Int(checkMaximumScore() * 0.9))
        level.setTimer(time: level.items.count * 2)
    }

    private func checkMaximumScore() -> Double {
        var count = 0
        for item in level.items {
            count += item.point
        }
        return Double(count)
    }

    func checkCondition() {
        guard !level.timerLock else {
            return
        }
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
