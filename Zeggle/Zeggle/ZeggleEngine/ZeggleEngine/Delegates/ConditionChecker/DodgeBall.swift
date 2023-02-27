//
//  DodgeBall.swift
//  Zeggle
//
//  Created by Zico on 24/2/23.
//

class DodgeBall: ConditionChecker {
    private unowned var level: Level

    init(level: Level) {
        self.level = level
    }

    func checkCondition() {
        level.timer -= Float(1.0 / 120)
        checkWinCondition()
        checkLoseCondition()
    }

    func checkWinCondition() {
        guard !level.winFlag && !level.loseFlag else {
            return
        }
        let noMoreBalls = level.numberOfBalls == 0
        let noActiveBall = level.ball == nil

        guard noMoreBalls && noActiveBall else {
            return
        }
        level.triggerWin()
    }

    func checkLoseCondition() {
        guard !level.winFlag && !level.loseFlag else {
            return
        }

        for item in level.items where !(item is Ball) && item.undergoingDeletion {
            level.triggerLose()
        }

        if level.timer < 0 {
            level.triggerLose()
        }
    }

}
