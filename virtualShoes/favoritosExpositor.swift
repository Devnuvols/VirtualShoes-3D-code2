//
//  favoritosExpositor.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 24/8/24.
//

import SwiftUI
import RealityKit
import shoes3D

struct favoritosExpositor: View {
    
    @Environment(ShoesViewModel.self) private var shoesVM
   
    var body: some View {
        let columnas: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
        ScrollView {
            LazyVGrid(columns: columnas, spacing: 100) {
                
                ForEach(shoesVM.shoes.filter { !$0.favorito }) { shoe in
                    Text(shoe.name)
                        .padding()
                        .background(Color.cyan)
                        .glassBackgroundEffect()
                        .cornerRadius(10)
                }
            }
            .padding()
            .padding(100)
        }
        
    }
}
/*
#Preview(windowStyle: .automatic) {
    favoritosExpositor.preview}
*/

#Preview(windowStyle: .automatic) {
    let vm = ShoesViewModel(interactor: DataTest())
    
    favoritosExpositor()
        .environment(vm)
        .onAppear{
            vm.selectedShoe = vm.shoes.first
        }
        
}
