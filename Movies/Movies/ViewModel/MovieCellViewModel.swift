//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import CoreData
import Firebase

class MovieCellViewModel {
    
    //MARK: - Properties
    private var titleString: String
    private var overviewString: String
    private var photoData: String
    
    var title: String {
        return titleString
    }
    
    var overview: String {
        return overviewString
    }
    
    var photoString: String {
        return photoData
    }
    
    init(title: String, overview: String, photoString: String) {
        self.titleString = title
        self.overviewString = overview
        self.photoData = photoString
    }
    
    // Load data to Firebase
    func addFB() {
        FirebaseStore().loadDataToFirestore(name: title, overview: overview, photoImageViewImage: photoData)
    }
}
