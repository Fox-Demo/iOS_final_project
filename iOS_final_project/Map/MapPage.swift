//
//  MapPage.swift
//  iOS_final_project
//
//  Created by li on 2022/6/24.
//

import SwiftUI
import MapKit

struct MapLocation: Identifiable{
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapPage: View {
    @StateObject private var viewModel = ContentViewModel()
    
    let MapLocations = [
        MapLocation(name: "Chilren", latitude: 25.097239, longitude: 121.514942),
        MapLocation(name: "Taipei", latitude: 25.142235, longitude: 121.569657)
    ]
    
    var body: some View{
        VStack{
            Text("Map")
                .font(.system(.title))
                .padding(.top,50)
            VStack{
                Map(coordinateRegion: $viewModel.region,
                    showsUserLocation: true,
                    annotationItems: MapLocations,
                    annotationContent: { location in
                    MapAnnotation(coordinate: location.coordinate){
                        HStack {
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                            Text("Hello")
                                .fixedSize()
                        }.padding(10)
                    }
                })
                .frame(width: 330, height: 630)
                .ignoresSafeArea()
                .onAppear{
                    print("ONAPPEAR")
                    viewModel.checkIfLocationServiceIsEnable()
                }
            }
            .cornerRadius(50)
            .padding(.bottom,20)
        }
        .frame(width: 350, height: 680)
    }
}

struct MapPage_Preview: PreviewProvider {
    static var previews: some View {
        MapPage()
    }
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    func checkIfLocationServiceIsEnable(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
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
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
