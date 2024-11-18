//
//  ContentView.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 30/10/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @StateObject var repository = TrashRepository()
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    MyBadgesView().environment(repository)
                } label: {
                    ZStack {
                        Image("badge")
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.yellow)
                    }
                }
                
                Spacer()
                
                NavigationLink {
                    MenuView().environment(repository)
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            .padding()
            .background(
                ZStack {
                    Rectangle()
                        .fill(Color(.yellow))
                                        
                    WaterWave(progress: 0.7, waveHeight: 0.01, offset: startAnimation)
                        .fill(Color(.blue))
                        .onAppear { withAnimation (
                            .linear(duration: 2)
                            .repeatForever(autoreverses: false)){
                                startAnimation = 360 //size.width
                            }
                        }
                    
                    Spacer()
                    
                    WaterWave(progress: 0.65, waveHeight: 0.01, offset: startAnimation)
                        .fill(Color("ocean"))
                        .onAppear { withAnimation (
                            .linear(duration: 2)
                            .repeatForever(autoreverses: false)){
                                startAnimation = 360 //size.width
                            }
                        }
                    
                    ForEach(repository.bin.indices, id: \.self) { index in
                        let trash = repository.bin[index]
                        Image(trash.image)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .position(x: trash.position.x, y: trash.position.y)
                    }
                    
//                    if repository.bin.count == 8 {
//                        VStack {
//                            Text("New Trash Appeared!")
//                                .bold()
//                        }
//                        .padding()
//                        .background(
//                            RoundedRectangle(
//                                cornerRadius: 20,
//                                style: .continuous
//                            )
//                            .stroke(.black, lineWidth: 2)
//                            .fill(.white.shadow(.drop(color: .black, radius: 5)))
//                        )
//                    }
                }
                    .ignoresSafeArea()
            )
        }
        .accentColor(.white)
    }
}

#Preview {
    ContentView()
}
