//
//  TrashRepository.swift
//  LoopApp
//
//  Created by Emanuele Bazzicalupo on 23/10/24.
//

import SwiftUI

class TrashRepository: ObservableObject, Observable {
    
    static var allTrash: [TrashModel] {
        return [
            TrashModel(name: "Bag", image: "Bag", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "Bagflip", image: "Bagflip", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "Bottle", image: "Bottle", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "Bottleflip", image: "Bottleflip", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "Journal", image: "Journal", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "Journalflip", image: "Journalflip", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "Cigarette", image: "Cigarette", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "Cigaretteflip", image: "Cigaretteflip", position: TrashRepository.getRandomPosition())
        ]
    }
    
    @Published var bin: [TrashModel] = TrashRepository.allTrash
    @Published var awardedPoints: Int = 0
    @Published var removedTrash: Int = 0
        
    func removeAmountOfTrash(amount: Int) {
        let validAmountToRemove: Int = min(bin.count, amount)
        removedTrash += validAmountToRemove
        bin.removeLast(validAmountToRemove)
        
        if bin.isEmpty {
            bin = TrashRepository.allTrash
        }
    }
    
    static func getRandomPosition() -> CGPoint {
        return CGPoint(
            x: Double.random(in: UIScreen.main.bounds.minX ... UIScreen.main.bounds.maxX),
            y: Double.random(in: 300 ... UIScreen.main.bounds.maxY)
        )
    }
}
