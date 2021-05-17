//
//  Country.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import Foundation

// MARK: - Country
class Countrys: Codable {
    let country, slug, iso2: String?

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
        case iso2 = "ISO2"
    }

    init(country: String?, slug: String?, iso2: String?) {
        self.country = country
        self.slug = slug
        self.iso2 = iso2
    }
}
