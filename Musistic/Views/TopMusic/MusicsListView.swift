//
//  MusicsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI


struct MusicsListView: View {
    @Binding var viewModel: TopContentViewModel<Track>
    var body: some View {
        TopContentListView(viewModel: viewModel) { track in
            MusicItemRow(track: track)
                
        } destination: { track in
            TopMusicDetail(track: track)
        }
       
        
        
        
    }
}

#Preview {
    // MusicsListView()
    Text("oi")
}
