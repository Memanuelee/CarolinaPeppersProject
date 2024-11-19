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
            TrashModel(name: "bag", image: "bag", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "bagflip", image: "bagflip", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "bottle", image: "bottle", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "bottleflip", image: "bottleflip", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "journal", image: "journal", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "journalflip", image: "journalflip", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "cigarette", image: "cigarette", position: TrashRepository.getRandomPosition()),
            TrashModel(name: "cigaretteflip", image: "cigaretteflip", position: TrashRepository.getRandomPosition())
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
