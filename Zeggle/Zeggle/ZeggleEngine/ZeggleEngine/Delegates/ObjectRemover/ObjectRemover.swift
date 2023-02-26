//
//  GameItemRemover.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

protocol ObjectRemover: AnyObject {
    func resolve()

    func isResolved() -> Bool
}
