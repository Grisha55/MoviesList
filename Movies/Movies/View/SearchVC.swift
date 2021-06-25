//
//  SearchVC.swift
//  Movies
//
//  Created by Григорий Виняр on 13.06.2021.
//

import UIKit

class SearchVC: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var searchViewModel: SearchViewModel?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = SearchViewModel()
        setupTableView()
        setupSearchController()
    }
    
    //Setup tableView
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "favoriteCell")
    }
    
    //Setup searchController
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.backgroundColor = UIColor.init(red: 165/255, green: 42/255, blue: 42/255, alpha: 0.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDescriptionFromSearch" else { return }
        guard let detailVC = segue.destination as? DetailVC else { return }
        detailVC.detailViewModel = searchViewModel?.viewModelForSelectedRow(tableView: tableView)
    }

}

//MARK: - UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let searchViewModel = searchViewModel else { return 0 }
        return searchViewModel.heightForRowAt()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchViewModel?.selectedRowAt(indexPath)
        performSegue(withIdentifier: "toDescriptionFromSearch", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        searchViewModel?.tableViewWillDisplay(tableView, cell: cell, indexPath: indexPath)
    }
}

//MARK: - UITableViewDataSource
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchViewModel = searchViewModel else { return 0 }
        return searchViewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        cell.backgroundColor = .black
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
