//
//  LocationManager.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 14/11/24.
//

import SwiftUI
import MapKit
import CoreLocation

// Custom struct for map annotations
struct Landmark: Identifiable {
    let id = UUID()
    let mapItem: MKMapItem
    
    var coordinate: CLLocationCoordinate2D {
        mapItem.placemark.coordinate
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8518, longitude: 14.2681), // Naples coordinates
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var landmarks: [Landmark] = []
    
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            stopUpdatingLocation() // Optionally stop updating after the first update
        }
    }
    
    func searchForPlaces(query: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let error = error {
                print("Search error: \(error.localizedDescription)")
                return
            }
            
            if let response = response {
                DispatchQueue.main.async {
                    self.landmarks = response.mapItems.map { Landmark(mapItem: $0) }
                    if self.landmarks.isEmpty {
                        print("No results found for query: \(query)")
                    }
                }
            }
        }
    }
}
