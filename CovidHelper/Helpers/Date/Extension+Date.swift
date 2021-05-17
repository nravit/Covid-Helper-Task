//
//  Extension+Date.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import Foundation

extension Date {
    func getDateAccoringTo(format: DateFormat ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

enum DateFormat: String {
    case MAIN = "yyyy-MM-ddTHH:mm:ssZ"
}
