//
//  StandardMode.swift
//  Zeggle
//
//  Created by Zico on 22/2/23.
//

class StandardMode: ConditionChecker {

    private unowned var level: Level

    init(level: Level) {
        self.level = level
    }

    func checkCondition() {
        checkWinCondition()
        checkLoseCondition()
    }

    func checkWinCondition() {
        guard !level.winFlag && !level.loseFlag else {
            return
        }
        for item in level.items where item is Peg {
            return
        }
        print("you win")
        level.triggerWin()
    }

    func checkLoseCondition() {
        guard !level.winFlag && !level.loseFlag else {
            return
        }
        let noMoreBalls = level.numberOfBalls == 0
        let noActiveBall = level.ball == nil

        if noMoreBalls && noActiveBall {
            print("you lose")
            level.triggerLose()
        }
    }
}
