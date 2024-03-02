//
//  ArtistsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ArtistsListView: View {
    @State var viewModel: TopContentViewModel<Artist>
    @Environment(Coordinator.self) var coordinator
    var body: some View {
        TopContentListView(viewModel: viewModel) { artist in
            NavigationLink(value: NavigationType.artistDetail(artist: artist)) {
                ArtistListRowView(artist: artist)
            }
          
        }
    
        
    }
    
    
    
}


#Preview {
    Text("lul")
    //ArtistsListView()
}
