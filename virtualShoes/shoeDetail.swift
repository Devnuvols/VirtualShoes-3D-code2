//
//  shoeDetail.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 20/8/24.
//

import SwiftUI

struct shoeDetail: View {
    let selectetShoe: ShoeModel
    
    var body: some View {
        Form {
            Section {
                Text( .init(selectetShoe.description))
            } header: {
                Text("Descripción")
            }
            Section {
                Text( .init(selectetShoe.gender))
                LabeledContent("Origen", value: "\(selectetShoe.origin)")
                LabeledContent("Genero", value: "\(selectetShoe.gender)")
                LabeledContent("Tipo", value: "\(selectetShoe.type)")
                LabeledContent("Brand", value: "\(selectetShoe.brand)")
                LabeledContent("Peso", value: "\(selectetShoe.weight) kg")
                LabeledContent("Garantía", value: "\(selectetShoe.warranty) años")
            } header: {
                Text("Características")
            }
            Section{
                Text(selectetShoe.size.map { String($0) }.joined(separator: ", "))
            } header: {
                Text("Tallas")
            }
            Section{
                Text(selectetShoe.colors.map { String($0) }.joined(separator: ", "))
            } header: {
                Text("Colores")
            }
            Section{
                Text(selectetShoe.materials.map { String($0) }.joined(separator: ", "))
            } header: {
                Text("Materiales")
            }
            Section {
                Text("\(String(selectetShoe.price)) €")
            } header: {
                Text("Precio")
            }
        }
        .navigationTitle(selectetShoe.name)
    }
}

#Preview {
    NavigationStack {
        
        shoeDetail(selectetShoe: .test)
    }
    .frame(width: 400)
}

