//
//  ViewController.swift
//  MovieApp
//
//  Created by Venugopal S A on 08/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListViewController: UIViewController, UIScrollViewDelegate {
    
    enum MovieListType: Int {
        case popular = 0
        case nowPlaying
    }
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var movieListTableView: UITableView!
    
    let moviesListVM = MoviesListVM()
    var popularMoviesPage = 1
    var nowplayingMoviesPage = 1
    var movieListType = MovieListType.popular
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListTableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        getNowPlayingMovies(page: nowplayingMoviesPage)
        getPopularMovies(page: popularMoviesPage)
    }
    
    func getPopularMovies(page: Int) {
        loaderView.isHidden = false
        moviesListVM.getPolularMovies(page: page) {[weak self] (isSuccess) in
            DispatchQueue.main.async {
                self?.loaderView.isHidden = true
                if isSuccess {
                    self?.movieListTableView.reloadData()
                }
            }
        }
    }
    
    func getNowPlayingMovies(page: Int) {
        
        moviesListVM.getNowPlayingMoview(page: page) {[weak self] (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.movieListTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        movieListType = MovieListType(rawValue: sender.selectedSegmentIndex) ?? .popular
        movieListTableView.reloadData()
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieListType == .popular ? moviesListVM.popularMovies.count : moviesListVM.nowPlayingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataSource = movieListType == .popular ? moviesListVM.popularMovies : moviesListVM.nowPlayingMovies
        let count = dataSource.count
        var page =  movieListType == .popular ? popularMoviesPage : nowplayingMoviesPage
        if indexPath.row == count - 1 {
            page += 1
            movieListType == .popular ? getPopularMovies(page: page) : getNowPlayingMovies(page: page)
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }
        
        cell.moviePoster.sd_setImage(with: URL(string: dataSource[indexPath.row].posterUrlString ?? ""), placeholderImage: UIImage(named: ""))
        cell.title.text = dataSource[indexPath.row].title
        cell.rating.text = "Rating: \(dataSource[indexPath.row].voteAverage ?? 0.0)/10"
        cell.numberOfVotes.text = "Number of Votes: \(dataSource[indexPath.row].voteCount ?? 0)"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToMovieDetails(indexPath: indexPath)
    }
    
    func navigateToMovieDetails(indexPath: IndexPath) {
        guard let movieDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        let dataSource = movieListType == .popular ? moviesListVM.popularMovies : moviesListVM.nowPlayingMovies
        movieDetailVC.movieId = dataSource[indexPath.row].id
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
}

