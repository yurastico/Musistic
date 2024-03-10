//
//  ArtistPhotoView.swift
//  Musistic
//
//  Created by Yuri Cunha on 14/02/24.
//

import SwiftUI

struct ArtistPhotoView: View {
    @State private var isShowingPhoto = false
    let artist: Artist
    var body: some View {
        VStack(spacing: 0) {
            
            if let path = artist.images?.first?.url,
               let url = URL(string: path) {
                AsyncImageContainerView(url: url)
                    .clipShape(Circle())
                    .onTapGesture {
                        isShowingPhoto = true
                    }
                    
                    .sheet(isPresented: $isShowingPhoto) {
                        HStack {
                            AsyncImageContainerView(url: url)
                        }
                        .background(.black)
                        
                            
                    }
                
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
