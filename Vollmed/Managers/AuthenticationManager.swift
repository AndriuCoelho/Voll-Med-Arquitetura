//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 07/09/23.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    private init() {
        self.token = KeychainHelper.get(for: "token")
        self.patientID = KeychainHelper.get(for: "patient-id")
    }
    
    @Published var token: String?
    @Published var patientID: String?
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, for: "token")
        self.token = token
    }
    
    func removeToken() {
        KeychainHelper.remove(for: "token")
        self.token = nil
    }
    
    func savePatientID(id: String) {
        KeychainHelper.save(value: id, for: "patient-id")
        self.patientID = id
    }
    
    func removePatientID() {
        KeychainHelper.remove(for: "patient-id")
        self.patientID = nil
    }
}
