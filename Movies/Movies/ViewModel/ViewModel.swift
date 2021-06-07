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
    
    var selectedIndexPath: IndexPath?
    
    var movies = [NSManagedObject]()
    
    func getMoviesFromFB() {
        networkingService = NetworkingService()
        networkingService.fetchData()
        if movies.count == 0 {
            networkingService.fetchData()
            fetchMovies()
        } else {
            fetchMovies()
        }
    }
    
    // Get movies from CoreData
    func fetchMovies() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        do {
            let movies = try context.fetch(fetchRequest)
            self.movies = movies
        } catch {
            print(error.localizedDescription)
        }
    }
    // Exit from movie app
    func exitAction() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func showExitAlert(title: String, massage: String, controller: UIViewController) {
        let alertVC = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let alertActionOne = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.exitAction()
        }
        let alertActionTwo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertVC.addAction(alertActionOne)
        alertVC.addAction(alertActionTwo)
        controller.present(alertVC, animated: true, completion: nil)
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

