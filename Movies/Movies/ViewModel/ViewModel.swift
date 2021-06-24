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
    
    static var totalPage = 1
    
    func getFirstData(tableView: UITableView) {
        
        if ViewModel.totalPage == 1 {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
            guard let _ = try? context.fetch(fetchRequest) else { return }
            DispatchQueue.main.async {
                NetworkingService().fetchData(page: 1, tableView: tableView) { [weak self] movies in
                    guard let self = self else { return }
                    movies.forEach { movieResult in
                        let movie = Movie(context: context)
                        movie.title = movieResult.originalTitle
                        movie.overview = movieResult.overview
                        movie.photo = self.urlForImage + movieResult.posterPath
                        self.movies.append(movie)
                    }
                    ViewModel.totalPage += 1
                    //DispatchQueue.main.async {
                    tableView.reloadData()
                    //}
                }
            }
            
        } else {
            self.movies = DataStore().fetchMovies()
            ViewModel.totalPage = movies.count / 20
            //DispatchQueue.main.async {
                tableView.reloadData()
            //}
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
    
    func viewModelForSelectedRow(tableView: UITableView) -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        tableView.deselectRow(at: selectedIndexPath, animated: false)
        let movie = movies[selectedIndexPath.row]
        return DetailViewModel(name: movie.value(forKey: "title") as! String, overview: movie.value(forKey: "overview") as! String, photo: movie.value(forKey: "photo") as! String)
    }
    
    func selectedRowAt(_ indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func tableViewWillDisplay(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView, tableView: UITableView) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        guard let _ = try? context.fetch(fetchRequest) else { return }
        
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            ViewModel.totalPage += 1
            
            if ViewModel.totalPage < 1000 {
                print("This is page number: \(ViewModel.totalPage)")
                    NetworkingService().fetchData(page: ViewModel.totalPage, tableView: tableView) { movies in
                        
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

