//
//  MusicsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct MusicsListView: View {
    @State private var timeRange: TimeRange = .mediumTerm
    @State private var path = NavigationPath()
    @State private var isFetchingData = true
    private var viewModel = GetTopViewModel()
    var body: some View {
        NavigationStack(path: $path) {
            
            List(viewModel.tracks) { track in
                if isFetchingData {
                   SkeletonView()
                        .listRowSeparator(.hidden, edges: .all)
                        .padding(-5)
                    
                } else {
                    NavigationLink(value: TrackNavigationType.trackDetail(track: track)) {
                        MusicItemRow(track: track)
                            .listRowSeparator(.hidden, edges: .all)
                            .padding(-5)
                    }
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
            .toolbar {
                Picker("Term", selection: $timeRange) {
                    ForEach(TimeRange.allCases,id: \.self) { range in
                        Text(range.rawValue)
                    }
                }
                .onChange(of: timeRange) {
                    Task {
                        isFetchingData = true
                        await viewModel.refreshTracks(for: timeRange)
                        isFetchingData = false
                        
                    }
                }
            }
           
            
        }
        .onAppear {
            Task {
                isFetchingData = true
                await viewModel.refreshTracks(for: timeRange)
                isFetchingData = false
            }
        }
        
    }
}

#Preview {
    MusicsListView()
}
