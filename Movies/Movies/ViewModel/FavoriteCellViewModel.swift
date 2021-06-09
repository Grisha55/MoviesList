//
//  FavoriteCellViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit
import SDWebImage

class FavoriteCellViewModel {
    
    //MARK: - Properties
    private var photoImageView: String
    private var nameLabel: String
    private var overviewText: String
    
    var photo: UIImageView {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: photoImageView), completed: .none)
        return imageView
    }
    
    var name: String {
        return nameLabel
    }
    
    var overview: String {
        return overviewText
    }
    
    init(photoImageView: String, nameLabel: String, overview: String) {
        self.photoImageView = photoImageView
        self.nameLabel = nameLabel
        self.overviewText = overview
    }
}
