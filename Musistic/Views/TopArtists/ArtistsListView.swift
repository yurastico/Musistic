//
//  ArtistsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ArtistsListView: View {
    @State private var list = [Artist]()
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List(list) { artist in
                //NavigationLink(value: NavigationType.detail(track: track)) {
                    ArtistListRow(artist: artist)
                        .listRowSeparator(.hidden, edges: .all)
                        .padding(-5)
                //}
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
            Task {
                await readAllData()
            }
        }
        
    }
    
    private func readAllData() async {
        let result = await GetTopService().fetchTop(for: Artist.self)
        switch result {
        case .success(let tracks):
            self.list = tracks.items
        case .failure(let error):
            print(error)
        }
        
        
    }
    
}


#Preview {
    ArtistsListView()
}
