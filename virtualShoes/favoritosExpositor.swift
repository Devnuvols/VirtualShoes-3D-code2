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
    @Environment(\.openWindow) private var open
   
    @State private var touch = false
    @State private var rotate = true
    @State private var rotationAngle: Double = 0.0
   
    @State private var escala:Double = 0.4
    
    @State private var touched = false
    
    var body: some View {
        let columnas: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
        
        VStack {
            Text("Zapatos favoritos")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()                       
            ScrollView {
                LazyVGrid(columns: columnas, spacing: 10) {
                    
                    ForEach(shoesVM.shoes.filter { $0.favorito }) { shoe in
                        ZStack {
                            Text(shoe.name)
                                .padding()
                                .background(Color.cyan.opacity(0.7))
                                .glassBackgroundEffect()
                                .cornerRadius(10)
                                .padding(4)
                                .gesture(
                                    TapGesture()
                                        .onEnded {
                                            touched.toggle()
                                            shoesVM.selectedShoe = shoe
                                            print("zapato seleccionado \(shoe.name)")
                                            open(id: "shoesFavoDetail")
                                    }
                                    )
                            Model3D(named: "\(shoe.model3DName)R", bundle: shoes3DBundle){
                                model in
                                model
                                    .resizable()
                                    .scaleEffect(touch ? escala: 0.4)
                                    .offset(y: -80)
                                    .offset(z: -80)
                                .rotation3DEffect(.degrees(rotationAngle), axis: (x:0, y: -1, z:0))
                            } placeholder: {
                                ProgressView()
                            }
                            .gesture(
                               TapGesture()
                                    .onEnded { _ in
                                        touched.toggle() // cambiar variable tocado
                                        shoesVM.selectedShoe = shoe
                                        print("zapato seleccionado \(shoe.name)")
                                        open(id: "shoesFavoDetail")
                                    }
                                )
                        }
                        .frame(height: 200)
                    }
                }
                .padding()
                .padding(100)
                .onAppear(){
                    rotacion()
                    shoesVM.selectedShoe = shoesVM.shoes.first}
            }
        }
    }
    func rotacion() {
        Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true){
            timer in
            if rotate{
                rotationAngle += 0.2
                if rotationAngle >= 360 { rotationAngle = 0}
            }
                
        }
    }
}

#Preview(windowStyle: .automatic) {
    let vm = ShoesViewModel(interactor: DataTest())
    
    favoritosExpositor()
        .environment(vm)
        .onAppear{
            vm.selectedShoe = vm.shoes.first
        }
        
}
