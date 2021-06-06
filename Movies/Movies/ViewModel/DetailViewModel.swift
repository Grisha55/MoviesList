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
    // MARK: - Transition
    func showModalAuth(controller: UIViewController?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let new = storyboard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        guard let controller = controller else { return }
        controller.present(new, animated: true, completion: nil)
    }
    
    //MARK: - Save data into coreData
    func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
        let movie = NSManagedObject(entity: entity, insertInto: context)
        movie.setValue(name, forKey: "name")
        movie.setValue(overview, forKey: "overview")
        movie.setValue(name, forKey: "title")
        
        movie.setValue(urlForImage + imageViewImage, forKey: "photo")
        do {
            try context.save()
            print("Успешное сохранение")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveToFB(controller: UIViewController) {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user == nil {
                self?.showModalAuth(controller: controller)
            } else {
                self?.saveData()
                self?.loadMovieIntoDatabase()
            }
        }
    }
    
    //MARK: - Save movie into database
    func loadMovieIntoDatabase() {
        
        // создаем ссылку на базу данных
        let db = Database.database().reference()
        
        // получаем юзера, который сейчас вошел
        let user = Auth.auth().currentUser
        guard let userClone = user else { return }
        
        // создаем путь
        db.child(userClone.uid).child("favourite").child("movie").child("nameMovie")
        
        // создаем прототип фильма
        let film = MovieDatabase(title: name, overview: overview, photo: urlForImage + imageViewImage)
        
        // добавляем объкт в базу
        db.child(name).setValue([
            
            name : film.asPropertyList
        ])
        
    }
    //MARK: Movie
    struct MovieDatabase {
        var title: String
        var overview: String
        var photo: String
        
        var asPropertyList: NSDictionary {
            let result = NSMutableDictionary()
            
            // Implicit conversions turn String into NSString here…
            result["title"] = self.title
            result["overview"] = self.overview
            result["photo"] = self.photo
            return result
        }
    }
}
