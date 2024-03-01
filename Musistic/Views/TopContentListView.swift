//
//  GetTopContentView.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI

struct TopContentListView<type: ContentForRender,Content: View, Destination: View>: View {
    @Environment(Coordinator.self) var coordinator
    var type: NavigationType
    @Bindable var viewModel: TopContentViewModel<type>
    @ViewBuilder var content: (type) -> Content
    @ViewBuilder var destination: (type) -> Destination
    var body: some View {
            ZStack {
                
                List {
                    if !viewModel.isFetchingData {
                        ForEach(viewModel.content) { data in
                            
                            NavigationLink(value: NavigationType.artistList) {
                                content(data)
                            }
                            
                        }
                    } else {
                        SkeletonView()
                    }
                }
                .listStyle(.plain)
                
                .navigationDestination(for: NavigationType.self) { type in
                    coordinator.view(for: type)
                }
                
                if viewModel.error != nil {
                    SnackBarErrorView(error: $viewModel.error)
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
    TopContentListView(type: .artistList,viewModel: TopContentViewModel<Artist>()) { artist in
        Text("oiii")
    } destination: { artist in
        Text(artist.id)}
}
