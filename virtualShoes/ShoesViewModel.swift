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
  
}
