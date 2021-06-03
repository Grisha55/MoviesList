//
//  FavoriteVC.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteViewModel: FavoriteViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteViewModel = FavoriteViewModel()
        favoriteViewModel?.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
