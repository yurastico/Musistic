//
//  GetTopContentView.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI

struct TopContentListView<type: ContentForRender,Content: View>: View {
    @Environment(Coordinator.self) var coordinator
    @Bindable var viewModel: TopContentViewModel<type>
    @ViewBuilder var content: (type) -> Content

    var body: some View {
            ZStack {
                
                List {
                    if !viewModel.isFetchingData {
                        ForEach(viewModel.content) { data in
                            
                                content(data)
                        }
                    } else {
                        SkeletonView()
                    }
                }
                .listStyle(.plain)
                
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
    TopContentListView(viewModel: TopContentViewModel<Artist>()) { artist in
        Text("oiii")
    }
}
