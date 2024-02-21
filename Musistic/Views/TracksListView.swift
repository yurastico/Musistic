//
//  TracksListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 20/02/24.
//

import SwiftUI

struct TracksListView: View {
    @Binding var viewModel: TopContentViewModel<Track>
    var body: some View {
        TopContentListView(viewModel: viewModel) { track in
                    TrackItemRow(track: track)
                        
                } destination: { track in
                    TrackDetailView(track: track)
                }
    }
}

#Preview {
    TracksListView(viewModel: .constant(.init()))
}
