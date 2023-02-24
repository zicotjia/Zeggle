//
//  SizeSliderView.swift
//  Zeggle
//
//  Created by Zico on 24/2/23.
//

import SwiftUI

struct SizeSliderView: View {
    @Binding var radius: CGFloat

    var body: some View {
        HStack {
            Text("Size ")
            Slider(value: $radius, in: 10...70)
        }
    }
}

struct SizeSliderView_Previews: PreviewProvider {
    static var previews: some View {
        SizeSliderView(radius: .constant(20))
    }
}
