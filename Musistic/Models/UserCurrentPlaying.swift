//
//  UserCurrentPlaying.swift
//  Musistic
//
//  Created by Yuri Cunha on 04/02/24.
//

import Foundation

struct SpotifyData: Codable {

    struct Restrictions: Codable {
        let reason: String
    }


    struct LinkedFrom: Codable {}

    struct RestrictionsTrack: Codable {
        let reason: String
    }


    struct Actions: Codable {
        let interruptingPlayback: Bool
        let pausing: Bool
        let resuming: Bool
        let seeking: Bool
        let skippingNext: Bool
        let skippingPrev: Bool
        let togglingRepeatContext: Bool
        let togglingShuffle: Bool
        let togglingRepeatTrack: Bool
        let transferringPlayback: Bool
    }

    struct SpotifyContext: Codable {
        let type: String
        let href: String
        let externalUrls: ExternalUrls
        let uri: String
    }

    let device: Device
    let repeatState: String
    let shuffleState: Bool
    let context: SpotifyContext
    let timestamp: Int
    let progressMs: Int
    let isPlaying: Bool
    let item: Track
    let currentlyPlayingType: String
    let actions: Actions
}
