//
//  LogInView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct LogInView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                MainView()
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
}

#Preview {
    LogInView()
}
