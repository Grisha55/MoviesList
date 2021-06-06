//
//  DataBaseManager.swift
//  Movies
//
//  Created by Григорий Виняр on 05.06.2021.
//

import UIKit
import FirebaseDatabase
import Firebase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

//MARK: - Account Management
extension DatabaseManager {
    
    public func userExists(name: String, email: String, password: String, completion: @escaping ((Bool)-> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    /// Inserts new user to database
    public func insertUser(with user: MovieUser) {
        database.child("users").setValue([
            //"name": user.name,
            "id": user.id
        ])
    }
}
//MARK: User in Database
struct MovieUser {
    let name: String
    let email: String
    let id: String
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
