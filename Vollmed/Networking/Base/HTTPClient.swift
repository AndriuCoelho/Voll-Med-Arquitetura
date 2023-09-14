//
//  HTTPClient.swift
//  Vollmed
//
//  Created by Ândriu F Coelho on 13/09/23.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}
