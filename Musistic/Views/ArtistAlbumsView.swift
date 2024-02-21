//
//  ArtistAlbumsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 14/02/24.
//

import SwiftUI

struct ArtistAlbumsView: View {
    let albuns: [Album]
    var body: some View {
        TabView {
            ForEach(albuns) { album in
                if let url = URL(string: album.images.first!.url) {
                    VStack {
                        AsyncImageContainer(url: url)
                            .frame(maxWidth: .infinity)
                        Text(album.name)
                    }
                    
                }
            }
        }
        
        .frame(height: 250)
        .frame(maxWidth: .infinity)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    ArtistAlbumsView(albuns: [])
}
