//
//  CannonView.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct CannonView: View {
    @State var angle: Float = 0.0
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        ZStack {
            Image(ImageNameToFile.cannon)
                .resizable()
                .frame(width: CannonConstants.width, height: CannonConstants.height)
                .position(x: CannonConstants.xPos, y: CannonConstants.yPos)
                .rotationEffect(.degrees(Double(angle - 90)),
                                anchor: UnitPoint(x: CannonConstants.xPos /
                                                  DimensionsConstants.rightWall,
                                                  y: CannonConstants.yPos /
                                                  DimensionsConstants.floor))
        }
        .frame(width: DimensionsConstants.deviceWidth, height: DimensionsConstants.levelHeight)
        .contentShape(Rectangle())
        .onTapGesture(coordinateSpace: .global) { location in

            guard var newAngle = HelperFunctions.getLaunchAngle(location: location) else {
                return
            }
            newAngle *= -1
            self.angle = newAngle
            gameLoop.level.shootCannon(angle: newAngle)
        }
    }
}

struct CannonView_Previews: PreviewProvider {

    static var previews: some View {
        CannonView(angle: 90)
    }
}
