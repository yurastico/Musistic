//
//  SettingsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(UserStateViewModel.self) var userStateViewModel
    @State private var viewModel = UserProfileViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                if let user = viewModel.user,
                   let url = URL(string: user.images.last!.url) {
                    AsyncImageContainer(url: url)
                        .clipShape(Circle())
                        .frame(height: 150)
                }
                
                if let displayName = viewModel.user?.displayName {
                    Text(displayName)
                        .font(.largeTitle)
                        .bold()
                }
                
                HStack {
                    if let followers = viewModel.user?.followers.total {
                        Text("Followers \(followers)")
                            .font(.title)
                    }
                }
                
                Spacer()
                
                Button("Logout") {
                    SpotifyAuthenticationManager.shared.removeCredentials()
                    userStateViewModel.isLogged = false
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Settings")
        }
        .onAppear {
            Task {
                await viewModel.getUserContent()
            }
        }
    }
}

#Preview {
    ProfileView()
}
