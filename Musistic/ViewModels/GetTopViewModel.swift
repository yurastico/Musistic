//
//  GetTopViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 22/01/24.
//

import Foundation
import Observation

@Observable
final class GetTopViewModel {
    var tracks = [Track]()
    
    
    func refreshTracks(for range: TimeRange) async {
        
        let result = await GetTopService().fetchTop(for: Track.self,timeRange: range)
        switch result {
        case .success(let tracks):
            self.tracks = tracks.items
        case .failure(let error):
            print(error)
        }
    }
    
}
