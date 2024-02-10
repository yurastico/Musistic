//
//  AuthSheetView.swift
//  Musistic
//
//  Created by Yuri Cunha on 09/02/24.
//

import SwiftUI

struct AuthSheetView: View {
    @Binding var isShowingSheetView: Bool
    @Binding var viewModel: UserStateViewModel
    var body: some View {
        if !viewModel.isFinishedAuthentication {
              
                WebView(authViewModel: viewModel)
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

var authViewModel: UserStateViewModel
  let webView = WKWebView()

  func makeCoordinator() -> AuthCoordinator {
    AuthCoordinator(authViewModel)
  }
 
  func updateUIView(_ uiView: UIView,
                    context: UIViewRepresentableContext<WebView>) {}

  func makeUIView(context: Context) -> UIView {
    webView.navigationDelegate = context.coordinator
    
      if let url = authViewModel.createUrlForAuthorization() {
      webView.load(URLRequest(url: url))
    }

    return webView
  }
}


#Preview {
    AuthSheetView(isShowingSheetView: .constant(true),viewModel: .constant(.init()))
}
