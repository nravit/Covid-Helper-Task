//
//  CountriesDetails+CoreDataProperties.swift
//  CovidHelper
//
//  Created by Raviteja on 16/05/21.
//
//

import Foundation
import CoreData


extension CountriesDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountriesDetails> {
        return NSFetchRequest<CountriesDetails>(entityName: "CountriesDetails")
    }

    @NSManaged public var active: Int32
    @NSManaged public var confirmed: Int32
    @NSManaged public var country: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var date: String?
    @NSManaged public var deaths: Int32
    @NSManaged public var lat: String?
    @NSManaged public var lon: String?
    @NSManaged public var recovered: Int32
    @NSManaged public var status: String?
    @NSManaged public var countryName: Country?

}

extension CountriesDetails : Identifiable {

}
