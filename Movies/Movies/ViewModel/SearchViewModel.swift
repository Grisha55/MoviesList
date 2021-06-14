//
//  SearchViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 13.06.2021.
//

import UIKit
import CoreData

class SearchViewModel {
    
    //MARK: - Properties
    let urlForImage = "https://image.tmdb.org/t/p/w300"
    
    var filteredMovies = [Results]()
    
    //MARK: - UITableViewDataSource
    func cellForRowAt(indexPath: IndexPath) -> FavoriteCellViewModel? {
        let filteredMovie = filteredMovies[indexPath.row]
        return FavoriteCellViewModel(photoImageView: urlForImage + filteredMovie.posterPath, nameLabel: filteredMovie.title, overview: filteredMovie.overview)
    }
    
    func numberOfRows() -> Int {
        return filteredMovies.count
    }
    
    //MARK: - UITableViewDelegate
    func heightForRowAt() -> CGFloat {
        return 110.0
    }
    
    //MARK: - UISearchResultsUpdating
    func updateSearchResults(tableView: UITableView, for searchController: UISearchController) {
        
        loadDataToFilteredMovies(tableView: tableView, query: searchController.searchBar.text ?? "")
    }
    
    func loadDataToFilteredMovies(tableView: UITableView, query: String) {
        for page in 1...10 {
            NetworkingService().fetchFilteredData(tableView: tableView, page: page, query: query) { results in
                DispatchQueue.main.async { [weak self] in
                    self?.filteredMovies = results
                    tableView.reloadData()
                }
            }
        }
       
    }
}
