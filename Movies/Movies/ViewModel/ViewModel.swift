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
    
    //Get movies from CoreData
    func getMoviesFromCD(tableView: UITableView, controller: UIViewController) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        dataStore = DataStore()
        networkingService = NetworkingService()
        do {
            let moviesBase = try context.fetch(fetchRequest)
            
            if moviesBase.count == 0 {
                
                for page in 1...500 {
                    self.networkingService.fetchData(page: page, tableView: tableView) { results in
                        ///
                    }
                }
                
                self.networkingService.fetchData(page: 1, tableView: tableView) { [weak self] movies in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        movies.forEach { movieResult in
                            let movie = Movie(context: context)
                            movie.setValue(movieResult.originalTitle, forKey: "title")
                            movie.setValue(movieResult.overview, forKey: "overview")
                            movie.setValue( self.urlForImage + movieResult.posterPath, forKey: "photo")
                            tableView.reloadData()
                            self.movies.append(movie)
                        }
                    }
                }
            } else {
                if movies == moviesBase {
                    tableView.reloadData()
                } else {
                    
                    do {
                        let oldValues = try context.fetch(fetchRequest)
                        oldValues.forEach { context.delete($0) }
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    for page in 1...500 {
                        self.networkingService.fetchData(page: page, tableView: tableView) { results in
                            ///
                        }
                    }
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.movies.removeAll()
                        self.movies = self.dataStore.fetchMovies()
                        tableView.reloadData()
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - for TableViewDataSource
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> MovieCellViewModel? {
        
        let movie = movies[indexPath.row]
        
        return MovieCellViewModel(title: movie.value(forKey: "title") as! String, overview: movie.value(forKey: "overview") as! String, photoString: movie.value(forKey: "photo") as! String)
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

