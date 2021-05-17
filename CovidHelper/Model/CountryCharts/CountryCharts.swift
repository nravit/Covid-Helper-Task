//
//  CountryCharts.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import Foundation

// MARK: - CountryCharts
class CountryCharts: Codable {
    let country, countryCode, lat, lon: String?
    let confirmed, deaths, recovered, active: Int?
    let date: String?
    let locationID: String?

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
        case locationID = "LocationID"
    }

    init(country: String?, countryCode: String?, lat: String?, lon: String?, confirmed: Int?, deaths: Int?, recovered: Int?, active: Int?, date: String?, locationID: String?) {
        self.country = country
        self.countryCode = countryCode
        self.lat = lat
        self.lon = lon
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
        self.active = active
        self.date = date
        self.locationID = locationID
    }
}
