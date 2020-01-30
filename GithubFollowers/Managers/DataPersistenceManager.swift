//
//  DataPersistenceManager.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/30/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

struct DataPersistenceManager {
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    enum PersistenceAction {
        case add, remove
    }

    
    //get location to user defaults
    static private let defaults = UserDefaults.standard
    
    
    static func updateFavoritesWith(favorite: Follower, action: PersistenceAction, completion: @escaping (GFError?) -> Void) { getSavedFavorites { result in
                
            switch result {
            case .success(let favorites):
                var savedFavorites = favorites
                
                switch action {
                case .add:
                    guard !savedFavorites.contains(favorite) else {
                        completion(.favoriteExists)
                        return
                    }
                    
                    savedFavorites.append(favorite)
                    
                case .remove:
                    savedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completion(save(favorites: savedFavorites))
            
            case .failure(let error):
                completion(error)
            }
        }
    }
    

    static func getSavedFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let data = defaults.object(forKey: "favorites") as? Data else {
            
            //return empty array in case first time accessing favorites Follower arrray
            completion(.success([]))
            return
        }
        
        //otherwise access favorite array contents and decode
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: data)
            completion(.success(favorites))
            
        } catch {
            completion(.failure(.unableToGetFavorite))
        }
    }
    
    
    static func save(favorites data: [Follower]) -> GFError? {
        
        //encode favorites as data, save data to userDefaults
        do {
            let encoder = JSONEncoder()
            let favorites = try encoder.encode(data)
            defaults.set(favorites, forKey: Keys.favorites)
            
            return nil
            
        } catch {
            return .unableToAddFavorite
        }
    }
}
