//
//  shoeVolumen.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 23/8/24.
//

import SwiftUI
import RealityKit
import shoes3D

struct shoeVolumen: View {
    @Environment(ShoesViewModel.self) private var shoesVM
    var body: some View {
        RealityView { content in
            guard let selectedShoe = shoesVM.selectedShoe else { return }
            do {
                let shoe = try await Entity(named: "\(selectedShoe.model3DName)R", in: shoes3DBundle)
                content.add(shoe)
                shoe.position = [-0.2, -0.3, 0.0]
                shoe.scale = [1.0, 1.0, 1.0]
                
            } catch {
                print("Error en la carga \(error)")
            }
            
        }
    }
}

#Preview (windowStyle: .volumetric) {
    let vm = ShoesViewModel(interactor: DataTest())
    
    shoeVolumen()
        .environment(vm)
        .onAppear{
            vm.selectedShoe = vm.shoes.first
        }
}
