//
//  TracksListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 20/02/24.
//

import SwiftUI

struct TracksListView: View {
    @State var viewModel: TopContentViewModel<Track>
    @Environment(Coordinator.self) var coordinator
    var body: some View {
        TopContentListView(viewModel: viewModel) { track in
            NavigationLink(value: NavigationType.trackDetail(track: track)) {
                TrackItemRowView(track: track)
            }
          
            
        }
        
        
        
        
    }
    
}

#Preview {
    TracksListView(viewModel: .init())
}
