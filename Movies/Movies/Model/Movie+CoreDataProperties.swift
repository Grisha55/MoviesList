//
//  Movie+CoreDataProperties.swift
//  Movies
//
//  Created by Григорий Виняр on 04.06.2021.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var overview: String?
    @NSManaged public var photo: String?
    @NSManaged public var status: String?
    @NSManaged public var title: String?

}

extension Movie : Identifiable {

}
