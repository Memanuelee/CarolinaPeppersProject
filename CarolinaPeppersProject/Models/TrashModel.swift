//
//  TrashModel.swift
//  LoopApp
//
//  Created by Emanuele Bazzicalupo on 23/10/24.
//

import SwiftUI
import Foundation

struct TrashModel: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let position: CGPoint
}
