//
//  DetailViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import CoreData
import Firebase

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
    
    //TODO: Попробовать перенести этот метод в FirebaseStore
    func saveToUserToFB(controller: UIViewController) {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user == nil {
                Transitions().showModalAuth(controller: controller)
            } else {
                FirebaseStore().loadDataToFirestore(name: self?.name ?? "N/A", overview: self?.overview ?? "N/A", photoImageViewImage: self?.imageViewImage ?? "")
            }
        }
    }
}
// Movie
struct MovieDatabase {
    var title: String?
    var overview: String?
    var photo: String?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.title = snapshotValue["title"] as? String
        self.overview = snapshotValue["overview"] as? String
        self.photo = snapshotValue["photo"] as? String
        
    }
}
