//
//  Date+.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 30/08/23.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        return dateFormatter.string(from: self)
    }
}
