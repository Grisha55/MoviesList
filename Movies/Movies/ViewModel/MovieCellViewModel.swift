//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit

class MovieCellViewModel {
    
    //MARK: - Properties
    private var titleString: String
    private var overviewString: String
    private var photoData: Data
    
    var title: String {
        return titleString
    }
    
    var overview: String {
        return overviewString
    }
    
    var photo: Data {
        return photoData
    }
    
    init(title: String, overview: String, photoData: Data) {
        self.titleString = title
        self.overviewString = overview
        self.photoData = photoData
    }
}
