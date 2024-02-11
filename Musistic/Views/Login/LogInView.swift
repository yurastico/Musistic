//
//  LogInView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI
import AuthenticationServices

struct LogInView: View {
    @State var userStateViewModel: UserStateViewModel = .init()
    @State var isShowingAuthWebView = false
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            
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
            .navigationDestination(for: LoginPath.self) { path in
                switch path {
                case .mainView:
                    MainView()
                    
                        
                }
            }
        }
        
        .onChange(of: userStateViewModel.isLogged) {
            if userStateViewModel.isLogged {
                path.append(LoginPath.mainView)
            }
        }
        .sheet(isPresented: $isShowingAuthWebView) {
            AuthSheetView(isShowingSheetView: $isShowingAuthWebView, viewModel: $userStateViewModel)
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


enum LoginPath: Hashable {
    case mainView
}
