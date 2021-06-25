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
    private let urlForImage = "https://image.tmdb.org/t/p/w300"
    
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
        let imageView = UIImageView()
        imageView.load(imageFrom: imageViewImage)
        return imageView
    }
    
    init(name: String, overview: String, photo: String) {
        self.nameString = name
        self.overviewText = overview
        self.imageViewImage = photo
    }
    
    //Save data to user in Firebase
    func saveToUserToFB(controller: UIViewController) {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user == nil {
                Transitions().showModalAuth(controller: controller)
            } else {
                
                let ref = Database.database().reference()

                guard let user = Auth.auth().currentUser else { return }
                
                ref.child("users").child(user.uid).child("favourites").observeSingleEvent(of: .value, with: { (snapshot) in
                    guard var safeName = self?.name.replacingOccurrences(of: "", with: "_") else { return }
                    safeName = safeName.replacingOccurrences(of: ".", with: "_")
                    safeName = safeName.replacingOccurrences(of: "#", with: "-")
                    safeName = safeName.replacingOccurrences(of: "$", with: "dollar")
                    safeName = safeName.replacingOccurrences(of: "[", with: "{")
                    safeName = safeName.replacingOccurrences(of: "]", with: "}")
                    safeName = safeName.replacingOccurrences(of: "@", with: "dog")
                    if snapshot.hasChild(safeName) {

                        Alerts().showCopyFilmAlert(controller: controller)

                        }else{
                            DispatchQueue.global(qos: .background).async {
                                FirebaseStore().loadDataToFirestore(name: self?.nameString ?? "N/A", overview: self?.overview ?? "N/A", photoImageViewImage: self?.imageViewImage ?? "")
                            }
                        }
                    })
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
