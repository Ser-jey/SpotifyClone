//
//  AuthManager.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 05.01.2023.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    private var refreshingToken = false
    
    struct Constans {
        static let clientID = "0f5f5e6797fb4bc0a09c05369487ee7c"
        static let clientSecret = "5b89090c8d314b6f9972d08d69e93d58"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURL = "https://www.iosacademy.io"
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"

    }
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constans.clientID)&scope=\(Constans.scopes)&redirect_uri=\(Constans.redirectURL)&show_dialog=TRUE"
        
        return URL(string: string)
    }
    
    private init() {}
    
    var isSigned: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        
        guard let url = URL(string: Constans.tokenAPIURL) else {
            print("Failed to make url")
            completion(false)
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
        URLQueryItem(name: "grant_type", value: "authorization_code"),
        URLQueryItem(name: "code", value: code),
        URLQueryItem(name: "redirect_uri", value: Constans.redirectURL)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constans.clientID+":"+Constans.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("ERROR: to get data")
                completion(false)
                return }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                print("SUCCESS: \(result)")
                completion(true)
            } catch {
                print("ERROR: \(error.localizedDescription)")
                completion(false)
            }
                
        }.resume()
    }
    
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    /// Supplies valid token to be used with API Calls
    /// - Parameter completion: Access Token
    public func withValidToken(completion: @escaping (String) -> Void ) {
        print(shouldRefreshToken)
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            refreshIfNeeded { [weak self] success in
                
                if let token = self?.accessToken, success  {
                  completion(token)
                }
            }
        }
        else {
            if let token = accessToken {
                completion(token)
                return
            }
        }
    }
    
    public func refreshIfNeeded(completion: @escaping (Bool) -> Void) {
        guard !refreshingToken else {
            return
        }
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        guard let refreshToken = self.refreshToken else { return }

        guard let url = URL(string: Constans.tokenAPIURL) else {
            print("Failed to make url")
            completion(false)
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
        URLQueryItem(name: "grant_type", value: "refresh_token"),
        URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constans.clientID+":"+Constans.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            print("start refteshing token")
            print(request.description)
            self?.refreshingToken = false
            guard let data = data, error == nil else {
                print("ERROR: to get data")
                completion(false)
                return }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.onRefreshBlocks.forEach{ $0(result.access_token) }
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result: result)
                print("SUCCESS: \(result)")
                completion(true)
            } catch {
                print("ERROR: \(error.localizedDescription) ooooo")
                completion(false)
            }
                
        }.resume()
        
    }
    
    public func cacheToken(result: AuthResponse) {
        
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refreshToken = refreshToken {
            UserDefaults.standard.setValue(refreshToken, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")

    }
    
}
