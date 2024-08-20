//
//  DataInteractor.swift
//  virtualShoes
//
//  Created by Miguel Monllau on 20/8/24.
//

import Foundation

protocol DataInteractor:JSONInteractor {
    var url: URL { get }
    func getShoes() throws -> [ShoeModel]
}

extension DataInteractor {
    var url: URL{Bundle.main.url(forResource: "shoes", withExtension: "json")!}
    func getShoes() throws -> [ShoeModel]{
        try loadJSON(url: url, type: [ShoeDTO].self).map(\.toPresentation)
    }
}

struct Interactor:DataInteractor, JSONInteractor {
    static let shared = Interactor()
}
