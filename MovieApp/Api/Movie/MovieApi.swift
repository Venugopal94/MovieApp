//
//  MovieApi.swift
//  MovieApp
//
//  Created by Venugopal S A on 08/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import UIKit

typealias Params = [String: String]
typealias Response<T: Decodable> = (Result<T>) -> ()

class MovieApiService: NSObject {
    
}


enum Result<T> {
    case success(T)
    case error(ErrorModel)
}

struct Config {
    static let movieApiKey = "885c51f0e78055e8164c324b76fec8f9"
    static let baseUrl = "https://api.themoviedb.org"
}

extension MovieApiService: MovieService {
    func getMovieDetails(movteID: Int, completion: @escaping Response<MovieDetails>) {
        let request = Request(url: Endpoints.movie.movieDetails.value + "\(movteID)?")
        let params: Params = [
            "api_key": Config.movieApiKey,
            "language": "en-US"
        ]
        
        request.get(params: params) { (result: Result<MovieDetails>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
    
    
    
    func getNowPlayingMovies(page: Int, completion: @escaping Response<MoviesListResponse>) {
        let request = Request(url: Endpoints.movie.nowPlaying.value)
        let params: Params = [
            "api_key": Config.movieApiKey,
            "language": "en-US",
            "page": "\(page)"
        ]
        
        request.get(params: params) { (result: Result<MoviesListResponse>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
    
    func getPopularMovies(page: Int, completion: @escaping Response<MoviesListResponse>) {
        let request = Request(url: Endpoints.movie.popular.value)
        let params: Params = [
            "api_key": Config.movieApiKey,
            "language": "en-US",
            "page": "\(page)"
        ]
        
        request.get(params: params) { (result: Result<MoviesListResponse>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
    
    func getGenres(completion: @escaping Response<[Genre]>) {
        let request = Request(url: Endpoints.genre.all.value)
        let params: Params = [
            "api_key": Config.movieApiKey,
            "language": "en-US"
        ]
        
        request.get(params: params) { (result: Result<GenresResponse>) in
            
            switch result {
            case .success(let response):
                let genres = response.genres ?? []
                completion(.success(genres))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
}
