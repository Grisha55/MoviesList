//
//  FirebaseStore.swift
//  Movies
//
//  Created by Григорий Виняр on 08.06.2021.
//

import Foundation
import Firebase

class FirebaseStore {
    
    // Load data to Firebase
    func loadDataToFirestore(name: String, overview: String, photoImageViewImage: String) {
        let db = Database.database().reference()
        
        let user = Auth.auth().currentUser
        guard let userClone = user else { return }
        
        db.child("users").child(userClone.uid).child("favourites").child(name).setValue([
            "title": name,
            "overview": overview,
            "photo": photoImageViewImage
        ])
    }
    
    // Load data from Firebase
    func loadDataFromFirebase() -> [MovieDatabase] {
        
        guard let user = Auth.auth().currentUser else { return [] }
        
        let refMovies = Database.database().reference(withPath: "users").child(user.uid).child("favourites")
        
        var _movies = Array<MovieDatabase>()
        
        refMovies.observe(.value) { snapshot in
        
            for movie in snapshot.children {
                
                let movie = MovieDatabase(snapshot: movie as! DataSnapshot)
                
                _movies.append(movie)
            }
        }
        return _movies
    }
    
}
