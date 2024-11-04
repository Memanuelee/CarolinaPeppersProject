//
//  ContentView.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 30/10/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
        }
        .tint(.green)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .black
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

#Preview {
    ContentView()
}
