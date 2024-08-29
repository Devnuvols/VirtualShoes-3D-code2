//
//  ContentView.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 20/8/24.
//

import SwiftUI
import RealityKit
import shoes3D

struct ContentView: View {
    @Environment(ShoesViewModel.self) private var shoesVM
    @Environment(\.openWindow) private var open
    
    @State private var favorito = false
    @State private var touch = false
    @State private var rotate = false
    @State private var rotationAngle: Double = 0.0
    
    @State private var currentRotationY:CGFloat = 0.0 
    @State private var lastDragValueY: CGFloat = 0.0
    @State private var velocityY: CGFloat = 0.0
    @State private var currentRotationX:CGFloat = 0.0
    @State private var lastDragValueX: CGFloat = 0.0
    @State private var velocityX: CGFloat = 0.0
    
    @State private var escala:Double = 0.6
    @State private var escalaInicial: CGFloat = 0.6
    
    
    var body: some View {
        @Bindable var shoesBindable = shoesVM
        
        NavigationSplitView {
            List(selection: $shoesBindable.selectedShoe){
                ForEach(shoesVM.shoes) { shoe in Text(shoe.name)
                        .tag(shoe)
                    
                }
            }
            .navigationTitle("Zapatos")
            .navigationSplitViewColumnWidth(200)
            .toolbar{
                ToolbarItem(placement: .bottomOrnament){
                    HStack (spacing: 30){
                        Toggle(isOn: $rotate){
                            Image(systemName: "rotate.3d")
                        }
                        .toggleStyle(.button)
                        
                        if let selectedShoe = shoesVM.selectedShoe{
                            Text(selectedShoe.name)
                                .frame(width: 200)
                                .padding(10)
                                .glassBackgroundEffect()
                        }
                        Toggle(isOn: $touch){
                            Image(systemName: "hand.tap")
                        }
                        .toggleStyle(.button)
                        .disabled(rotate)
                        Button {
                            open(id: "shoeVolumetric")
                        } label: {
                            Text("Ver en detalle 3D")
                        }
                        Toggle(
                            isOn: Binding(
                                get: { shoesVM.selectedShoe?.favorito ?? false },
                                set: { newValue in
                                    shoesVM.selectedShoe?.favorito = newValue
                                    
                                    if let index = shoesVM.shoes.firstIndex(where: { $0.id == shoesVM.selectedShoe?.id }) {
                                        shoesVM.shoes[index].favorito = newValue
                                     }
                                }
                            )) {
                            Image(systemName: shoesVM.selectedShoe?.favorito == true ? "star.fill" : "star")
                        }
                        .toggleStyle(.button)
                        Button {
                            open(id: "shoesFavo")
                        } label: {
                            Text("Ver favoritos")
                        }
                    }
                    
                }
                }
        } content: {
            if let selectedShoe = shoesVM.selectedShoe {
                Text(selectedShoe.name)
                shoeDetail(selectetShoe: selectedShoe)
            } else {
                Text("Seleccionar un zapato de la lista")
            }
        } detail: {
            if let selectedShoe = shoesVM.selectedShoe{
                Model3D(named: selectedShoe.model3DName, bundle: shoes3DBundle){
                    model in
                    model
                        .resizable()
                        .scaleEffect(touch ? escala : 0.5)
                        .rotation3DEffect(.degrees(rotationAngle), axis: (x:0, y: -1, z:0))
                    
                        .rotation3DEffect(.degrees(Double(currentRotationY)), axis: (x:0, y: -1, z:0))
                        .rotation3DEffect(.degrees(Double(currentRotationX)), axis: (x: -1, y: 0, z:0))
                        
                } placeholder: {
                    ProgressView()
                }
                .gesture(
                        DragGesture()
                            .onChanged { value in
                                let deltaY = value.translation.width - lastDragValueY
                                let deltaX = value.translation.height - lastDragValueX
                                velocityY = deltaY/10
                                velocityX = deltaX/10
                                lastDragValueY = value.translation.width
                                lastDragValueX = value.translation.height
                                if touch {
                                    currentRotationY -= velocityY
                                    currentRotationX += velocityX
                                }
                            }
                            .onEnded{_ in
                                lastDragValueY = 0.0
                                lastDragValueX = 0.0
                            }
                        )
                 
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            if value.magnification < 1 && value.magnification > 0.4 {
                                escala = (1.0 - (value.magnification + escalaInicial))
                        }
                    }
                    .onEnded {value in escalaInicial = value.magnification
                    }
            )
            }
            
        }
        .onAppear(){
            rotacion()
            shoesVM.selectedShoe = shoesVM.shoes.first
            favorito = shoesVM.selectedShoe?.favorito ?? false
                    
        }
        .alert("App error",
               isPresented: $shoesBindable.showAlert) {} message: {
            Text(shoesVM.errorMsg)
        }
        
    }
    func rotacion() {
        Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true){
            timer in
            if rotate{
                rotationAngle += 0.1
                if rotationAngle >= 360 { rotationAngle = 0}
            }
                
        }
    }
}




#Preview(windowStyle: .automatic) {
    ContentView.preview
}
