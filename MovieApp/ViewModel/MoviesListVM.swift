//
//  MoviesListVM.swift
//  MovieApp
//
//  Created by Venugopal S A on 08/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import Foundation

class MoviesListVM {
    
    var popularMovies = [Movie]()
    var nowPlayingMovies = [Movie]()
    let movieService = MovieApiService()
    
    func getPolularMovies(page: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        movieService.getPopularMovies(page: page) {[weak self] result in
            switch result {
            case .success(let movies):
                guard let popularMovies = movies.results else {
                    return
                }
                self?.popularMovies.append(contentsOf: popularMovies)
                completion(true)
            case .error(_):
                completion(false)
            }
        }
    }
    
    func getNowPlayingMoview(page: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        movieService.getNowPlayingMovies(page: page) {[weak self] result in
            switch result {
            case .success(let movies):
                guard let popularMovies = movies.results else {
                    return
                }
                self?.nowPlayingMovies.append(contentsOf: popularMovies)
                completion(true)
            case .error(_):
                completion(false)
            }
        }
    }
}
