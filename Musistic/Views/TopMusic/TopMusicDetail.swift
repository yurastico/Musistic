//
//  TopMusicDetail.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import SwiftUI

struct TopMusicDetail: View {
    let track: Track
    var body: some View {
        VStack {
            AsyncImageContainer(url: URL(string: track.album.images.first!.url)!)
            
            VStack {
                Text(track.name)
                    .font(.largeTitle)
                    .bold()
                Text(track.album.name)
                    .font(.headline)
                Text(track.artists[0].name)
                    .font(.title)
            }
            
            HStack {
                Text(track.artistsText)
            }
            
            Spacer()
        }
        .onAppear {
           
        }
    }
}

#Preview {
    Text("need to fix this!!!!!")
    //TopMusicDetail(track: <#T##Track#>)
}
