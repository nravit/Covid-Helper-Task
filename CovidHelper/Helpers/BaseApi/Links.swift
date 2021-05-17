//
//  Links.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import Foundation

enum URLS {
    
    case BASE_URL
    case IMAGE_URL(String)
    
    var getDescription: String {
        get {
            switch self {
                
            case .BASE_URL:
                return "https://api.covid19api.com/"
                
            case .IMAGE_URL(let suffix):
                return ""
                
            }
        }
    }
}

enum APISuffix {
    
   case countries
   case details(String, String , String)
    
    var getDescription: String {
        
        get {
            switch self {
                
            case .countries:
                return "countries"
                
            case .details(let countryName, let startDate, let endDate):
                return "live/country/\(countryName)/status/confirmed/date/\(startDate)"
//                return "country/\(countryName)/status/confirmed?from=\(startDate)&to=\(endDate)" //2020-04-01T00:00:00Z
            }
        }
    }
}
