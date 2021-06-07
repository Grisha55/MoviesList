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
    
    // Get data from coreData
    /*func fetchDataCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        do {
            //movies = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }*/
    
    // RegisterCell
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    //MARK: - UITableViewDataSource
    func cellForRowAt(_ indexPath: IndexPath) -> FavoriteCellViewModel? {
        
        let movies = movies
        let movie = movies[indexPath.row]
        guard let photoURL = movie.photo else { return nil }
        guard let url = URL(string: "\(urlForImage)\(photoURL)") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return FavoriteCellViewModel(photoImageView: UIImageView(image: UIImage(data: data)), nameLabel: movie.title ?? "N/A")
    }
    
    func numberOfRows() -> Int {
        //guard let movies = movies else { return 0 }
        return movies.count
    }
    
    //MARK: - UITableViewDelegate
    func heightForRowAt() -> CGFloat {
        return 150.0
    }
    
    // Load data from Firebase
    func loadDataFromFirebase(tableView: UITableView) {
        
        guard let user = Auth.auth().currentUser else { return }
        
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
