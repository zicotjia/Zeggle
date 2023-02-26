//
//  ItemType.swift
//  Zeggle
//
//  Created by Zico on 25/2/23.
//

enum ItemType: String, CaseIterable, Identifiable {
    case orangePeg = "peg-orange"
    case bluePeg = "peg-blue"
    case zombiePeg = "peg-zombie"

    var id: ItemType { self }
}
