//
//  NetworkingModel.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import Foundation

// MARK: - NetworkingMovies
struct NetworkingMovies: Codable {
    let results: [Results]
    let page: Int
}

// MARK: - Results
struct Results: Codable {
    let posterPath: String
    let id: Int
    let overview: String
    let originalTitle: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case overview
        case originalTitle = "original_title"
        case title
    }
}
