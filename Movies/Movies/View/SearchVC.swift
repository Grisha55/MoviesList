//
//  SearchVC.swift
//  Movies
//
//  Created by Григорий Виняр on 13.06.2021.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchViewModel: SearchViewModel?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = SearchViewModel()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "favoriteCell")
        setupSearchController()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.backgroundColor = UIColor.init(red: 165, green: 42, blue: 42, alpha: 0.0)
    }

}

//MARK: UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let searchViewModel = searchViewModel else { return 0 }
        return searchViewModel.heightForRowAt()
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchViewModel = searchViewModel else { return 0 }
        return searchViewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        
        guard let searchViewModel = searchViewModel else { return UITableViewCell() }
        
        let cellViewModel = searchViewModel.cellForRowAt(indexPath: indexPath)
        
        cell.favoriteCellViewModel = cellViewModel
        
        return cell
    }
}

//MARK: - UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchViewModel?.updateSearchResults(tableView: tableView, for: searchController)
    }
}
