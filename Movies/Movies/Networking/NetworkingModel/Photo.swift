//
//  Photo.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import Foundation

// MARK: - Photo
struct Photo: Decodable {
    let id: Int?
    let backdrops: [Backdrop]?
}

// MARK: - Backdrop
struct Backdrop: Decodable {
    let aspectRatio: Double?
    let filePath: String?
    let height: Int?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case width
    }
}
