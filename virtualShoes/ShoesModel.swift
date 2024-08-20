//
//  ShoesModel.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 20/8/24.
//

import Foundation

struct ShoeModel: Codable, Identifiable, Hashable{
    let id: Int
    let name: String
    let brand: String
    let size: [Int]
    let price: Double
    let description: String
    let model3DName: String
    let type: String
    let materials: [String]
    let origin: String
    let gender: String
    let weight: Double
    let colors: [String]
    let warranty: Int
    let certifications: [String]
}

extension ShoeDTO {
    var toPresentation: ShoeModel {
        ShoeModel(id: id,
                  name: name,
                  brand: brand,
                  size: size,
                  price: price,
                  description: description,
                  model3DName: model3DName,
                  type: type,
                  materials: materials,
                  origin: origin,
                  gender: gender,
                  weight: weight,
                  colors: colors,
                  warranty: warranty,
                  certifications: certifications
                  )
                
    }
}
