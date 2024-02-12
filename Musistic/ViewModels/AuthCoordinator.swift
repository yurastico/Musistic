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
    @Published var viewModel: UserStateViewModel
    
    init(_ viewModel: UserStateViewModel) {
        self.viewModel = viewModel
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.isLoading = false
    }
    
    
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url!.absoluteString
        
        
        
        if url.contains("?code=") == false {
            decisionHandler(.allow)
            return
        } else {
            
            if let url = navigationAction.request.url {
                viewModel.handleSpotify(for: url)
                //viewModel.isLogged = true
            }
            decisionHandler(.cancel)
            webView.stopLoading()
            return
        }
        
    }
}
