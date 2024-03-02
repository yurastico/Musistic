//
//  MainView.swift
//  Musistic
//
//  Created by Yuri Cunha on 11/12/23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: TabViewSections = .tracks
    @Environment(Coordinator.self) var coordinator
    @State private var tracksViewModel = TopContentViewModel<Track>()
    @State private var artistViewModel = TopContentViewModel<Artist>()
    var body: some View {
        TabView(selection: $selectedTab) {
            TracksListView(viewModel: tracksViewModel)
                .tag(TabViewSections.tracks)
                .tabItem {
                    Label("Musics", systemImage: "music.note")
                }
            ArtistsListView(viewModel: artistViewModel)
                .tag(TabViewSections.artists)
                .tabItem {
                    Label("Artists", systemImage: "music.mic")
                }
            MyPlaylistsView()
                .tag(TabViewSections.playlists)
                .tabItem {
                    Label("Playlists",systemImage: "music.note.list")
                }
            ProfileView()
                .tag(TabViewSections.profile)
                .tabItem {
                    Label("Profile",systemImage: "person.fill")
                }
            
        }
        .toolbar {
            if selectedTab == .tracks {
                GetTopToolbar(viewModel: $tracksViewModel)
            }
            if selectedTab == .artists {
                GetTopToolbar(viewModel: $artistViewModel)
            }
        }
        .navigationTitle(selectedTab.navigationTitle)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
        
    }
}

enum TabViewSections {
    case tracks
    case artists
    case playlists
    case profile
    
    var navigationTitle: String {
        switch self {
        case .artists:
            return "Top Artists"
        case .tracks:
            return "Top Tracks"
        case .playlists:
            return "Your Playlists"
        case .profile:
            return "Your Profile"
        }
    }
}

#Preview {
    MainView()
}
