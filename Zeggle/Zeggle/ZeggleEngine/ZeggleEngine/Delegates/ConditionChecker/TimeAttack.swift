//
//  TimeAttack.swift
//  Zeggle
//
//  Created by Zico on 24/2/23.
//

class TimeAttack: ConditionChecker {

    private unowned var level: Level
    private var standardChecker: StandardMode

    init(level: Level) {
        self.level = level
        standardChecker = StandardMode(level: level)
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
        standardChecker.checkWinCondition()
    }

    func checkLoseCondition() {
        standardChecker.checkLoseCondition()
        if level.timer < 0 {
            level.triggerLose()
        }
    }

}
