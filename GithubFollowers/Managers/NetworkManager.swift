//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/24/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/"
    
    private init() {
        
    }
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let usernameUrl = "users/\(username)/followers"
        let pageUrl = "?per_page=100&page=\(page)"
        let fullUrl = baseURL+usernameUrl+pageUrl
//        print("\(fullUrl)/n")
        
        guard let url = URL(string: fullUrl) else {
            completion(nil, "This username created an invalid request.\nPlease try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //handle error cases
            //random network error
            if let _ = error {
                completion(nil, "Unable to complete request. Please check internet connection.")
                return
            }
            
            //bad http response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200  else {
                completion(nil, "Invalid response from server. Please try again.")
                return
            }
            
            //bad data returned
            guard let data = data else {
                completion(nil, "Data from server was invalid. Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
                
            } catch {
                completion(nil, "Data from server was invalid. Please try again.")
            }
        }
        
        task.resume()
    }
    
    
    
}
