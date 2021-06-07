//
//  NetworkingService.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import CoreData

class NetworkingService: NSObject {
    
    let urlForImage = "https://image.tmdb.org/t/p/w300"
    
    //MARK: - Get movies
    func fetchData() {
        
        // https://api.themoviedb.org/3/movie/550?api_key=6fc493937e1259d088b4ba87dc174e57
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.themoviedb.org"
        constructor.path =  "/3/movie/top_rated"
        constructor.queryItems = [
            URLQueryItem(name: "api_key", value: "6fc493937e1259d088b4ba87dc174e57")
        ]
        
        guard let url = constructor.url else { return }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            guard let data = data else {
                print(error!)
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(NetworkingMovies.self, from: data)
                let moviesList = movies.results
                moviesList.forEach { [weak self] movie in
                    
                    // TODO: Сделать сохранение в coreData
                    DispatchQueue.main.async {
                        self?.saveData(name: movie.title, overview: movie.overview, photoURL: self!.urlForImage + movie.posterPath)
                    }
                    
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
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
}
