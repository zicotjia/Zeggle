//
//  SizeSliderView.swift
//  Zeggle
//
//  Created by Zico on 24/2/23.
//

import SwiftUI

struct SizeSliderView: View {
    @Binding var radius: CGFloat
    @Binding var levelEditorState: LevelEditorStates

    var body: some View {
        VStack {
            HStack {
                Text("Size ")
                Slider(value: $radius, in: 10...50)
            }
            HStack {
                if let image = levelEditorState.image {
                    Image(image).resizable()
                        .frame(width: radius * 2 * DimensionsConstants.resolutionRatio,
                               height: radius * 2 * DimensionsConstants.resolutionRatio)
                }
            }.frame(minWidth: 90, minHeight: 90)
        }

    }
}

struct SizeSliderView_Previews: PreviewProvider {
    static var previews: some View {
        SizeSliderView(radius: .constant(20), levelEditorState: .constant(.deletePeg))
    }
}
