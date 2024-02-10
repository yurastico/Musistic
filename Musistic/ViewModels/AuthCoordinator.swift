//
//  AuthCoordinator.swift
//  Musistic
//
//  Created by Yuri Cunha on 10/02/24.
//

import Foundation
import WebKit
import SwiftUI

class AuthCoordinator: NSObject, WKNavigationDelegate {
  @State private var viewModel: UserStateViewModel

  init(_ viewModel: UserStateViewModel) {
    self.viewModel = viewModel
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    viewModel.isLoading = false
  }

  func webView(_ webView: WKWebView,
               decidePolicyFor navigationAction: WKNavigationAction,
               decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

    let newlyRequestedURL = navigationAction.request.url!.absoluteString
    guard newlyRequestedURL.contains("?error=") == false else {
      fatalError("Received an error from SpotifyAuth API, instead of the auth code.")
    }
    if newlyRequestedURL.contains("?code=") == false {
      decisionHandler(.allow)
      return
    } else {
      viewModel.handleSpotify(for: newlyRequestedURL)
      decisionHandler(.cancel)
      webView.stopLoading()
      return
    }
  }
}
