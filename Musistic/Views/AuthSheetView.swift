//
//  AuthSheetView.swift
//  Musistic
//
//  Created by Yuri Cunha on 09/02/24.
//

import SwiftUI
import AuthenticationServices




struct AuthSheetView: View {
    @Binding var isShowingSheetView: Bool
    @Environment(UserStateViewModel.self) var viewModel
    var body: some View {
        if !viewModel.isFinishedAuthentication {
            WebView()
                .opacity(viewModel.isLoading ? 0 : 1)
        } else {
            ProgressView()
                .onAppear {
                    isShowingSheetView = false
                }
        }
    }
}

import WebKit

struct WebView: UIViewRepresentable {
    
    @Environment(UserStateViewModel.self) var userStateViewModel
    let webView = WKWebView()
    
    func makeCoordinator() -> AuthCoordinator {
        AuthCoordinator(userStateViewModel)
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<WebView>) {}
    
    func makeUIView(context: Context) -> UIView {
        webView.navigationDelegate = context.coordinator
        
        if let url = userStateViewModel.createUrlForAuthorization() {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
}


#Preview {
    AuthSheetView(isShowingSheetView: .constant(true))
}
