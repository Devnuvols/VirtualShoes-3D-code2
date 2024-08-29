//
//  favoritosDetail.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 28/8/24.
//

import SwiftUI
import RealityKit
import shoes3D

struct favoritosDetail: View {
   
    @Environment(ShoesViewModel.self) private var shoesVM
    
    var body: some View {
        let verShoe = shoesVM.selectedShoe
     
        VStack {
            Text(verShoe!.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Form {
                Section {
                    Text( .init(verShoe!.description))
                } header: {
                    Text("Descripción")
                }
                Section {
                    Text( .init(verShoe!.gender))
                    LabeledContent("Origen", value: "\(verShoe!.origin)")
                    LabeledContent("Genero", value: "\(verShoe!.gender)")
                    LabeledContent("Tipo", value: "\(verShoe!.type)")
                    LabeledContent("Brand", value: "\(verShoe!.brand)")
                    LabeledContent("Peso", value: "\(verShoe!.weight) kg")
                    LabeledContent("Garantía", value: "\(verShoe!.warranty) años")
                } header: {
                    Text("Características")
                }
                Section{
                    Text(verShoe!.size.map { String($0) }.joined(separator: ", "))
                } header: {
                    Text("Tallas")
                }
                Section{
                    Text(verShoe!.colors.map { String($0) }.joined(separator: ", "))
                } header: {
                    Text("Colores")
                }
                Section{
                    Text(verShoe!.materials.map { String($0) }.joined(separator: ", "))
                } header: {
                    Text("Materiales")
                }
                Section {
                    Text("\(String(verShoe!.price)) €")
                } header: {
                    Text("Precio")
                }
            }
        }
    }
}


