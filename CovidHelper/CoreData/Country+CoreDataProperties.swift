//
//  Country+CoreDataProperties.swift
//  CovidHelper
//
//  Created by Raviteja on 16/05/21.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequests() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var country: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var countryDescription: String?
    @NSManaged public var details: NSSet?

}

// MARK: Generated accessors for details
extension Country {

    @objc(addDetailsObject:)
    @NSManaged public func addToDetails(_ value: CountriesDetails)

    @objc(removeDetailsObject:)
    @NSManaged public func removeFromDetails(_ value: CountriesDetails)

    @objc(addDetails:)
    @NSManaged public func addToDetails(_ values: NSSet)

    @objc(removeDetails:)
    @NSManaged public func removeFromDetails(_ values: NSSet)

}

extension Country : Identifiable {

}
