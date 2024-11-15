//
//  sfondoanimato.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 13/11/24.
//

import SwiftUI

struct Wallpaper: View {
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Rectangle()
                        .fill(Color(.yellow))
                }
                
                WaterWave(progress: 0.7, waveHeight: 0.01, offset: startAnimation)
                    .fill(Color(.blue))
                    .overlay(content: {
                        Circle()
                            .frame(width: 0, height: 0)
                            .onAppear { withAnimation (
                                .linear(duration: 2)
                                .delay(0.01)
                                .repeatForever(autoreverses: true)){
                                    startAnimation = 600 //size.width
                                }
                            }
                    })
            }
        }
        .ignoresSafeArea()
    }
}

struct WaterWave: Shape {
    
    var progress: CGFloat
    var waveHeight: CGFloat
    var offset: CGFloat
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: .zero)
            
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2){
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (sine * height)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: 1000, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
       }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Wallpaper()
    }
}
