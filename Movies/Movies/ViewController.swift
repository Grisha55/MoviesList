//
//  ViewController.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC", let viewModel = viewModel else { return }
        guard let detailVC = segue.destination as? DetailVC else { return }
        detailVC.detailViewModel = viewModel.viewModelForSelectedRow()
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectedRowAt(indexPath)
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0}
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        // TODO: Создать ячейку
        return viewModel.cellForRowAt(indexPath)
    }
}
