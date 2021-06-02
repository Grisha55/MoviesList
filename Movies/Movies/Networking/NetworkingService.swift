//
//  NetworkingService.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import Foundation

class NetworkingService {
    
    func fetchData(completion: @escaping(Result<[Results], Error>) -> Void) {
        
        // https://api.themoviedb.org/3/movie/550?api_key=6fc493937e1259d088b4ba87dc174e57
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.themoviedb.org"
        constructor.path = "/3/movie/popular/"
        constructor.queryItems = [
            URLQueryItem(name: "api_key", value: "6fc493937e1259d088b4ba87dc174e57")
        ]
        
        guard let url = constructor.url else { return }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(error!))
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
                
            }
            
            do {
                let movies = try JSONDecoder().decode(NetworkingMovies.self, from: data)
                let moviesList = movies.results
                
                DispatchQueue.main.async {
                    completion(.success(moviesList))
                }
                
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
