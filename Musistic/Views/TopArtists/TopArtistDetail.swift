//
//  TopArtistDetail.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import SwiftUI

struct TopArtistDetail: View {
    var artist: Artist
    
    var body: some View {
        VStack {
            TabView {
                ForEach(artist.images ?? []) { image in
                    if let url = URL(string: image.url) {
                        AsyncImageContainer(url: url)
                        
                    }
                }
            }.tabViewStyle(.page)
            
           
            
            VStack {
                Text(artist.name)
                    .font(.largeTitle)
                    .bold()
                
                
                
                
                
            }
            Spacer()
        }
    }
}


//#Preview {
//    TopArtistDetail()
//}
