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
    
    var photoImageView: UIImageView {
        return imageViewImage
    }
    
    // TODO: Создать метод по получению фотографии
    func getPhoto() {
        
    }
    
    init(name: String, overview: String, photo: UIImageView) {
        self.nameString = name
        self.overviewText = overview
        self.imageViewImage = photo
    }
    
    func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let movie = Movie(context: context)
        movie.name = name
        movie.overview = overview
        //movie.photo = photoImageView
    }
}
