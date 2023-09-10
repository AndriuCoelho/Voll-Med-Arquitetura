//
//  ContentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 29/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authenticationManager = AuthenticationManager.shared

    var body: some View {
        if authenticationManager.token == nil {
            NavigationStack {
                SignInView()
            }
        } else {
            TabView {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                NavigationStack {
                    MyAppointmentsView()
                }
                .tabItem {
                    Label("Minhas consultas", systemImage: "calendar")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
