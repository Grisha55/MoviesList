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
    private let identifier = "favoriteCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    private var favoriteViewModel: FavoriteViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        cell.backgroundColor = .init(red: 42/255, green: 53/255, blue: 76/255, alpha: 0.0)
        guard let viewModel = favoriteViewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellForRowAt(indexPath)
        
        cell.favoriteCellViewModel = cellViewModel
        
        return cell
    }
}
