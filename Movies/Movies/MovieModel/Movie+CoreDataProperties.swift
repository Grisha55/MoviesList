//
//  Movie+CoreDataProperties.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var title: String?
    @NSManaged public var status: String?
    @NSManaged public var overview: String?

}

extension Movie : Identifiable {

}
