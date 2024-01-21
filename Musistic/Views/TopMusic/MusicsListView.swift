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
                NavigationLink(value: TrackNavigationType.trackDetail(track: track)) {
                    MusicItemRow(track: track)
                        .listRowSeparator(.hidden, edges: .all)
                        .padding(-5)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Top Songs")
            .navigationDestination(for: TrackNavigationType.self) { type in
                switch type {
                case .trackDetail(let track):
                    TopMusicDetail(track: track)
                
                    
                }
                
            }
           
            
        }
        .onAppear {
            Task {
                await readAllData()
            }
        }
        
    }
    
    private func readAllData() async {
        let result = await GetTopService().fetchTop(for: Track.self,timeRange: .mediumTerm)
        switch result {
        case .success(let tracks):
            self.list = tracks.items
        case .failure(let error):
            print(error)
        }
        
        
    }
    
}

#Preview {
    MusicsListView()
}
