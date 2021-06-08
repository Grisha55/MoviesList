//
//  DataStore.swift
//  Movies
//
//  Created by Григорий Виняр on 08.06.2021.
//

import UIKit
import CoreData
import Firebase

class DataStore {
    
    // Save data to CoreData
    func saveData(name: String, overview: String, photoURL: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
        let movie = NSManagedObject(entity: entity, insertInto: context)
        movie.setValue(name, forKey: "name")
        movie.setValue(overview, forKey: "overview")
        movie.setValue(name, forKey: "title")
        movie.setValue(photoURL, forKey: "photo")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Get movies from CoreData
    func fetchMovies() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        do {
            let movies = try context.fetch(fetchRequest)
            return movies
        } catch {
            print(error.localizedDescription)
            return [NSManagedObject]()
        }
    }
    
    // Exit from movie app
    func exitAction() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
