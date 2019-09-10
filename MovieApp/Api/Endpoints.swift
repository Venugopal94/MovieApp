//
//  Endpoints.swift
//  MovieApp
//
//  Created by Venugopal S A on 08/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import UIKit

fileprivate protocol Endpoint {
    var endpoint: String { get }
    var value: String { get }
}

enum Endpoints {
    fileprivate static var version: Int = 3
    fileprivate static var baseUrl: String { return "\(Config.baseUrl)/\(Endpoints.version)" }
    
    enum movie: Endpoint {
        internal var endpoint: String { return "movie"}
        case popular
        case nowPlaying
        case movieDetails
        
        var value: String {
            switch self {
            case .popular: return "\(Endpoints.baseUrl)/\(endpoint)/popular"
            case .nowPlaying: return "\(Endpoints.baseUrl)/\(endpoint)/now_playing"
            case .movieDetails: return "\(Endpoints.baseUrl)/\(endpoint)/"
            }
        }
    }
    
    enum genre: Endpoint {
        internal var endpoint: String { return "genre" }
        
        case all
        
        var value: String {
            switch self {
            case .all: return "\(Endpoints.baseUrl)/\(endpoint)/movie/list"
            }
        }
    }
    
}
