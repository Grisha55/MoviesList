//
//  FavoriteCellViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit

class FavoriteCellViewModel {
    
    //MARK: - Properties
    private var photoString: String
    private var nameLabel: String
    private var overviewText: String
    
    var photo: UIImageView {
        let imageView = UIImageView()
        imageView.load(imageFrom: photoString)
        return imageView
    }
    
    var name: String {
        return nameLabel
    }
    
    var overview: String {
        return overviewText
    }
    
    init(photoImageView: String, nameLabel: String, overview: String) {
        self.photoString = photoImageView
        self.nameLabel = nameLabel
        self.overviewText = overview
    }
}
