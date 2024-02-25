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
    
    private var accessToken: String?
    var expiresIn: TimeInterval?
    var refreshToken: String?
    
    var alwaysValidAcessToken: String? {
        guard let token = accessToken else { return nil }
        if isAccessTokenValid() {
            return token
        }
        self.refreshAcessToken()
        guard let token = accessToken else { return nil}
        return token
        
    }
    
    private func refreshAcessToken() {
        let service = AuthenticationService()
        Task {
            let result = await service.refreshToken()
            switch result {
            case .success(let token):
                self.saveCredentials(for: token)
            case .failure(let error):
                print(error)
                print("error to save accessToken")
            }
        }
    }
    
    
    private init() {
        self.accessToken = KeychainHelper.get(for: Self.acessTokenKey)
        self.expiresIn = KeychainHelper.get(for: Self.expiresInKey)
        self.refreshToken = KeychainHelper.get(for: Self.refreshTokenKey)
    }
    
    func saveCredentials(for credentials: AccessTokenResponse) {
        Task {
            let expiresInTimeInterval = Date.now.timeIntervalSince1970 + TimeInterval(credentials.expiresIn)
            KeychainHelper.save(value: credentials.accessToken,key: Self.acessTokenKey)
            if credentials.refreshToken != nil {
                guard let refreshToken = credentials.refreshToken else { return }
                KeychainHelper.save(value: refreshToken, key: Self.refreshTokenKey)
            }
            KeychainHelper.save(value: "\(expiresInTimeInterval)", key: Self.expiresInKey)
            DispatchQueue.main.async {
                self.expiresIn = expiresInTimeInterval
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
    
    func isAccessTokenValid() -> Bool {
        guard let expiresIn = self.expiresIn else { return false}
       
        return Date.now < Date(timeIntervalSince1970: expiresIn)
    }
    
    
}
