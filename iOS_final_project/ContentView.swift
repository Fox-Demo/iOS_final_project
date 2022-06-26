//
//  ContentView.swift
//  iOS_final_project
//
//  Created by li on 2022/6/12.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var userInfor = UserInfor()
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        TabView{
            homePage()
                .tabItem{
                    Label("home page", systemImage: "house")
                }
            MapPage()
                .tabItem{
                    Label("google map", systemImage: "map")
                }
            memberPage()
                .tabItem{
                    Label("profile", systemImage: "person")
                }
//            memberPage()
            AboutView()
                .tabItem{
                    Label("setting", systemImage: "gearshape")
                }
        }
        .environmentObject(userInfor)
        .environmentObject(viewModel)
    }
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager?
    var latitude = 0.0
    var longitude = 0.0
    var MapLocations: [BusStopNearBy] = []
    var nearStops: [nearStop] = []
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    func checkIfLocationServiceIsEnable(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            latitude = locationManager?.location?.coordinate.latitude ?? 0.0
            longitude = locationManager?.location?.coordinate.longitude ?? 0.0
            makeAnnotation()
            calculateDistance()
        }else{
            print("Turn it on")
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func makeAnnotation(){
        let tdxApi = tdxAPI()
        tdxApi.getBusStopNearBy(latitude: self.latitude, longitude: self.longitude, top: 30){ data in
            self.MapLocations = data
        }
    }
    
    func calculateDistance(){
        let userCurrenLocation = CLLocation(latitude: latitude, longitude: longitude)
        for place in self.MapLocations{
            let distanceInMeters = userCurrenLocation.distance(from: place.distance)
            let Row = nearStop(busId: place.id ?? "0", name: place.stopName?.Zh_tw ?? "Stop" , distance: distanceInMeters)
            self.nearStops.append(Row)
        }
        self.nearStops.sort {
            $0.distance < $1.distance
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
