//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import Foundation

class MovieCellViewModel {
    
    private var titleString: String
    private var overviewString: String
    
    var title: String {
        return titleString
    }
    
    var overview: String {
        return overviewString
    }
    
    init(title: String, overview: String) {
        self.titleString = title
        self.overviewString = overview
    }
}
