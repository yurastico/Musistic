//
//  TrackDetailViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 07/02/24.
//

import Foundation
import Observation

@Observable
final class TrackDetailViewModel {
    var artist: Artist?
    var track: Track?
    
    func getArtist(for track: Track) async {
        
        let response = await ArtistDataService().fetchArtist(artistId: track.artists.first!.id)
        self.artist = response
        self.track = track
    }

}
