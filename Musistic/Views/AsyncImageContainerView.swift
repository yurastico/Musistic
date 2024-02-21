//
//  AsyncImageContainer.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import SwiftUI

struct AsyncImageContainerView: View {
    let url: URL
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    AsyncImageContainerView(url: URL(string: "")!)
}
