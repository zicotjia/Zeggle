//
//  MenuButtonsView.swift
//  Peggle
//
//  Created by Zico on 28/1/23.
//

import SwiftUI

struct MenuButtonsView: View {

    var body: some View {
        HStack {
            Spacer().frame(width: 8)
            LoadButtonView()
            Spacer()
            SaveButtonView()
            Spacer()
            ResetButtonView()
            NameBarView()
            ToggleMusicView()
            StartButtonView()
            Spacer().frame(width: 8)
        }
    }
}

struct MenuButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonsView()
    }
}
