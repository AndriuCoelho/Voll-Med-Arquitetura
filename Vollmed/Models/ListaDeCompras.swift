//
//  ListaDeCompras.swift
//  Vollmed
//
//  Created by Ândriu F Coelho on 14/09/23.
//

import Foundation

struct ListaDeCompras<T, U> {
    
    private var items = [(T, U)]()
    
    mutating func adicionarItem(_ item: T, quantidade: U) {
        items.append((item, quantidade))
    }
    
    func listarItens() {
        for (item, quantidade) in items {
            print("- \(quantidade) x \(item)")
        }
    }
}
