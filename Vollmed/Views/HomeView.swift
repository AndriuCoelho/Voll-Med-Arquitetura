//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 29/08/23.
//

import SwiftUI

struct HomeView: View {
    var viewModel = HomeViewModel()
    
    @State private var specialists: [Specialist] = []
    
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
                do {
                    let response = try await viewModel.getSpecialists()
                    self.specialists = response
                    
                    
                    var listaDeCompras = ListaDeCompras<String, Int>()
                    
                    listaDeCompras.adicionarItem("Caneta para quadro branco", quantidade: 3)
                    listaDeCompras.adicionarItem("Caderno de anotações", quantidade: 1)
                    listaDeCompras.adicionarItem("Grafite 0.7", quantidade: 2)
                    
                    print("lista de compras:")
                    listaDeCompras.listarItens()
                    
                    print("------")
                    
                    var listaDeAlimentos = ListaDeCompras<String, Bool>()
                    
                    listaDeAlimentos.adicionarItem("Tomate", quantidade: false)
                    listaDeAlimentos.adicionarItem("Alface", quantidade: true)
                    listaDeAlimentos.adicionarItem("Banana", quantidade: true)
                    
                    listaDeAlimentos.listarItens()
                    
                    
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        await viewModel.logout()
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
