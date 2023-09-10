//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 31/08/23.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    var appointmentID: String
    let service = WebService()
    
    @State private var reasonToCancel: String = ""
    @State private var showAlert: Bool = false
    @State private var cancelateAppointmentSuccess: Bool = false
    
    func cancelAppointment() async {
        do {
            self.cancelateAppointmentSuccess = try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel)
        } catch {
            self.cancelateAppointmentSuccess = false
            print("Ocorreu um erro ao desmarcar consulta: \(error)")
        }
        self.showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 16.0) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundColor(Color.accentColor)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundColor(.black)
                .scrollContentBackground(.hidden)
                .background(Color(red: 0.9, green: 0.95, blue: 1))
                .cornerRadius(16.0)
                .frame(maxHeight: 300)
            
            Button {
                Task {
                    await cancelAppointment()
                }
            } label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
                    .padding(.top)
            }
        }
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .alert(isPresented: $showAlert) {
            if self.cancelateAppointmentSuccess {
                return Alert(title: Text("Sucesso!"), message: Text("A consulta foi desmarcada com sucesso."))
            }
            return Alert(title: Text("Ops, algo deu errado!"), message: Text("Houve um erro no cancelamento da sua consulta. Por favor tente novamente ou entre em contato via telefone."))
        }
    }
}

struct CancelAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        CancelAppointmentView(appointmentID: "123")
    }
}
