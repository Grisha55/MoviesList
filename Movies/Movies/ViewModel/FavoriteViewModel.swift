//
//  FavoriteViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit

class FavoriteViewModel {
    
    private var movies: [Movie]?
    
    func numberOfRows() -> Int {
        guard let movies = movies else { return 0 }
        return movies.count
    }
    
    //MARK: - Get data from coreData
    func fetchData() {
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            movies = try context.fetch(Movie.fetchRequest())
            print(movies)
        } catch {
            print(error.localizedDescription)
        }
    }
    //MARK: - UITableViewDataSource
    func cellForRowAt(tableView: UITableView) -> UITableViewCell? {
        return UITableViewCell()
    }
}
