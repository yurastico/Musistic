//
//  GetTopContentView.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI

struct TopContentListView<Content: View>: View {
    @State private var timeRange: TimeRange = .mediumTerm
    @State private var path = NavigationPath()
    @State private var isShowingSnackBar = false
    @State private var errorMessage = ""
    @State private var list = [Artist]()
    @ViewBuilder var content: Content
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                List {
                    content
                }
                .listStyle(.plain)
                .navigationTitle("Top Artists")
                .navigationDestination(for: ArtistNavigationType.self) { type in
                    switch type {
                    case .artistDetail(let artist):
                        TopArtistDetail(artist: artist)
                    }
                }
                .toolbar {
                    Picker("Term", selection: $timeRange) {
                        ForEach(TimeRange.allCases,id: \.self) { range in
                            Text(range.rawValue)
                        }
                    }
                    .onChange(of: timeRange) {
                        Task {
                            await readAllData()
                        }
                    }
                }
                if isShowingSnackBar {
                    SnackBarErrorView(isShowing: $isShowingSnackBar, message: errorMessage)
                }
            }
            
        }
        .onAppear {
            Task {
                await readAllData()
            }
        }
    }
    func readAllData() async {
        
    }
}

#Preview {
    TopContentListView {
        Text("oiii")
    }
}
