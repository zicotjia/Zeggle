//
//  ItemType.swift
//  Zeggle
//
//  Created by Zico on 25/2/23.
//

enum ItemType: String, CaseIterable, Identifiable {
    case orangePeg = "peg-orange"
    case bluePeg = "peg-blue"
    case redPeg = "peg-red"
    case yellowPeg = "peg-yellow"
    case pinkPeg = "peg-pink"
    case zombiePeg = "peg-zombie"

    var id: ItemType { self }
}
