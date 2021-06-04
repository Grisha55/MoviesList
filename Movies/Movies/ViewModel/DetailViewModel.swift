//
//  DetailViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import CoreData

class DetailViewModel {
    
    //MARK: - Constants
    let urlForImage = "https://image.tmdb.org/t/p/w300"
    
    //MARK: - Properties
    private var nameString: String
    private var overviewText: String
    private var imageViewImage: String
    
    var name: String {
        return nameString
    }
    
    var overview: String {
        return overviewText
    }
    
    var photoImageView: UIImageView {
        guard let url = URL(string: urlForImage + imageViewImage) else { return UIImageView() }
        guard let data = try? Data(contentsOf: url) else { return UIImageView() }
        return UIImageView(image: UIImage(data: data))
    }
    
    init(name: String, overview: String, photo: String) {
        self.nameString = name
        self.overviewText = overview
        self.imageViewImage = photo
    }
    
    //MARK: - Save data into coreData
    func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
        let movie = NSManagedObject(entity: entity, insertInto: context)
        movie.setValue(name, forKey: "name")
        movie.setValue(overview, forKey: "overview")
        movie.setValue(name, forKey: "title")
        
        movie.setValue(urlForImage + imageViewImage, forKey: "photo")
        do {
            try context.save()
            print("Успешное сохранение")
        } catch {
            print(error.localizedDescription)
        }
    }
}
