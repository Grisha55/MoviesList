//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import CoreData

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
    //MARK: - Methods
    func likeAction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context) else { return }
        let movie = NSManagedObject(entity: entity, insertInto: context)
        movie.setValue(title, forKey: "name")
        movie.setValue(overview, forKey: "overview")
        movie.setValue(photoString, forKey: "photo")
        do {
            try context.save()
            print("Данные сохранены")
        } catch {
            print(error.localizedDescription)
        }
    }
}
