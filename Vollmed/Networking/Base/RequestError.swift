//
//  RequestError.swift
//  Vollmed
//
//  Created by Ândriu F Coelho on 13/09/23.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "erro na decodificação"
        case .unauthorized:
            return "sessão expirada"
        default:
            return "erro desconhecido"
        }
    }
}

