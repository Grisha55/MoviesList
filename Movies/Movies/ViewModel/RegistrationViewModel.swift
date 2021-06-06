//
//  RegistrationViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 04.06.2021.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    // Catch errors
    func showAlert(controller: UIViewController, message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    // Sign In with email and password
    func signInWith(email: String, password: String, controller: UIViewController, message: String) {
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard authResult != nil, error == nil else {
                self?.showAlert(controller: controller, message: message)
                return
            }
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    // User authorization
    func existUser(name: String, email: String, password: String, controller: UIViewController) {
        DatabaseManager.shared.userExists(name: name, email: email, password: password) { exist in
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                guard authResult != nil, error == nil else {
                    return
                }
                controller.dismiss(animated: true, completion: nil)
            }
            
        }
    }
}
