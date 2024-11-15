//
//  SaiyansRepository.swift
//  LoopApp
//
//  Created by Emanuele Bazzicalupo on 23/10/24.
//


import SwiftUI

class ObjectiveRepository: ObservableObject {
    static let shared = ObjectiveRepository()
    private init() {}

    @Published var objectives: [ObjectiveModel] = []
}
