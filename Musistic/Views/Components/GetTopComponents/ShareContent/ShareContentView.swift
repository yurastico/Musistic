//
//  ShareContentView.swift
//  Musistic
//
//  Created by Yuri Cunha on 30/01/24.
//

import SwiftUI

struct ShareContentView: View {
    @Binding var imageToShow: Image?
    @State private var isLoadingImage = true
    var body: some View {
        VStack {
            if !isLoadingImage {
                TabView {
                    imageToShow?
                        .resizable()
                        .scaledToFit()
                    imageToShow?
                        .resizable()
                        .scaledToFit()
                    imageToShow?
                        .resizable()
                        .scaledToFit()
                    imageToShow?
                        .resizable()
                        .scaledToFit()
                    imageToShow?
                        .resizable()
                        .scaledToFit()
                }.tabViewStyle(.page(indexDisplayMode: .always))
                
            } else {
                ProgressView()
            }
            
        }.onChange(of: imageToShow) {
            isLoadingImage = false
        }
    }
}

#Preview {
    ShareContentView(imageToShow: .constant(nil))
}
