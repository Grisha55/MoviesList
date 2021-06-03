//
//  FavoriteViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit

class FavoriteViewModel {
    
    //MARK: - Constants
    let identifier = "favoriteCell"
    
    //MARK: - Properties
    private var movies: [Movie]?
    
    //MARK: - Get data from coreData
    func fetchData() {
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            movies = try context.fetch(Movie.fetchRequest())
            print(movies as Any)
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
        return FavoriteCellViewModel(photoImageView: UIImageView(), nameLabel: movies[indexPath.row].name ?? "N/A")
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
