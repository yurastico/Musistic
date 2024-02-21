//
//  ArtistListRow.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//
import SwiftUI

struct ArtistListRowView: View {
    let artist: Artist

    var body: some View {
        HStack {
            AsyncImageContainerView(url: URL(string: artist.images!.first!.url)!)
                .frame(width: 50,height: 50)
            
            VStack(alignment: .leading) {
                Text(artist.name)
                    .font(.headline)
                    .lineLimit(1)
                    .bold()
                    .multilineTextAlignment(.leading)
                
                Text("\(artist.genres?.first ?? "")")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
            }

        }
        .listRowSeparator(.hidden, edges: .all)
        .padding(-5)
        //.frame(width: 25)
    }
}


