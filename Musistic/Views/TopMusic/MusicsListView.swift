//
//  MusicsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct MusicsListView: View {
    @State private var list = [Track]()
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List(list) { track in
                NavigationLink(value: NavigationType.detail(track: track)) {
                    MusicItemRow(track: track)
                        .listRowSeparator(.hidden, edges: .all)
                        .padding(-5)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Top Songs")
            .navigationDestination(for: NavigationType.self) { type in
                switch type {
                case .detail(let track):
                    TopMusicDetail(track: track)
                }
                
            }
           
            
        }
        .onAppear {
            readAllData()
        }
        
    }
    
    private func readAllData() {
        let item = Bundle.main.decode( GetTopResponse<Track>.self,from: "track-mock.json")
        list = item.items
        
    }
    
}

#Preview {
    MusicsListView()
}
