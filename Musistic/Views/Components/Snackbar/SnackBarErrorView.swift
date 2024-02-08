//
//  SnackBarErrorView.swift
//  Musistic
//
//  Created by Yuri Cunha on 23/01/24.
//

import Foundation

import SwiftUI

struct SnackBarErrorView: View {
    @Binding var isShowing: Bool
    var message: String
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Text(message)
                    .padding()
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, isShowing ? UIApplication.shared.getKeyWindow?.safeAreaInsets.bottom ?? 0 : -100)
    }
}

#Preview {
    SnackBarErrorView(isShowing: .constant(true),message: "Erro! tente novamente mais tarde")
}
