//
//  GetTopContentView.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI

struct TopContentListView<type: Codable & ContentForRender,Content: View, Destination: View>: View {
    @State private var path = NavigationPath()
    @State private var error: RequestError?
    @Bindable var viewModel: TopContentViewModel<type>
    @ViewBuilder var content: (type) -> Content
    @ViewBuilder var destination: (type) -> Destination
    var body: some View {
            ZStack {
                
                List {
                    if !viewModel.isFetchingData {
                        ForEach(viewModel.content) { data in
                            
                            NavigationLink(value: ContentNavigationType.detail(data)) {
                                content(data)
                            }
                        }
                    } else {
                        SkeletonView()
                    }
                }
                .listStyle(.plain)
                
                .navigationDestination(for: ContentNavigationType<type>.self) { type in
                    switch type {
                    case .detail(let artist):
                        destination(artist)
                    }
                }
                
                if error != nil {
                    SnackBarErrorView(error: $error)
                }
            }
        .onAppear {
            if viewModel.content.isEmpty {
                viewModel.isFetchingData = true
                Task {
                    await viewModel.refreshContent()
                    withAnimation {
                        viewModel.isFetchingData = false
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.IsShowingShareView) {
            ShareContentView(imageToShow: $viewModel.imageToShow)
        }
     
    }
}

#Preview {
    TopContentListView(viewModel: TopContentViewModel<Artist>()) { artist in
        Text("oiii")
    } destination: { artist in
        Text(artist.id)}
}
