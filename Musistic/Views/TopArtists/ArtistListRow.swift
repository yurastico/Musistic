//
//  ArtistListRow.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//
import SwiftUI

struct ArtistListRow: View {
    let artist: Artist

    var body: some View {
        HStack {
            AsyncImageContainer(url: URL(string: artist.images!.first!.url)!)
                .frame(width: 50,height: 50)
            
            VStack(alignment: .leading) {
                Text(artist.name)
                    .font(.headline)
                    .lineLimit(1)
                    .bold()
                    .multilineTextAlignment(.leading)
                
                Text("\(artist.followers?.total ?? 0)")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
            }

        }
        //.frame(width: 25)
        
    }
}


