//
//  SkeletonView.swift
//  Musistic
//
//  Created by Yuri Cunha on 22/01/24.
//

import SwiftUI

struct SkeletonView: View {
   
    var body: some View {
        VStack(spacing: 4) {
            ForEach(0..<1,id: \.self) { index in
                    SkeletonRow()
            }
            .listRowSeparator(.hidden, edges: .all)
            .padding(-5)
        }
    }
}

struct SkeletonRow: View {
    private var placeholderString = "********************"
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                LinearGradient(gradient: Gradient(colors: [.gray,.white,.gray]), startPoint: .leading, endPoint: .trailing)
                    .mask {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 60,height: 60,alignment: .leading)
                            .redectedAnimation()
                        
                    }
                    .frame(width: 60,height: 60)
                
                VStack(alignment: .leading, spacing: 8) {
                    LinearGradient(gradient: Gradient(colors: [.gray,.white,.gray]), startPoint: .leading, endPoint: .trailing)
                        .mask {
                            Text(placeholderString)
                                .redacted(reason: .placeholder)
                                .redectedAnimation()
                        }
                    LinearGradient(gradient: Gradient(colors: [.gray,.white,.gray]), startPoint: .leading, endPoint: .trailing)
                        .mask {
                            Text(placeholderString)
                                .redacted(reason: .placeholder)
                                .redectedAnimation()
                        }
                }
            }
        }
    }
}


#Preview {
    SkeletonView()
}
