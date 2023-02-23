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
            LoadButtonView()
            Spacer()
            SaveButtonView()
            Spacer()
            ResetButtonView()
            NameBarView()
            StartButtonView()
        }
    }
}

struct MenuButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonsView()
    }
}
