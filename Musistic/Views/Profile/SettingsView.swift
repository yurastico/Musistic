//
//  SettingsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(UserStateViewModel.self) var userStateViewModel
    var body: some View {
        NavigationStack {
            Form {
                Button("Logout") {
                    SpotifyAuthenticationManager.shared.removeCredentials()
                    userStateViewModel.isLogged = false
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    ProfileView()
}
