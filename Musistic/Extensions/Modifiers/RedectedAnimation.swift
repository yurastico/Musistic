//
//  RedectedAnimation.swift
//  Musistic
//
//  Created by Yuri Cunha on 22/01/24.
//

import SwiftUI

struct RedectedAnimationModifier: ViewModifier {
    @State private var isRedacted = true
    func body(content: Content) -> some View {
        content
            .opacity(isRedacted ? 0 : 1)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                    self.isRedacted.toggle()
                }
            }
    }
    
    
}

extension View {
    func redectedAnimation() -> some View {
        modifier(RedectedAnimationModifier())
    }
}
