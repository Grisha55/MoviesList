//
//  FavoriteVC.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit
import Firebase

class FavoriteVC: UIViewController {
    
    //MARK: - Constants
    let identifier = "favoriteCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteViewModel: FavoriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // Setup tableView
    func setupTableView() {
        favoriteViewModel = FavoriteViewModel()
        tableView.delegate = self
        tableView.dataSource = self
        favoriteViewModel?.registerCell(tableView: tableView)
        favoriteViewModel?.loadDataFromFirebase(tableView: tableView)
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension FavoriteVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let favoriteViewModel = favoriteViewModel else { return 0 }
        return favoriteViewModel.heightForRowAt()
    }
    // Delete the movie
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        favoriteViewModel?.commitEditingStyle(style: .delete, indexPath: indexPath, tableView: tableView)
    }
}

//MARK: - UITableViewDataSource
extension FavoriteVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favoriteCellViewModel = favoriteViewModel else { return 0 }
        return favoriteCellViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        
        guard let viewModel = favoriteViewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellForRowAt(indexPath)
        
        cell.favoriteCellViewModel = cellViewModel
        
        return cell
    }
}
