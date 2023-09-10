//
//  SignUpView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 04/09/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cpf: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var chosenHealthPlan: String
    @State private var showAlert: Bool = false
    @State private var registrationSuccess: Bool = false
    @State private var navigateToSignInView: Bool = false
    
    let service = WebService()
    
    var healthPlans: [String] = [
        "Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "NotreDame Intermédica", "São Franciso Saúde", "Golden Cross", "Medial Saúde", "América Saúde", "Outro"
    ]
    
    init() {
        chosenHealthPlan = self.healthPlans[0]
    }
    
    func register() async {
        let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phoneNumber: phoneNumber, healthPlan: chosenHealthPlan)
        do {
            if let _ = try await service.registerPatient(patient: patient) {
                self.registrationSuccess = true
            }
        } catch {
            print("Ocorreu um erro no cadastro: \(error)")
        }
        self.showAlert = true
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16.0) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                        .padding(.vertical)
                    
                    Text("Olá, boas-vindas!")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.accentColor)
                    
                    Text("Insira seus dados para criar uma conta.")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.bottom, 16.0)
                    
                    Group {
                        Text("Nome")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.accentColor)
                        
                        TextField("Insira seu nome completo", text: $name)
                            .padding(14)
                            .background(.gray.opacity(0.25))
                            .cornerRadius(14.0)
                            .autocorrectionDisabled()
                    }
                    
                    Group {
                        Text("Email")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.accentColor)
                        
                        TextField("Insira seu email", text: $email)
                            .padding(14)
                            .background(.gray.opacity(0.25))
                            .cornerRadius(14.0)
                            .autocorrectionDisabled()
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Group {
                        Text("CPF")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.accentColor)
                        
                        TextField("Insira seu CPF (apenas números)", text: $cpf)
                            .padding(14)
                            .background(.gray.opacity(0.25))
                            .cornerRadius(14.0)
                            .keyboardType(.numberPad)
                    }
                    
                    Group {
                        Text("Telefone")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.accentColor)
                        
                        TextField("Insira seu telefone (apenas números)", text: $phoneNumber)
                            .padding(14)
                            .background(.gray.opacity(0.25))
                            .cornerRadius(14.0)
                            .keyboardType(.numberPad)
                    }
                    
                    Group {
                        Text("Senha")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.accentColor)
                        
                        SecureField("Insira sua senha", text: $password)
                            .padding(14)
                            .background(.gray.opacity(0.25))
                            .cornerRadius(14.0)
                    }
                    
                    Group {
                        Text("Selecione seu plano de saúde")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.accentColor)
                        
                        Picker("Plano de Saúde", selection: $chosenHealthPlan) {
                            ForEach(healthPlans, id: \.self) { plan in
                                Text(plan)
                            }
                        }
                    }
                    
                    Group {
                        Button {
                            Task {
                                await register()
                            }
                        } label: {
                            ButtonView(text: "Cadastrar")
                        }
                        
                        
                        NavigationLink {
                            SignInView()
                        } label: {
                            Text("Já possui uma conta? Faça o login!")
                                .bold()
                                .foregroundColor(.accentColor)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
            .alert(isPresented: $showAlert) {
                if self.registrationSuccess {
                    return Alert(title: Text("Sucesso!"), message: Text("Paciente cadastrado com sucesso! Por favor, faça o login para continuar!"), dismissButton: .default(Text("Ok"), action: {
                        self.navigateToSignInView = true
                    }))
                }
                 
                return Alert(title: Text("Ops, algo deu errado!"), message: Text("Não foi possível cadastrar o paciente. Tente novamente."))
            }
            .navigationDestination(isPresented: $navigateToSignInView) {
                SignInView()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
