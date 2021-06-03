//
//  ViewController.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit

class FilmsVC: UIViewController {

    private var viewModel: ViewModel?
    
    //MARK: - Constants
    let toDetailVC = "toDetailVC"
    let identifier = "movieCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView()
    }
    
    //MARK: - settingsTableView()
    private func settingsTableView() {
        
        viewModel = ViewModel()
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel?.registerCell(tableView: tableView)
        
        viewModel?.fetchMovies {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Transition
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == toDetailVC, let viewModel = viewModel else { return }
        guard let detailVC = segue.destination as? DetailVC else { return }
        detailVC.detailViewModel = viewModel.viewModelForSelectedRow()
    }

}

//MARK: - UITableViewDelegate
extension FilmsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectedRowAt(indexPath)
        performSegue(withIdentifier: toDetailVC, sender: nil)
    }
}
//MARK: - UITableViewDataSource
extension FilmsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0}
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.viewModel = cellViewModel
        
        return cell
    }
}
