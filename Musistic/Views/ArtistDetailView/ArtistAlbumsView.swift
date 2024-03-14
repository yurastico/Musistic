//
//  ArtistAlbumsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 14/02/24.
//

import SwiftUI

struct ArtistAlbumsView: View {
    @State private var isShowingImage = false
    @Binding var albuns: [Album]
    var body: some View {
        TabView {
            ForEach(albuns) { album in
                if let url = URL(string: album.images.first!.url) {
                    VStack {
                        AsyncImageContainerView(url: url)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                isShowingImage = true
                            }
                        Text(album.name)
                    }
                    .sheet(isPresented: $isShowingImage) {
                        HStack {
                            AsyncImageContainerView(url: url)
                        }
                        .background(.black)
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
    ArtistAlbumsView(albuns: .constant([]))
}
