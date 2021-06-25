//
//  FirebaseStore.swift
//  Movies
//
//  Created by Григорий Виняр on 08.06.2021.
//

import Foundation
import Firebase

class FirebaseStore {
    
    // User authorization
    func existUser(name: String, email: String, password: String, controller: UIViewController) {
        DatabaseManager.shared.userExists(name: name, email: email, password: password) { exist in
            Auth.auth().fetchSignInMethods(forEmail: email) { providers, error in
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                if providers != nil {
                    Alerts().showWarningAlert(controller: controller, title: "", message: "This email have already veryfide", actionTitle: "Cancel")
                }
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                guard authResult != nil, error == nil else {
                    return
                }
                controller.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // Sign In with email and password
    func signInWith(email: String, password: String, controller: UIViewController, message: String) {
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard authResult != nil, error == nil else {
                Alerts().showWarningAlert(controller: controller, title: "", message: message, actionTitle: "Cancel")
                return
            }
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
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
    
    // Exit from Firebase
    func exitAction() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
