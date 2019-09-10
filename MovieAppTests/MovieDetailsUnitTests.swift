//
//  MovieDetailsUnitTests.swift
//  MovieAppTests
//
//  Created by Venugopal S A on 09/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import XCTest

class MovieDetailsUnitTests: XCTestCase {
    
    var viewModelToTest: MovieDetailsVM?
    var movieDetail: MovieDetails?
    var waitExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        let movieId = 429203
        viewModelToTest = MovieDetailsVM()
        viewModelToTest?.getMovieDetail(movieID: movieId) { (_) in
            self.movieDetail = self.viewModelToTest?.movieDetails
        }
        wait(duration: 6)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func wait(duration: TimeInterval) {
        waitExpectation = expectation(description: "wait")
        Timer.scheduledTimer(timeInterval: duration, target: self,
                             selector: #selector(onTimer), userInfo: nil, repeats: false)
        waitForExpectations(timeout: duration + 3, handler: nil)
    }
    
    @objc func onTimer() {
        waitExpectation?.fulfill()
    }
    
    func testMovieDetailTitle() {
        //Act
        guard let title = viewModelToTest?.movieDetails.original_title else {
            return
        }
        //Assert
        XCTAssertEqual(title, "The Old Man & the Gun")
    }
    
    func testMovieDetailReleaseDate() {
        //Act
        guard let releaseDate = viewModelToTest?.movieDetails.release_date else {
            return
        }
        //Assert
        XCTAssertEqual(releaseDate, "2018-09-27")
    }
    
    func testMovieDetailOverview() {
        //Act
        guard let overview = viewModelToTest?.movieDetails.overview else {
            return
        }
        //Assert
        XCTAssertEqual(overview, "The true story of Forrest Tucker, from his audacious escape from San Quentin at the age of 70 to an unprecedented string of heists that confounded authorities and enchanted the public. Wrapped up in the pursuit are a detective, who becomes captivated with Forrest’s commitment to his craft, and a woman, who loves him in spite of his chosen profession.")
    }
    
    func testMovieDetailVoteAverage() {
        //Act
        guard let voteAverage = viewModelToTest?.movieDetails.vote_average else {
            return
        }
        //Assert
        XCTAssertEqual(voteAverage, 6.3)
    }
    
    func testMovieDetailPosterPath() {
        //Act
        let fullPosterPath = viewModelToTest?.movieDetails.posterUrlString
        //Assert
        XCTAssertEqual(fullPosterPath!, "https://image.tmdb.org/t/p/w300/a4BfxRK8dBgbQqbRxPs8kmLd8LG.jpg")
    }
    
    func testMovieDetailGenre() {
        //Act
        guard let genre = viewModelToTest?.movieDetails.genres?[0].name else {
            return
        }
        //Assert
        XCTAssertEqual(genre, "Comedy")
    }
    
    
}

