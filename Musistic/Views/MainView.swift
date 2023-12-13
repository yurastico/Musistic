//
//  MainView.swift
//  Musistic
//
//  Created by Yuri Cunha on 11/12/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MusicsListView()
                .tabItem {
                    Label("Musics", systemImage: "music.note")
                }
            ArtistsListView()
                .tabItem {
                    Label("Artists", systemImage: "music.mic")
                }
            MyPlaylistsView()
                .tabItem {
                    Label("Playlists",systemImage: "music.note.list")
                }
            SettingsView()
                .tabItem {
                    Label("Settings",systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainView()
}
