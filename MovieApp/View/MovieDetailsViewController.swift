//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Venugopal S A on 08/09/19.
//  Copyright © 2019 Venugopal S A. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    let movieDetailVM = MovieDetailsVM()
    var movieId: Int?
    
    enum MovieDetails: Int, CaseIterable {
        case genre = 0
        case overview
        case runTime
        case rating
        case numberVotes
        
        var title: String {
            switch self {
                
            case .genre:
                return  "Genre"
            case .overview:
                return "Overview"
            case .runTime:
                return "Run Time"
            case .rating:
                return "Rating"
            case .numberVotes:
                return "Number Votes"
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.register(UINib(nibName: "MovieDetailCell", bundle: nil), forCellReuseIdentifier: "MovieDetailCell")
        getMovieDetails()
    }
    
    func getMovieDetails()  {
        guard let movieID = movieId else {
            return
        }
        movieDetailVM.getMovieDetail(movieID: movieID) {[weak self] (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.detailsTableView.reloadData()
                    self?.posterImage.sd_setImage(with: URL(string: self?.movieDetailVM.movieDetails.posterUrlString ?? ""), placeholderImage: UIImage(named: ".png"))
                }
            }
        }
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieDetails.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as? MovieDetailCell, let infoType = MovieDetails(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        cell.title.text = infoType.title
        switch infoType {
            
        case .genre:
            movieDetailVM.movieDetails.genres?.forEach({ (genre) in
                cell.descriptiion.text = genre.name + " "
            })
        case .overview:
            cell.descriptiion.text = movieDetailVM.movieDetails.overview
        case .runTime:
            cell.descriptiion.text = "\(movieDetailVM.movieDetails.runtime ?? 0)"
        case .rating:
            cell.descriptiion.text = "\(movieDetailVM.movieDetails.vote_average ?? 0)" + "/" + "10"
        case .numberVotes:
            cell.descriptiion.text = "\(movieDetailVM.movieDetails.vote_count ?? 0)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
