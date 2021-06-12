//
//  FavoriteViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit
import CoreData
import Firebase

class FavoriteViewModel {
    
    //MARK: - Constants
    let identifier = "favoriteCell"
    let urlForImage = "https://image.tmdb.org/t/p/w300"
    
    //MARK: - Properties
    private var movies = [MovieDatabase]()
    
    // RegisterCell
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    //MARK: - UITableViewDataSource
    func cellForRowAt(_ indexPath: IndexPath) -> FavoriteCellViewModel? {
        
        let movie = movies[indexPath.row]
        guard let photoURL = movie.photo else { return nil }
        return FavoriteCellViewModel(photoImageView: urlForImage + photoURL, nameLabel: movie.title ?? "N/A", overview: movie.overview ?? "Not found")
    }
    
    func numberOfRows() -> Int {
        
        return movies.count
    }
    
    //MARK: - UITableViewDelegate
    func heightForRowAt() -> CGFloat {
        return 110.0
    }
    // Delete the movie from firebase and from array
    func commitEditingStyle(style: UITableViewCell.EditingStyle, indexPath: IndexPath, tableView: UITableView) {
        if style == .delete {
            guard let user = Auth.auth().currentUser else { return }
            guard let title = movies[indexPath.row].title else { return }
            Database.database().reference().child("users").child(user.uid).child("favourites").child(title).removeValue { error, ref in
                if error != nil {
                    print(error as Any)
                }
            }
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Load data from Firebase
    func loadDataFromFirebase(tableView: UITableView) {
        
        guard let user = Auth.auth().currentUser else {
            movies.removeAll()
            tableView.reloadData()
            return
        }
        
        let refMovies = Database.database().reference(withPath: "users").child(user.uid).child("favourites")
        
        refMovies.observe(.value) { [weak self] snapshot in
            
            var _movies = Array<MovieDatabase>()
            
            for movie in snapshot.children {
                
                let movie = MovieDatabase(snapshot: movie as! DataSnapshot)
                
                _movies.append(movie)
            }
            self?.movies = _movies
            tableView.reloadData()
        }
    }
}
