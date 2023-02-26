//
//  FlagTriggerer.swift
//  Zeggle
//
//  Created by Zico on 22/2/23.
//

protocol ConditionChecker: AnyObject {
    func checkCondition()
    func checkWinCondition()
    func checkLoseCondition()
}
