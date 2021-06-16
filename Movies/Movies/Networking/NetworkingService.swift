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
    
    func fetchFirstData(tableView: UITableView, completion: @escaping ([Results]) -> Void) {
        
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
                completion(moviesList)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    // Get movies from page 1
    func fetchData(tableView: UITableView, page: Int) {
        
        // https://api.themoviedb.org/3/movie/550?api_key=6fc493937e1259d088b4ba87dc174e57
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.themoviedb.org"
        constructor.path =  "/3/movie/top_rated"
        constructor.queryItems = [
            URLQueryItem(name: "api_key", value: "6fc493937e1259d088b4ba87dc174e57"),
            URLQueryItem(name: "page", value: String(page))
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
                   
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        DataStore().saveData(name: movie.originalTitle, overview: movie.overview, photoURL: self.urlForImage + movie.posterPath)
                        tableView.reloadData()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchFilteredData(tableView: UITableView, page: Int, query: String, completion: @escaping ([Results]) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.themoviedb.org"
        constructor.path =  "/3/search/movie"
        constructor.queryItems = [
            URLQueryItem(name: "api_key", value: "6fc493937e1259d088b4ba87dc174e57"),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "query", value: query)
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
                
                DispatchQueue.main.async {
                    completion(moviesList)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
