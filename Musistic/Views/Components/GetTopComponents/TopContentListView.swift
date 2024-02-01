//
//  GetTopContentView.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI

struct TopContentListView<type: Codable & ContentForRender,Content: View, Destination: View>: View {
    @State private var timeRange: TimeRange = .mediumTerm
    @State private var path = NavigationPath()
    @State private var isShowingSnackBar = false
    @State private var errorMessage = ""
    @Bindable var viewModel: TopContentViewModel<type>
    @State private var isFetchingData = true
    @State private var IsShowingShareView = false
    @State var imageToShow: Image?
    @ViewBuilder var content: (type) -> Content
    @ViewBuilder var destination: (type) -> Destination

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                List {
                    ForEach(viewModel.content) { data in
                        NavigationLink(value: ContentNavigationType.detail(data)) {
                            if isFetchingData {
                                SkeletonRow()
                            } else {
                                content(data)
                            }
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
                                withAnimation {
                                    isFetchingData = false
                                }
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            IsShowingShareView = true
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
        .sheet(isPresented: $IsShowingShareView) {
            ShareContentView(imageToShow: $imageToShow)
        }
    }
}

#Preview {
    TopContentListView(viewModel: TopContentViewModel<Artist>()) { artist in
        Text("oiii")
    } destination: { artist in
        Text(artist.id)}
}
