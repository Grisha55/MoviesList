//
//  ViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
 
class ViewModel: NSObject {
    
    //MARK: - Properties
    private var networkingService: NetworkingService!
    
    var selectedIndexPath: IndexPath?
    
    var movies: [Results]?
    
    var photo: Photo?
    
    //MARK: - Get photos
    func fetchPhotos(id: Int, completion: @escaping() -> Void) {
        networkingService = NetworkingService()
        networkingService.getPhotos(id: id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let photo):
                self?.photo = photo
                print(photo)
            }
        }
    }
    
    //MARK: - Get movies
    func fetchMovies(completion: @escaping() -> Void) {
        networkingService = NetworkingService()
        networkingService.fetchData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movies):
                self?.movies = movies
                completion()
            }
        }
    }
    
    //MARK: - for TableViewDataSource
    func numberOfRows() -> Int {
        guard let movies = movies else { return 0}
        return movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> MovieCellViewModel? {
        guard let movies = movies else { return nil }
        
        let movie = movies[indexPath.row]
        
        //let photoPath = photo?.backdrops?[indexPath.row].filePath
        
        return MovieCellViewModel(title: movie.title, overview: movie.overview, photoData: Data())
    }
    
    //MARK: - for TableViewDelegate
    func viewModelForSelectedRow() -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil}
        guard let movie = movies?[selectedIndexPath.row] else { return nil}
        return DetailViewModel(name: movie.originalTitle, overview: movie.overview, photo: UIImageView())
    }
    
    func selectedRowAt(_ indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
    }
}
