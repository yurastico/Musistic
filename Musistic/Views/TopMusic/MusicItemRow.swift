//
//  MusicItemRow.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import SwiftUI

struct MusicItemRow: View {
    let track: Track
    
    var body: some View {
        HStack {
            AsyncImageContainer(url: URL(string: track.album.images.first!.url)!)
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
        //.frame(width: 25)
        
    }
    

}

#Preview {
    Text("Fazer preview depois")
}
