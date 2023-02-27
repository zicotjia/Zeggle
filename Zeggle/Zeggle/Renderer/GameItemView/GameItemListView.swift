//
//  GameItemListView.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct GameItemListView: View {
    @EnvironmentObject var gameLoop: GameLoop
    var entities: Set<ZeggleItem>

    var body: some View {
        ZStack {
            ForEach(Array(entities), id: \.self) { entity in
                GameItemViewCreator.createItemView(item: entity, state: .off)
            }
        }.frame(width: DimensionsConstants.levelWidth, height: DimensionsConstants.levelHeight)

    }
}

struct GameItemListView_Previews: PreviewProvider {

    static let ball = Ball(centre: PhysicsVector2D(horizontal: 300, vertical: 50), hSpeed: 0, vSpeed: 0, type: .spooky)

    static let peg = Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 300), radius: 50, color: .orange)

    static let entities: Set<ZeggleItem> = [ball, peg]

    static var previews: some View {
        GameItemListView(entities: entities)
    }
}
