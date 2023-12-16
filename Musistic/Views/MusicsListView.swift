//
//  MusicsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct MusicsListView: View {
    @State private var list = [Track]()
    var body: some View {
        NavigationStack {
            List(list) { track in
                MusicItemRow(track: track)
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowSpacing(0)
            .listRowInsets(.none)
            .navigationTitle("Top Songs")
        }
        .onAppear {
            readAllData()
        }
        
    }
    
    private func readAllData() {
        let item = Bundle.main.decode( BaseResponse<Track>.self,from: "track-mock.json")
        list = item.items
        
    }
    
}

#Preview {
    MusicsListView()
}
