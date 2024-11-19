//
//  MyBadgesView.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 30/10/24.
//

import SwiftUI

private extension Double {
    var asInt: Int {
        return Int(self)
    }
}

struct RewardView: View {
    
    @EnvironmentObject var repository: TrashRepository
    
    let image: String
    var title: String
    var description: String
    var progress: Double
    var goal: Double = 0
    
    init(image: String, title: String, description: String, progress: Int, goal: Double) {
        self.image = image
        self.title = title
        self.description = description
        self.progress = Double(progress)
        self.goal = goal
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if(repository.removedTrash >= Int(goal)) {
                    Image(image)
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color("ocean"))
                }else{
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.orange)
                    
                    Text("???")
                        .font(.headline)
                        .foregroundColor(Color("ocean"))
                }
            }
                                    
            Text(description)
                .font(.subheadline)
                .foregroundColor(.black)
            
            Divider()
            
            HStack {
                let currentProgress = min(progress, goal)
                Text("\(currentProgress.asInt)/\(goal.asInt)")
                
                ProgressView(value: currentProgress, total: goal)
                    .tint(Color.blue)
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                
                Spacer()
                
                let percentNumber = (progress * 100) / goal
                if percentNumber > 100 {
                    Text("100%")
                }else{
                    Text("\(percentNumber.asInt)%")
                }
            }
            .font(.caption)
            .foregroundColor(.black)
        }
        .padding()
        .background(.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct MyBadgesView: View {
    
    @EnvironmentObject var repository: TrashRepository
    @Environment(\.dismiss) var dismiss
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
    var body: some View {
        
        VStack {
            Text("My Badges")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("Total Co2 Saved: \(repository.awardedPoints)")
                .font(.title2)
                .foregroundColor(.black)
                        
            ScrollView {
                VStack(spacing: 20) {
                    // Sample rewards for testing
                    RewardView(
                        image: "piccione",
                        title: "Ocean Saver",
                        description: "Clean for the first time.",
                        progress: repository.removedTrash,
                        goal: 1
                    )
                    RewardView(
                        image: "turtle",
                        title: "Marine Hero",
                        description: "Clean 10 trash.",
                        progress: repository.removedTrash,
                        goal: 10
                    )
                    RewardView(
                        image: "piccionecapitano",
                        title: "Coast Captain",
                        description: "Clean 20 trash.",
                        progress: repository.removedTrash,
                        goal: 20
                    )
                    RewardView(
                        image: "fish",
                        title: "Echo Champion",
                        description: "Clean 50 trash.",
                        progress: repository.removedTrash,
                        goal: 50
                    )
                }
                
                Spacer()
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .padding()
        .background(
            ZStack {
                Rectangle()
                    .fill(Color(.yellow))
                
                WaterWave(progress: 0.10, waveHeight: 0.01, offset: startAnimation)
                    .fill(Color(.blue))
                
                Spacer()
                
                WaterWave(progress: 0.05, waveHeight: 0.01, offset: startAnimation)
                    .fill(Color("ocean"))
            }
                .ignoresSafeArea()
        )
    }
}
