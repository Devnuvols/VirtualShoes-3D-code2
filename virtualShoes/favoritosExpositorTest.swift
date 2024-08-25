//
//  favoritosExpositorTest.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 25/8/24.
//

import SwiftUI
import RealityKit
import shoes3D

struct favoritosExpositorTest: View {
    
    @Environment(ShoesViewModel.self) private var shoesVM
   
    var body: some View {
        HStack {
            Section(header: Text("Zapatos Todos")) {
                List {
                    ForEach(shoesVM.shoes) { shoe in
                        Text("\(shoe.name) - favorito=\(shoe.favorito)")
                        
                    }
                }
            }
            Section(header: Text("Zapatos Favoritos")) {
                List {
                    ForEach(shoesVM.shoes.filter { $0.favorito }) { shoe in
                        Text("\(shoe.name) - favorito=\(shoe.favorito)")
                    }
                }
            }
        }
    }
}


#Preview(windowStyle: .volumetric) {
    let vm = ShoesViewModel(interactor: DataTest())
    
    favoritosExpositorTest()
        .environment(vm)
        .onAppear{
            vm.selectedShoe = vm.shoes.first
        }
        
}
