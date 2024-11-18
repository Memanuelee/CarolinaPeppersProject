//
//  MenuView.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 15/11/24.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var repository: TrashRepository
    @Environment(\.dismiss) var dismiss
    
    @State private var amountOfTrashToRemove: Int = 1
    @State private var selectedTrash: String = "Bag"
    @State private var selectedImpact: Int = 2
    
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
    let range: ClosedRange<Int> = 1...8
    let step: Int = 1
    let assetsNames = ["Bag", "Bottle", "Journal", "Cigarette"]
    let assetsImpact = [2, 4, 3, 1]
    
    var body: some View {
        
        VStack {
            Text("Clean")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Select the trash to remove")
                .font(.title2)
                .foregroundColor(.white)
            
            HStack {
                ForEach(assetsNames.indices, id: \.self) { index in
                    let assetName = assetsNames[index]
                    let assetImpact = assetsImpact[index]
                    
                    Button {
                        selectedTrash = assetName
                        selectedImpact = assetImpact
                    } label: {
                        Circle()
                            .stroke(.white, lineWidth: 2)
                            .fill(.blue)
                            .overlay {
                                Image(ImageResource(name: assetName, bundle: .main))
                                    .resizable()
                                    .scaledToFit()
                            }
                    }
                }
            }
            .padding()
            
            VStack {
                Text("\(selectedTrash)")
                    .fontWeight(.bold)
                
                Text("Environmental Impact: \(selectedImpact)")
                
                Divider()
                
                Stepper(value: $amountOfTrashToRemove, in: range, step: step) {
                    Text("\(amountOfTrashToRemove)")
                        .padding(.horizontal, 40)
                }
            }
            .padding()
            .foregroundColor(.black)
            .background(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .stroke(.black, lineWidth: 2)
                .fill(.yellow)
            )
            .padding(.horizontal, 85)
            
            Spacer()
            
            Button {
                let valueOfTrash: Int
                
                switch selectedTrash {
                case "Bag":
                    valueOfTrash = 2
                case "Bottle":
                    valueOfTrash = 4
                case "Journal":
                    valueOfTrash = 3
                case "Cigarette":
                    valueOfTrash = 1
                default:
                    valueOfTrash = 1
                }
                repository.awardedPoints += (valueOfTrash * amountOfTrashToRemove)
                repository.removeAmountOfTrash(amount: amountOfTrashToRemove)
                
                dismiss()
            } label: {
                Text("Clean the Ocean")
                    .padding()
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.white, lineWidth: 2)
                    )
            }
            .background(.blue) // If you have this
            .cornerRadius(50)
        }
        .background(
            ZStack {
                Rectangle()
                    .fill(Color(.yellow))
                
                WaterWave(progress: 0.95, waveHeight: 0.01, offset: startAnimation)
                    .fill(Color(.blue))
                
                Spacer()
                
                WaterWave(progress: 0.90, waveHeight: 0.01, offset: startAnimation)
                    .fill(Color("ocean"))
            }
                .ignoresSafeArea()
        )
    }
}

#Preview {
    MenuView()
}
