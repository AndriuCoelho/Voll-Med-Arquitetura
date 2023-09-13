//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Ândriu F Coelho on 10/09/23.
//

import Foundation

struct HomeViewModel {
    
    // MARK: - Attributes
    
    let service = WebService()
    var authManager = AuthenticationManager.shared
    
    // MARK: - API calls
    
    func getSpecialists() async throws -> [Specialist] {
        do {
            if let fetchedSpecialists = try await service.getAllSpecialists() {
                return fetchedSpecialists
            }
            return []
        } catch {
            print("Ocorreu um erro ao obter os especialistas: \(error)")
            throw error
        }
    }
    
    func logout() async {
        do {
            let response = try await service.logoutPatient()
            if response {
                authManager.removePatientID()
                authManager.removeToken()
            }
        } catch {
            print("Ocorreu um erro no logout: \(error)")
        }
    }
}
