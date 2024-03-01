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
    @Environment(Coordinator.self) var coordinator
    var body: some View {
            VStack {
                if let user = viewModel.user,
                   let url = URL(string: user.images!.last!.url) {
                    AsyncImageContainerView(url: url)
                        .clipShape(Circle())
                        .frame(height: 150)
                }
                
                if let displayName = viewModel.user?.displayName {
                    Text(displayName)
                        .font(.largeTitle)
                        .bold()
                }
                
                HStack {
                    if let followers = viewModel.user?.followers?.total {
                        Text("Followers \(followers)")
                            .font(.title)
                    }
                }
                
                if let currentContent = viewModel.currentContent {
                    
                        if let url = URL(string: currentContent.item.album.images.first!.url) {
                            HStack {
                                AsyncImageContainerView(url: url)
                                    .frame(height: 100)
                                VStack {
                                    Text(currentContent.item.name)
                                    Text(currentContent.item.album.name)
                                }
                            }
                        }
                    
                }
                
                
                Spacer()
                
                Button("Logout") {
                    SpotifyAuthenticationManager.shared.removeCredentials()
                    userStateViewModel.logout()
                    coordinator.pop()
                    
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Settings")
        
        .onAppear {
            Task {
                await viewModel.getUserContent()
                await viewModel.getPlayingContent()
            }
        }
    }
}

#Preview {
    ProfileView()
}
