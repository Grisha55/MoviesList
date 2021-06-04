//
//  FavoriteViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit
import CoreData

class FavoriteViewModel {
    
    //MARK: - Constants
    let identifier = "favoriteCell"
    let urlForImage = "https://image.tmdb.org/t/p/w300"
    
    //MARK: - Properties
    private var movies: [NSManagedObject]?
    
    //MARK: - Get data from coreData
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext // Error
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        do {
            movies = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - RegisterCell
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    //MARK: - UITableViewDataSource
    func cellForRowAt(_ indexPath: IndexPath) -> FavoriteCellViewModel? {
        
        guard let movies = movies else { return nil }
        let movie = movies[indexPath.row]
        guard let photoURL = movie.value(forKey: "photo") else { return nil }
        guard let url = URL(string: "\(urlForImage)\(photoURL)") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return FavoriteCellViewModel(photoImageView: UIImageView(image: UIImage(data: data)), nameLabel: movie.value(forKey: "name") as? String ?? "N/A")
    }
    
    func numberOfRows() -> Int {
        guard let movies = movies else { return 0 }
        return movies.count
    }
    
    //MARK: - UITableViewDelegate
    func heightForRowAt() -> CGFloat {
        return 150.0
    }
}
