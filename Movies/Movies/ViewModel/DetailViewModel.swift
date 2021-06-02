//
//  DetailViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit

class DetailViewModel {
    
    private var nameString: String
    private var overviewText: String
    private var imageViewImage: UIImageView
    
    var name: String {
        return nameString
    }
    
    var overview: String {
        return overviewText
    }
    
    var imagePhoto: UIImageView {
        return imageViewImage
    }
    
    init(name: String, overview: String, imageView: UIImageView) {
        self.nameString = name
        self.overviewText = overview
        self.imageViewImage = imageView
    }
}
