//
//  ShareItemView.swift
//  Musistic
//
//  Created by Yuri Cunha on 27/01/24.
//

import SwiftUI

struct ShareItemView<T: ContentForRender>: View {
    var tracks: [T]
    var body: some View {

        VStack(alignment: .leading) {
            Text("Your most listened songs!")
                .font(.largeTitle)
            ForEach(tracks) { track in
                HStack {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(track.title ?? "")
                        Text(track.subtitle ?? "")
                    }
                    Spacer()
                    
                }
            }
        }
    }
}
