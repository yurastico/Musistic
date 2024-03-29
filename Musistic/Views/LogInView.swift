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
    @Environment(Coordinator.self) var coordinator
    var body: some View {
        
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

        
        .onChange(of: userStateViewModel.isLogged, { oldValue, newValue in
            if newValue {
                coordinator.push(to: .main)
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





