//
//  FavoriteCellViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit

class FavoriteCellViewModel {
    
    //MARK: - Properties
    private var photoImageView: UIImageView
    private var nameLabel: String
    
    var photo: UIImageView {
        return photoImageView
    }
    
    var name: String {
        return nameLabel
    }
    
    init(photoImageView: UIImageView, nameLabel: String) {
        self.photoImageView = photoImageView
        self.nameLabel = nameLabel
    }
}
