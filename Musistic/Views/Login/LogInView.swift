//
//  LogInView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI
import AuthenticationServices

struct LogInView: View {
    @Environment(UserStateViewModel.self) var userStateViewModel
    @State private var viewModel: LoginViewModel = .init()
    @State var isShowingAuthWebView = false
    var body: some View {
        VStack {
            if userStateViewModel.isLogged {
                MainView() // isso pode estar na memória se eu de logout, pode ser que de pau!!!
                    .transition(.move(edge: .trailing))
            } else {
                Button {
                    isShowingAuthWebView = true
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
        .sheet(isPresented: $isShowingAuthWebView, content: {
            AuthSheetView(isShowingSheetView: $isShowingAuthWebView, viewModel: $viewModel)
              })
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
