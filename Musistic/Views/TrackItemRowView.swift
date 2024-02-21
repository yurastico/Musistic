//
//  TrackItemRow.swift
//  Musistic
//
//  Created by Yuri Cunha on 20/02/24.
//

import SwiftUI

struct TrackItemRowView: View {
    var track: Track
    var body: some View {
           HStack {
               AsyncImageContainerView(url: URL(string: track.album.images.first!.url)!)
                   .frame(width: 50,height: 50)
               
               VStack(alignment: .leading) {
                   Text(track.name)
                       .font(.headline)
                       .lineLimit(1)
                       .bold()
                       .multilineTextAlignment(.leading)
                   
                   Text(track.artists[0].name)
                       .font(.subheadline)
                       .multilineTextAlignment(.leading)
               }

           }
           .listRowSeparator(.hidden, edges: .all)
           .padding(-5)
           
       }
}

