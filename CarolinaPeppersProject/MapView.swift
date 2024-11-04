//
//  MapView.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 30/10/24.
//

import SwiftUI

struct MapView: View {
    
    var body: some View {
        Color.blue
            .ignoresSafeArea()
            .overlay(
                VStack {
                    AsyncImage(url: URL(string: "https://www.clker.com//cliparts/u/J/Y/T/M/Z/map-of-italy-hi.png")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.blue
                    }
                    .frame(width: 380, height: 476)
                }
                .padding()
            )
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
