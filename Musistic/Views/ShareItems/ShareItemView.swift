//
//  ShareItemView.swift
//  Musistic
//
//  Created by Yuri Cunha on 27/01/24.
//

import SwiftUI

struct ShareItemView: View {
    var tracks: [TrackForRender]
    var body: some View {

        VStack(alignment: .leading) {
            Text("Your most listened songs!")
                .font(.largeTitle)
            ForEach(tracks) { track in
                HStack {
                    track.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(track.name)
                        Text(track.artist)
                    }
                    Spacer()
                    
                }
            }
        }
    }
}
