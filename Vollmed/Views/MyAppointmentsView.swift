//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 31/08/23.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = WebService()
    var authManager = AuthenticationManager.shared
    
    @State private var appointments: [Appointment] = []
    
    func getAppointments() async {
        guard let patientID = authManager.patientID else
        { return }
        
        do {
            if let appointments = try await service.getAllAppointmentsFromPatient(patientID: patientID) {
                self.appointments = appointments
            }
        } catch {
            print("Ocorreu um erro ao obter consultas: \(error)")
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(appointments) { appointment in
                SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
            }
        }
        .padding()
        .onAppear {
            Task {
                await getAppointments()
            }
        }
        .navigationTitle("Minhas Consultas")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct MyAppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        MyAppointmentsView()
    }
}
