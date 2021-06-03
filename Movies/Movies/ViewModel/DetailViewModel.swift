//
//  DetailViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit

class DetailViewModel {
    
    //MARK: - Properties
    private var nameString: String
    private var overviewText: String
    private var imageViewImage: UIImageView
    
    var name: String {
        return nameString
    }
    
    var overview: String {
        return overviewText
    }
    
    var photoImageView: UIImageView {
        return imageViewImage
    }
    
    init(name: String, overview: String, photo: UIImageView) {
        self.nameString = name
        self.overviewText = overview
        self.imageViewImage = photo
    }
    
    //MARK: - Save data into coreData
    func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let movie = Movie(context: context)
        movie.name = name
        movie.overview = overview
        movie.photo = photoImageView.image?.jpegData(compressionQuality: 1.0)
        do {
            try context.save()
            print("Успешное сохранение")
        } catch {
            print(error.localizedDescription)
        }
    }
}
