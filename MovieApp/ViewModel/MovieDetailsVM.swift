//
//  MovieDetailsVM.swift
//  MovieApp
//
//  Created by Venugopal S A on 08/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import Foundation

class MovieDetailsVM {
    
    let movieApiService = MovieApiService()
    var movieDetails = MovieDetails()
    
    func getMovieDetail(movieID: Int, completion: @escaping (_ isSuccess: Bool) -> Void)  {
        movieApiService.getMovieDetails(movteID: movieID) { (result) in
            switch result {
            case .success(let movieDetails):
                self.movieDetails = movieDetails
                completion(true)
            case .error(_):
                completion(false)
            
            }
        }
    }
}
