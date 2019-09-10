//
//  MovieService.swift
//  MovieApp
//
//  Created by Venugopal S A on 08/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import Foundation

protocol MovieService {
    func getPopularMovies(page: Int, completion: @escaping Response<MoviesListResponse>)
    func getGenres(completion: @escaping Response<[Genre]>)
    func getNowPlayingMovies(page: Int, completion: @escaping Response<MoviesListResponse>)
    func getMovieDetails(movteID: Int, completion: @escaping Response<MovieDetails>)
}
