//
//  LogInView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct LogInView: View, GetCode {
    @State private var isLogged = false
    var body: some View {
        
        VStack {
            if isLogged {
                MainView()
                    .transition(.move(edge: .trailing))
                    
            } else {
                Button {
                    withAnimation {
                        //isLogged = true
                    }
                    if let url = createUrl(endpoint: AuthorizeEndpoint.authorize) {
                        UIApplication.shared.open(url)
                        
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
                let result = await AuthenticationService().saveAcessToken(from:url)
                switch result {
                case .success(let saved):
                    isLogged = saved
                case .failure(let error):
                    print(error)
                }
            }
        }
        .onAppear {
            if SpotifyAuthenticationManager.shared.isAccessTokenValid() {
                self.isLogged = true
                print("tudo valendo!!!!!")
            } else {
                Task {
                    if SpotifyAuthenticationManager.shared.accessToken != nil {
                        let isAuthenticated = await AuthenticationService().refreshToken()
                        self.isLogged = isAuthenticated
                        print("refreshing token!!!!!!!!!!!!")
                        
                    }
                }
            }
        }
    }
}

#Preview {
    LogInView()
}
