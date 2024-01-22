//
//  MusisticApp.swift
//  Musistic
//
//  Created by Yuri Cunha on 11/12/23.
//

import SwiftUI

@main
struct MusisticApp: App {
    var userStateViewModel = UserStateViewModel()
    var body: some Scene {
        WindowGroup {
            LogInView()
                .environment(userStateViewModel)
                
        }
    }
}
