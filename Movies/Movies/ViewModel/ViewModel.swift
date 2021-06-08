//
//  ViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import Firebase
import CoreData

class ViewModel: NSObject {
    
    //MARK: - Constants
    let urlForImage = "https://image.tmdb.org/t/p/w300"
    let identifier = "movieCell"
    
    //MARK: - Properties
    private var networkingService: NetworkingService!
    private var dataStore: DataStore!
    
    var selectedIndexPath: IndexPath?
    
    var movies = [NSManagedObject]()
    
    func getMoviesFromCD() {
        networkingService = NetworkingService()
        dataStore = DataStore()
        networkingService.fetchData()
        if movies.count == 0 {
            movies = dataStore.fetchMovies()
        } else {
            networkingService.fetchData()
        }
    }
    
    //MARK: - for TableViewDataSource
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> MovieCellViewModel? {
        
        let movie = movies[indexPath.row]
        
        let photoPath = movie.value(forKey: "photo") as! String
        
        return MovieCellViewModel(title: movie.value(forKey: "title") as! String, overview: movie.value(forKey: "overview") as! String, photoString: urlForImage + photoPath)
    }
    
    //MARK: - for TableViewDelegate
    func heightForRowAt() -> CGFloat {
        return 150.0
    }
    
    func viewModelForSelectedRow() -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        let movie = movies[selectedIndexPath.row]
        return DetailViewModel(name: movie.value(forKey: "title") as! String, overview: movie.value(forKey: "overview") as! String, photo: movie.value(forKey: "photo") as! String)
    }
    
    func selectedRowAt(_ indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
}

