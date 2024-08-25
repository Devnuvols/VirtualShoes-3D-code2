//
//  ShoesViewModel.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 20/8/24.
//

import SwiftUI
@Observable


final class ShoesViewModel {
    let interactor: DataInteractor
    
    var shoes: [ShoeModel] = []
    var selectedShoe: ShoeModel?
    
    @ObservationIgnored var errorMsg = ""
    var showAlert = false
    
    init(interactor: DataInteractor = Interactor() ) {
        self.interactor = interactor
        do {
            self.shoes = try interactor.getShoes()
        } catch {
            self.shoes=[]
            errorMsg = "Error en la carga del JSON \(error)."
            showAlert.toggle()
        }
    }
    // Cambia el valor de "favorito" para un zapato en particular
     //  func toggleFavorito(for shoe: ShoeModel) {
     //      if let index = shoes.firstIndex(where: { $0.id == shoe.id }) {
     //          shoes[index].favorito.toggle()
     //      }
     //  }
}
