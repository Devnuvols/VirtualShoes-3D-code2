//
//  modelDTO.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 20/8/24.
//

import Foundation


struct ShoeDTO: Codable {
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
