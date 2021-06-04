//
//  FavoriteVC.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit

class FavoriteVC: UIViewController {

    //MARK: - Constants
    let identifier = "favoriteCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteViewModel: FavoriteViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteViewModel = FavoriteViewModel()
        favoriteViewModel?.fetchData()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK: - Setup tableView
    func setupTableView() {
        favoriteViewModel = FavoriteViewModel()
        tableView.delegate = self
        tableView.dataSource = self
        favoriteViewModel?.registerCell(tableView: tableView)
    }
}

//MARK: - UITableViewDelegate
extension FavoriteVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let favoriteViewModel = favoriteViewModel else { return 0 }
        return favoriteViewModel.heightForRowAt()
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
