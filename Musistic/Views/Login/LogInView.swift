//
//  LogInView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI


struct LogInView: View {
    @Environment(\.authorizationController) private var authorizationController
    @Environment(UserStateViewModel.self) var userStateViewModel
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
                    MainView(path: $path)
                    
                        
                }
            }
        }
        .onChange(of: userStateViewModel.isLogged, { oldValue, newValue in
            if newValue {
                path.append(LoginPath.mainView)
            }
        })
        .onChange(of: isShowingAuthWebView, { oldValue, newValue in
            if newValue == false {
                if SpotifyAuthenticationManager.shared.isAccessTokenValid() {
                    userStateViewModel.isLogged = true
                 
                }
            }
            
        })
        .sheet(isPresented: $isShowingAuthWebView) {
            AuthSheetView(isShowingSheetView: $isShowingAuthWebView)
                .onDisappear {
                    if SpotifyAuthenticationManager.shared.isAccessTokenValid() {
                        withAnimation {
                            userStateViewModel.isLogged = true
                            
                        }
                    }
                }
        }
        .onAppear {
            userStateViewModel.verifyLogin()
        }
    }
}

#Preview {
    LogInView()
}


enum LoginPath: Hashable {
    case mainView
}



