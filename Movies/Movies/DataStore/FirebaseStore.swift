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
    
}
