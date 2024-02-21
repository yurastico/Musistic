//
//  ShareItemView.swift
//  Musistic
//
//  Created by Yuri Cunha on 27/01/24.
//

import SwiftUI

struct ShareItemView<T: ContentForRender>: View {
    var tracks: [T]
    var body: some View {

        VStack(alignment: .leading) {
            Text("Your most listened songs!")
                .font(.largeTitle)
            ForEach(tracks.dropFirst(10)) { track in
                HStack {
                    transformDataIntoImage(content: track)?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(track.title ?? "")
                        Text(track.subtitle ?? "")
                    }
                    Spacer()
                    
                }
            }
        }
    }
    
    private func transformDataIntoImage(content: T) -> Image? {
        guard let uiImage = UIImage(data: content.image!) else { return nil }
        return Image(uiImage: uiImage)
    }
}
