//
//  ArtistsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ArtistsListView: View {
    var body: some View {
        NavigationStack {
            Text("Artists")
                .navigationTitle("My top artists")
        }
    }
}

#Preview {
    ArtistsListView()
}
