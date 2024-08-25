//
//  virtualShoesApp.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 20/8/24.
//

import SwiftUI

@main
struct virtualShoesApp: App {
    @State var shoesVM  = ShoesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(shoesVM)
        }
        
        WindowGroup (id: "shoeVolumetric") {
            shoeVolumen()
                .environment(shoesVM)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1.0, height: 1.0, depth: 1.0, in: .meters)
        
        WindowGroup (id: "shoesFavoTest"){
            favoritosExpositorTest()
                .environment(shoesVM)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1.0, height: 1.0, depth: 1.0, in: .meters)
    
        WindowGroup(id: "shoesFavo"){
            favoritosExpositor()
                .environment(shoesVM)
        }
    }
}
