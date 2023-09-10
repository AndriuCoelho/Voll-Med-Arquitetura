//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 30/08/23.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    var specialistID: String
    var isRescheduleView: Bool
    var appointmentID: String?
    let service = WebService()
    var authManager = AuthenticationManager.shared
    
    @State private var selectedDate = Date()
    @State private var showAlert: Bool = false
    @State private var scheduleAppointmentSuccess: Bool = false
    
    init(specialistID: String, isRescheduleView: Bool = false, appointmentID: String? = nil) {
        self.specialistID = specialistID
        self.isRescheduleView = isRescheduleView
        self.appointmentID = appointmentID
    }
    
    func rescheduleAppointment() async {
        guard let appointmentID = appointmentID else { return }
                        
        do {
            if let _ = try await service.rescheduleAppointment(appointmentID: appointmentID, date: selectedDate.convertToString()) {
                self.scheduleAppointmentSuccess = true
            } else {
                self.scheduleAppointmentSuccess = false
            }
        } catch {
            print("Ocorreu um erro ao remarcar consulta: \(error)")
            self.scheduleAppointmentSuccess = false
        }
        self.showAlert = true
    }
    
    func scheduleAppointment() async {
        guard let patientID = authManager.patientID else { return }
        
        do {
            if let _ = try await service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectedDate.convertToString()) {
                self.scheduleAppointmentSuccess = true
            } else {
                self.scheduleAppointmentSuccess = false
            }
        } catch {
            print("Ocorreu um erro ao criar consulta: \(error)")
            self.scheduleAppointmentSuccess = false
        }
        self.showAlert = true
    }
    
    var body: some View {
        VStack {
            Text("Selecione a data e horário da consulta")
                .font(.title3)
                .bold()
                .foregroundColor(Color.accentColor)
                .padding(.top)
            
            DatePicker("Escolha uma data", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
            
            Button {
                if isRescheduleView {
                    Task {
                        await rescheduleAppointment()
                    }
                } else {
                    Task {
                        await scheduleAppointment()
                    }
                }
            } label: {
                ButtonView(text: isRescheduleView ? "Remarcar consulta" : "Agendar consulta")
                    .padding(.top)
            }
        }
        .navigationTitle(isRescheduleView ? "Remarcar consulta" : "Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isPresented: $showAlert) {
            if self.scheduleAppointmentSuccess {
                return Alert(title: Text("Sucesso!"), message: Text("A consulta foi \(isRescheduleView ? "remarcada" : "agendada") com sucesso."))
            }
            return Alert(title: Text("Ops, algo deu errado!"), message: Text("Houve um erro ao \(isRescheduleView ? "remarcar" : "agendar") sua consulta. Por favor tente novamente ou entre em contato via telefone."))
        }
    }
}

struct ScheduleAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleAppointmentView(specialistID: "123")
    }
}
