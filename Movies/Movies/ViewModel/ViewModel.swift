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
    
    func fetchMovies() {
        networkingService = NetworkingService()
        networkingService.fetchData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movies):
                self?.movies = movies
            }
        }
    }
    
    func numberOfRows() -> Int {
        guard let movies = movies else { return 0}
        return movies.count
    }
    
    func cellForRowAt(_ indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        // TODO: Получить следующий контроллер
    }
    
    func selectedRowAt(_ indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
