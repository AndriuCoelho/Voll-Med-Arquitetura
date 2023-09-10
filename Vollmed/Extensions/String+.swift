//
//  String+.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 30/08/23.
//

import Foundation

extension String {
    func convertDateStringToReadableDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        
        if let date = inputFormatter.date(from: self) {
            let dateFormatterOutput = DateFormatter()
            dateFormatterOutput.dateFormat = "d/MM/yyyy 'às' HH:mm"
            return dateFormatterOutput.string(from: date)
        } else {
            return ""
        }
    }
}
