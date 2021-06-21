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
    
    private var selectedIndexPath: IndexPath?
    
    private var movies = [NSManagedObject]()
    
    private var totalPage = 1
    
    func getFirstData(tableView: UITableView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        NetworkingService().fetchData(page: 1, tableView: tableView) { [weak self] movies in
            guard let self = self else { return }
            movies.forEach { movieResult in
                let movie = Movie(context: context)
                movie.title = movieResult.originalTitle
                movie.overview = movieResult.overview
                movie.photo = self.urlForImage + movieResult.posterPath
                self.movies.append(movie)
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView, tableView: UITableView) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        guard let _ = try? context.fetch(fetchRequest) else { return }
        
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            totalPage += 1
            
            if totalPage < 1000 {
                print("This is page number: \(totalPage)")
                    NetworkingService().fetchData(page: self.totalPage, tableView: tableView) { movies in
                        
                        movies.forEach { movieResult in
                            let movie = Movie(context: context)
                            movie.title = movieResult.originalTitle
                            movie.overview = movieResult.overview
                            movie.photo = self.urlForImage + movieResult.posterPath
                            self.movies.append(movie)
                        }
                    }
                //DispatchQueue.main.async {
                    tableView.reloadData()
                //}
            } else {
                return
            }
        }
    }
}

