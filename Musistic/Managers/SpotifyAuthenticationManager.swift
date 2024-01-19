//
//  SpotifyAuthenticationManager.swift
//  Musistic
//
//  Created by Yuri Cunha on 19/01/24.
//

import Foundation
import Observation

@Observable
final class SpotifyAuthenticationManager {
    static let shared = SpotifyAuthenticationManager()
    private static let acessTokenKey = "musistic-spotify-accessToken"
    private static let refreshTokenKey = "musistic-spotify-refreshToken"
    private static let expiresInKey = "musistic-spotify-expiresIn"
    
    var accessToken: String?
    var expiresIn: TimeInterval?
    var refreshToken: String?
    
    private init() {
        self.accessToken = KeychainHelper.get(for: Self.acessTokenKey)
        self.expiresIn = KeychainHelper.get(for: Self.expiresInKey)
        self.refreshToken = KeychainHelper.get(for: Self.refreshTokenKey)
    }
    
    func saveCredentials(for credentials: AccessTokenResponse) {
        Task {
            KeychainHelper.save(value: credentials.accessToken,key: Self.acessTokenKey)
            KeychainHelper.save(value: credentials.refreshToken, key: Self.refreshTokenKey)
            KeychainHelper.save(value: "\(credentials.expiresIn)", key: Self.expiresInKey)
            DispatchQueue.main.async {
                self.expiresIn = TimeInterval(credentials.expiresIn)
                self.accessToken = credentials.accessToken
                self.refreshToken = credentials.refreshToken
            }
        }
    }
    
    func removeCredentials() {
        Task {
            KeychainHelper.remove(for:Self.acessTokenKey)
            KeychainHelper.remove(for: Self.expiresInKey)
            KeychainHelper.remove(for: Self.refreshTokenKey)
            DispatchQueue.main.async {
                self.accessToken = nil
                self.refreshToken = nil
                self.expiresIn = nil
            }
        }
    }
    
    
    
}
