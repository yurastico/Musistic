//
//  ArtistsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ArtistsListView: View {
    @State private var timeRange: TimeRange = .mediumTerm
    @State private var list = [Artist]()
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List(list) { artist in
                NavigationLink(value: ArtistNavigationType.artistDetail(artist: artist)) {
                    ArtistListRow(artist: artist)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Top Artists")
            .navigationDestination(for: ArtistNavigationType.self) { type in
                switch type {
                case .artistDetail(let artist):
                    TopArtistDetail(artist: artist)
                }
            }
            .toolbar {
                Picker("Term", selection: $timeRange) {
                    ForEach(TimeRange.allCases,id: \.self) { range in
                        Text(range.rawValue)
                    }
                }
                .onChange(of: timeRange) {
                    Task {
                        await readAllData()
                    }
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
        let result = await GetTopService().fetchTop(for: Artist.self,timeRange: timeRange)
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
