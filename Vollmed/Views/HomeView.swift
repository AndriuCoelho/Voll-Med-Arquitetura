//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 29/08/23.
//

import SwiftUI

struct HomeView: View {
    
    let service = WebService()
    var authManager = AuthenticationManager.shared
    
    @State private var specialists: [Specialist] = []
    
    func getSpecialists() async {
        do {
            if let fetchedSpecialists = try await service.getAllSpecialists() {
                self.specialists = fetchedSpecialists
            }
        } catch {
            print("Ocorreu um erro ao obter os especialistas: \(error)")
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
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack() {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("LightBlue"))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                ForEach(specialists) { specialist in
                    SpecialistCardView(specialist: specialist)
                        .padding(.bottom, 8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear {
            Task {
                await getSpecialists()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        await logout()
                    }
                }) {
                    HStack(spacing: 2) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
