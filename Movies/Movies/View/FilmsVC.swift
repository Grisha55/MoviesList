//
//  ViewController.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import Firebase
import CoreData

class FilmsVC: UIViewController {

    //MARK: - Properties
    private var viewModel: ViewModel?
    private var networkingService: NetworkingService?
    
    //MARK: - Constants
    let toDetailVC = "toDetailVC"
    let identifier = "movieCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonExit: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideExitButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        settingsTableView()
        viewModel?.getFirstData(tableView: tableView)
    }
    
    // Setup tableView
    private func settingsTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel?.registerCell(tableView: tableView)
        
    }
    // Hide buttonExit
    func hideExitButton() {
        if Auth.auth().currentUser == nil {
            buttonExit.title = ""
        } else {
            buttonExit.title = "Exit"
        }
    }
    
    // Transition
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == toDetailVC, let viewModel = viewModel else { return }
        guard let detailVC = segue.destination as? DetailVC else { return }
        detailVC.detailViewModel = viewModel.viewModelForSelectedRow(tableView: tableView)
    }

    @IBAction func buttonExitAction(_ sender: Any) {
        Alerts().showExitAlert(title: "Exit", massage: "", titleForFirstAction: "Yes", titleForSecondAction: "Cancel", controller: self)
    }
}

//MARK: - UITableViewDelegate
extension FilmsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.heightForRowAt()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectedRowAt(indexPath)
        performSegue(withIdentifier: toDetailVC, sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel else { return }
        viewModel.scrollViewDidScroll(scrollView, tableView: tableView)
    }
}
//MARK: - UITableViewDataSource
extension FilmsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        cell.backgroundColor = .black
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.viewModel = cellViewModel
        
        return cell
    }
}
