//
//  DetailVC.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import Firebase

class DetailVC: UIViewController {

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var detailViewModel: DetailViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupProperties()
    }
    
    //MARK: - Setup properties
    func setupProperties() {
        
        guard let detailViewModel = detailViewModel else { return }
        
        nameLabel.text = detailViewModel.name
        
        photoImageView.image = detailViewModel.photoImageView.image
        descriptionTextView.text = detailViewModel.overview
    }
    
    @IBAction func buttonSaveAction(_ sender: Any) {
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user == nil {
                self?.showModalAuth()
            } else {
                guard let detailViewModel = self?.detailViewModel else { return }
                detailViewModel.saveData()
            }
        }
        
        
    }
    
    func showModalAuth() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let new = storyboard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        self.present(new, animated: true, completion: nil)
    }
    
}
