//
//  ViewController.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        
        NetworkingService().fetchData { (result) in
            switch result {
            
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let movies):
                movies.forEach { movie in
                    print(movie.originalTitle)
                }
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return viewModel.cellForRowAt(indexPath)
    }
}
