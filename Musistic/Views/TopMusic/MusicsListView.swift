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
    @State private var isShare = false
    @State private var isLoadingImage = false
    private var viewModel = GetTopViewModel()
    @State var imageToShow: Image?
    
    var body: some View {
        NavigationStack(path: $path) {
            trackList
                .navigationTitle("Top Songs")
                .navigationDestination(for: TrackNavigationType.self) { type in
                    switch type {
                    case .trackDetail(let track):
                        TopMusicDetail(track: track)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        termPicker
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isLoadingImage = true
                            isShare = true
                            Task {
                                await viewModel.prepareForRender()
                                      
                                self.imageToShow = await viewModel.renderImage()
                            }
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
            
        }
        
        .onAppear {
            isFetchingData = true
            Task {
                await viewModel.refreshTracks(for: timeRange)
                withAnimation {
                    isFetchingData = false
                }
            }
        }
        .sheet(isPresented: $isShare) {
            VStack {
                if !isLoadingImage {
                    imageToShow?
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
                
            }.onChange(of: imageToShow) {
                isLoadingImage = false
            }
            
        }
        
        
    }
    
    var trackList: some View {
        List(viewModel.tracks) { track in
            if isFetchingData {
                SkeletonView()
            } else {
                NavigationLink(value: TrackNavigationType.trackDetail(track: track)) {
                    MusicItemRow(track: track)
                }
            }
        }
        .listStyle(.plain)
    }
    
    var termPicker: some View {
        Picker("Term", selection: $timeRange) {
            ForEach(TimeRange.allCases,id: \.self) { range in
                Text(range.rawValue)
            }
        }
        .onChange(of: timeRange) {
            isFetchingData = true
            Task {
                await viewModel.refreshTracks(for: timeRange)
                isFetchingData = false
                
                
            }
        }
        
    }
}

#Preview {
    // MusicsListView()
    Text("oi")
}
