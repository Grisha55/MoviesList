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
    var selectedIndexPath: IndexPath?
    
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
    
    func viewModelForSelectedRow(tableView: UITableView) -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        tableView.deselectRow(at: selectedIndexPath, animated: false)
        let movie = filteredMovies[selectedIndexPath.row]
        return DetailViewModel(name: movie.title, overview: movie.overview, photo: urlForImage + movie.posterPath)
    }
    
    func selectedRowAt(_ indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func tableViewWillDisplay(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
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
