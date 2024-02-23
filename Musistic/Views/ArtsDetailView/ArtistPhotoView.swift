//
//  ArtistPhotoView.swift
//  Musistic
//
//  Created by Yuri Cunha on 14/02/24.
//

import SwiftUI

struct ArtistPhotoView: View {
    let artist: Artist
    var body: some View {
        VStack(spacing: 0) {
            if let url = URL(string: artist.images!.first!.url) {
                AsyncImageContainerView(url: url)
                    .clipShape(Circle())
                
                Text(artist.name)
                    .font(.largeTitle)
                    .bold()
            }
            
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    ArtistPhotoView(artist: <#T##Artist#>)
//}
