//
//  LogInView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct LogInView: View, GetCode {
    @Environment(UserStateViewModel.self) var userStateViewModel
    var body: some View {
        VStack {
            if userStateViewModel.isLogged {
                MainView() // isso pode estar na memória se eu de logout, pode ser que de pau!!!
                    .transition(.move(edge: .trailing))
            } else {
                Button {
                    let result = createUrl(endpoint: AuthorizeEndpoint.authorize)
                    switch result {
                    case .success(let url):
                        UIApplication.shared.open(url)
                    case .failure(let error):
                        print(error)
                    }
                } label: {
                    Text("Log in with Spotify")
                        .frame(maxWidth: .infinity)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 66))
                        .padding()
                }
            }
        }
        .onOpenURL { url in
            Task {
                
                await AuthenticationService().saveAcessToken(from:url)
            }
        }
        .onAppear {
            if SpotifyAuthenticationManager.shared.isAccessTokenValid() {
                withAnimation {
                    userStateViewModel.isLogged = true
                }
                
                print("tudo valendo!!!!!")
            } else {
                Task {
                    if SpotifyAuthenticationManager.shared.accessToken != nil {
                        let result = await AuthenticationService().refreshToken()
                        switch result {
                        case .success(let isAuthenticated):
                            self.userStateViewModel.isLogged = isAuthenticated
                            print("refreshing token!!!!!!!!!!!!")
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LogInView()
}
