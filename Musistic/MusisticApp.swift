//
//  MusisticApp.swift
//  Musistic
//
//  Created by Yuri Cunha on 11/12/23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        return true
    }
    
    
}

@main
struct MusisticApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var userStateViewModel = UserStateViewModel()
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(userStateViewModel)
                
        }
    }
}
