//
//  Route+CoreDataProperties.swift
//  WakingRoute
//
//  Created by KwanHoWong on 31/1/2024.
//
//

import Foundation
import CoreData


extension Route {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Route> {
        return NSFetchRequest<Route>(entityName: "Route")
    }

    @NSManaged public var name: String?
    @NSManaged public var initialLat: Double
    @NSManaged public var destinationLat: Double
    @NSManaged public var initialLon: Double
    @NSManaged public var destinationLon: Double
    @NSManaged public var image: Data?

}

extension Route : Identifiable {

}
