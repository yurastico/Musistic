//
//  PkceManager.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/02/24.
//

import Foundation
import CryptoKit
struct PkceManager {
    let codeVerifier: String
    let codeChallanger: String
    
    static let shared = try? PkceManager()
    
    private init() throws {
        self.codeVerifier = PkceManager.generateRandomString(length: 64)
        self.codeChallanger = try PkceManager.codeChallenge(fromVerifier: codeVerifier)
    }
    
    
    static func codeChallenge(fromVerifier verifier: String) throws -> String {
            
            guard let verifierData = verifier.data(using: .ascii) else { fatalError() }
            
            let challengeHashed = SHA256.hash(data: verifierData)
            let challengeBase64Encoded = Data(challengeHashed).base64URLEncodedString
            
            return challengeBase64Encoded
        }
    
    
    static private func generateRandomString(length: Int = 64) -> String {
        do {
            
            guard let rando = try PkceManager.generateCryptographicallySecureRandomOctets(count: 64) else { fatalError()}
            return Data(bytes: rando, count: rando.count).base64URLEncodedString
            
        } catch {
            
           fatalError()
        }
        
        
//        let randomString = (0..<length).map { _ in characters.randomElement()! }
//        return String(randomString)
    }
    
    
    private static func generateCryptographicallySecureRandomOctets(count: Int) throws -> [UInt8]? {
            
            var octets = [UInt8](repeating: 0, count: count)
            let status = SecRandomCopyBytes(kSecRandomDefault, octets.count, &octets)
            
            if status == errSecSuccess {
                
                return octets
                
            } else {
                
                return nil
            }
        }
}

extension Data {
    
    ///
    /// Returns a Base64 URL-encoded string _without_ padding.
    ///
    /// This string is compatible with the PKCE Code generation process, and uses the algorithm as defined in the [PKCE standard](https://datatracker.ietf.org/doc/html/rfc7636#appendix-A).
    ///
    var base64URLEncodedString: String {
    
        base64EncodedString()
            .replacingOccurrences(of: "=", with: "") // Remove any trailing '='s
            .replacingOccurrences(of: "+", with: "-") // 62nd char of encoding
            .replacingOccurrences(of: "/", with: "_") // 63rd char of encoding
            .trimmingCharacters(in: .whitespaces)
    }
}
