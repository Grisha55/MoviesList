//
//  ViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
 
class ViewModel: NSObject {
    
    //MARK: - Constants
    let urlForImage = "https://image.tmdb.org/t/p/w300"
    let identifier = "movieCell"
    
    //MARK: - Properties
    private var networkingService: NetworkingService!
    
    var selectedIndexPath: IndexPath?
    
    var movies: [Results]?
    
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
        guard let movies = movies else { return 0 }
        return movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> MovieCellViewModel? {
        guard let movies = movies else { return nil }
        
        let movie = movies[indexPath.row]
        
        let photoPath = movie.posterPath
        
        return MovieCellViewModel(title: movie.title, overview: movie.overview, photoString: urlForImage + photoPath)
    }
    
    //MARK: - for TableViewDelegate
    func heightForRowAt() -> CGFloat {
        return 150.0
    }
    
    func viewModelForSelectedRow() -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        guard let movie = movies?[selectedIndexPath.row] else { return nil }
        
        guard let url = URL(string: urlForImage + movie.posterPath) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return DetailViewModel(name: movie.originalTitle, overview: movie.overview, photo: UIImageView(image: UIImage(data: data)))
    }
    
    func selectedRowAt(_ indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
}
