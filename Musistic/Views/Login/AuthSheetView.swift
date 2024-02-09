//
//  AuthSheetView.swift
//  Musistic
//
//  Created by Yuri Cunha on 09/02/24.
//

import SwiftUI

struct AuthSheetView: View {
    @Binding var isShowingSheetView: Bool
    @Binding var viewModel: LoginViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AuthSheetView(isShowingSheetView: .constant(true),viewModel: .constant(.init()))
}
