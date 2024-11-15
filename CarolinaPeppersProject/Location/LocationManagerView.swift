//
//  LocationManagerView.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 14/11/24.
//


import SwiftUI
import MapKit

struct LocationManagerView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var searchQuery = ""
    
    var body: some View {
        ZStack {
            // Map view with full screen layout
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: locationManager.landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text("MyBin")  // Use a static label "MyBin" for each annotation
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)  // Makes map full screen
            
            VStack {
                // Search bar with black background and white input area
                HStack {
                    TextField("Search for places", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 8)
                        .background(Color.white) // Makes text input area white
                        .cornerRadius(8)
                        .padding(.horizontal, 8)
                    
                    Button(action: {
                        locationManager.searchForPlaces(query: searchQuery)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 8)
                }
                .padding()
                .background(Color.white) // Makes the search bar background black
                
                Spacer()
                
                // Show Current Location Button
                Button(action: {
                    locationManager.startUpdatingLocation()
                }) {
                    Text("Show My Current Location")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .background(Color.white) // Ensures the entire view background is white
    }
}

struct LocationManagerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationManagerView()
    }
}
