//
//  MusicsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct MusicsListView: View {
    var body: some View {
        NavigationStack {
            ContentListView()
                .navigationTitle("My top songs")
        }
        
    }
}

#Preview {
    MusicsListView()
}
