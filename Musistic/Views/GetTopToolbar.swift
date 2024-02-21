//
//  GetTopToolbar.swift
//  Musistic
//
//  Created by Yuri Cunha on 11/02/24.
//

import SwiftUI

struct GetTopToolbar<T>: ToolbarContent where T: ContentForRender & Codable {
    @Binding var viewModel: TopContentViewModel<T>
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Picker("Term", selection: $viewModel.timeRange) {
                ForEach(TimeRange.allCases,id: \.self) { range in
                    Text(range.text)
                }
            }
            .onChange(of: viewModel.timeRange) {
                
                viewModel.isFetchingData = true
                Task {
                    await viewModel.refreshContent()
                    withAnimation {
                        viewModel.isFetchingData = false
                    }
                }
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.IsShowingShareView = true
                Task {
                    await viewModel.prepareForRender()
                    viewModel.imageToShow = await viewModel.renderImage()
                }
                
            } label: {
                Image(systemName: "plus")
            }
            
        }
        
    }
}

