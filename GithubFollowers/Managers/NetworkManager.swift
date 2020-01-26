//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/24/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/"
    
    private init() {
        
    }
    
    //completion type using Swift 5's new result type
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let usernameUrl = "users/\(username)/followers"
        let pageUrl = "?per_page=100&page=\(page)"
        let fullUrl = baseURL+usernameUrl+pageUrl
//        print("\(fullUrl)/n")
        
        guard let url = URL(string: fullUrl) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //handle error cases
            //random network error
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            //bad http response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200  else {
                completion(.failure(.invalidResposne))
                return
            }
            
            //bad data returned
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
                
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func getImage(from urlString: String, completion: @escaping(UIImage?) -> Void) {
        
        //load image from imageCache (if already saved)
        let imageCacheKey = NSString(string: urlString)
        if let image = CacheManager.shared.imageCache.object(forKey: imageCacheKey) {
            completion(image)
            return
        }
        
        //run get image if image not in imageCache
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            //check for error, and if so print error and exit method
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }

            //check for server response code 200, else bail out
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }

            //check for data and assign to image
            if let data = data {
                guard let image = UIImage(data: data) else { return }

                //save image to imageCache (using its urlString as the key)
                CacheManager.shared.imageCache.setObject(image, forKey: imageCacheKey)

                //pass image
                completion(image)
            }
        }

        task.resume()
    }
}
