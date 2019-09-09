//
//  MovieDetailsUnitTests.swift
//  MovieAppTests
//
//  Created by Venugopal S A on 09/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import XCTest

class MovieDetailsUnitTests: XCTestCase {

    private var viewModelToTest =  MovieDetailsVM()
    
    override func setUp() {
        super.setUp()
        setupMovieGenres()
        let movieToTest = Movie(id: 1,
                                title: "Test 1",
                                genres: [],
                                genreIds: [1, 2],
                                overview: "Overview",
                                posterPath: "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                                backdropPath: "/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg",
                                releaseDate: "2019-02-01", voteAverage: 4.5)
        viewModelToTest = MovieDetailViewModel(movieToTest,
                                               managedObjectContext: context)
    }
    
    override func tearDown() {
        viewModelToTest = nil
        context = nil
        super.tearDown()
    }
    
    private func setupMovieGenres() {
        _ = Genre.with(id: 1, name: "Genre 1", context: context)
        _ = Genre.with(id: 2, name: "Genre 2", context: context)
    }
    
    func testMovieDetailTitle() {
        //Act
        let title = viewModelToTest.title
        //Assert
        XCTAssertEqual(title, "Test 1")
    }
    
    func testMovieDetailReleaseDate() {
        //Act
        let releaseDate = viewModelToTest.releaseDate
        //Assert
        XCTAssertEqual(releaseDate, "2019-02-01")
    }
    
    func testMovieDetailOverview() {
        //Act
        let overview = viewModelToTest.overview
        //Assert
        XCTAssertEqual(overview, "Overview")
    }
    
    func testMovieDetailVoteAverage() {
        //Act
        let voteAverage = viewModelToTest.voteAverage
        //Assert
        XCTAssertEqual(voteAverage, 4.5)
    }
    
    func testMovieDetailPosterPath() {
        //Act
        let fullPosterPath = viewModelToTest.posterURL
        //Assert
        XCTAssertEqual(fullPosterPath!, URL(string: "https://image.tmdb.org/t/p/w185/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }
    
    func testMovieDetailBackdropPath() {
        //Act
        let fullBackdropPath = viewModelToTest.backdropURL
        //Assert
        XCTAssertEqual(fullBackdropPath!, URL(string: "https://image.tmdb.org/t/p/w500/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg"))
    }
    
    func testMovieDetailGenre() {
        //Act
        let genre = viewModelToTest.genre
        //Assert
        XCTAssertEqual(genre!, "Genre 1")
    }


}
