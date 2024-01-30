//
//  GetTopContentView.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI

struct TopContentListView<type: Identifiable & Codable & Hashable,Content: View, Destination: View>: View {
    @State private var timeRange: TimeRange = .mediumTerm
    @State private var path = NavigationPath()
    @State private var isShowingSnackBar = false
    @State private var errorMessage = ""
    @Bindable var viewModel: TopArtistsViewModel<type>
    @State private var isFetchingData = true
    @State private var isShare = false
    @State private var isLoadingImage = false
    @State var imageToShow: Image?
    @ViewBuilder var content: (type) -> Content
    @ViewBuilder var destination: (type) -> Destination
    
    
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                List {
                    ForEach(viewModel.content) { artist in
                        NavigationLink(value: ContentNavigationType.detail(artist)) {
                            content(artist)
                        }
                        
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Top Artists")
                .navigationDestination(for: ContentNavigationType<type>.self) { type in
                    switch type {
                    case .detail(let artist):
                        destination(artist)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Picker("Term", selection: $timeRange) {
                            ForEach(TimeRange.allCases,id: \.self) { range in
                                Text(range.rawValue)
                            }
                        }
                        .onChange(of: timeRange) {
                            isFetchingData = true
                            Task {
                                await viewModel.refreshContent(for: timeRange)
                                isFetchingData = false
                            }
                        }
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
                if isShowingSnackBar {
                    SnackBarErrorView(isShowing: $isShowingSnackBar, message: errorMessage)
                }
            }
            
        }
        .onAppear {
            if viewModel.content.isEmpty {
                isFetchingData = true
                Task {
                    await viewModel.refreshContent(for: timeRange)
                    withAnimation {
                        isFetchingData = false
                    }
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
                print("mudou")
            }
            
        }
    }
}

#Preview {
    TopContentListView(viewModel: TopArtistsViewModel<Artist>()) { artist in
        Text("oiii")
    } destination: { artist in
        Text(artist.id)}
}
