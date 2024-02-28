//
//  SnackBarErrorView.swift
//  Musistic
//
//  Created by Yuri Cunha on 23/01/24.
//

import Foundation

import SwiftUI

struct SnackBarErrorView: View {
    @Binding var error: RequestError?
    var body: some View {
        VStack {
            Spacer()
            if error != nil {
                Text(error?.errorMessage ?? "Error!")
                    .padding()
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                error = nil
                            }
                        }
                    }
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, error != nil ? UIApplication.shared.getKeyWindow?.safeAreaInsets.bottom ?? 0 : -100)
    }
}

#Preview {
    SnackBarErrorView(error: .constant(.decode))
}
