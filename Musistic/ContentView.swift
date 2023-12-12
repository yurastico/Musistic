//
//  ContentView.swift
//  Musistic
//
//  Created by Yuri Cunha on 11/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MusicsListView()
                .tabItem {
                    Label("Musics", systemImage: "music.note.list")
                }
            ArtistsListView()
                .tabItem {
                    Label("Artists", systemImage: "music.mic")
                }
            SettingsView()
                .tabItem {
                    Label("Settings",systemImage: "gear")
                }
            
            
        }
    }
}

#Preview {
    ContentView()
}
