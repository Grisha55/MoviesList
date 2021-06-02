//
//  ViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
 
class ViewModel: NSObject {
    
    private var networkingService: NetworkingService!
    
    var selectedIndexPath: IndexPath?
    
    var movies: [Results]?
    
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
    
    func numberOfRows() -> Int {
        guard let movies = movies else { return 0}
        return movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> MovieCellViewModel? {
        guard let movies = movies else { return nil }
        
        let movie = movies[indexPath.row]
        
        return MovieCellViewModel(title: movie.title, overview: movie.overview)
    }
    
    func viewModelForSelectedRow() -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil}
        guard let movie = movies?[selectedIndexPath.row] else { return nil}
        // TODO: Найти способ получения imageView из png файла
        return DetailViewModel(name: movie.title, overview: movie.overview, imageView: UIImageView())
    }
    
    func selectedRowAt(_ indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
