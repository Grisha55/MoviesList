//
//  DetailVC.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit

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
        
    }
    
}
