//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Venugopal S A on 08/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import Foundation

class MovieDetails: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var budget: Int?
    var genres: [Genre]?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var poster_path: String?
    var runtime: Int?
    var release_date: String?
    var vote_average: Double?
    var vote_count:Int?
    
    var formattedReleaseDate: Date? {
        if let releaseDate = release_date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            return dateFormatter.date(from: releaseDate)
        }
        return nil
    }
    
    var releaseYear: String? {
        if let date = formattedReleaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    var posterUrlString: String? {
        if let posterPath = poster_path {
            return "https://image.tmdb.org/t/p/w300\(posterPath)"
        }
        return nil
    }
}
