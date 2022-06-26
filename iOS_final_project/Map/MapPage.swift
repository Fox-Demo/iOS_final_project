//
//  MapPage.swift
//  iOS_final_project
//
//  Created by li on 2022/6/24.
//

import SwiftUI
import MapKit



struct MapPage: View {
    @StateObject private var viewModel = ContentViewModel()
    @State var MapLocations: [BusStopNearBy] = []
    @State var nearStops: [nearStop] = []
    
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
                                Text(location.stopName?.Zh_tw ?? "Stop")
                                    .fixedSize()
                            }.padding(10)
                        }
                    })
                    .ignoresSafeArea()
                    .onAppear{
                        viewModel.checkIfLocationServiceIsEnable()
                        self.makeAnnotation()
                        self.calculateDistance()
                    }
            }
            .cornerRadius(50)
            .padding(.bottom,20)
        }
        .frame(width: 350, height: 680)
    }
    
    func makeAnnotation(){
        let tdxApi = tdxAPI()
        tdxApi.getBusStopNearBy(latitude: self.$viewModel.latitude, longitude: self.$viewModel.longitude, top: 30){ data in
            self.MapLocations = data
        }
    }
    func calculateDistance(){
        let Lat = self.$viewModel.latitude.wrappedValue
        let Lon = self.$viewModel.longitude.wrappedValue
        let userCurrenLocation = CLLocation(latitude: Lat, longitude: Lon)
        for place in self.MapLocations{
            let distanceInMeters = userCurrenLocation.distance(from: place.distance)
            let Row = nearStop(busId: place.id ?? "0", name: place.stopName?.Zh_tw ?? "Stop" , distance: distanceInMeters)
            nearStops.append(Row)
        }
        nearStops.sort {
            $0.distance < $1.distance
        }
    }
}
struct MapPage_Previews: PreviewProvider {
    static var previews: some View {
        MapPage()
    }
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager?
    var latitude = 0.0
    var longitude = 0.0
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    func checkIfLocationServiceIsEnable(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            latitude = locationManager?.location?.coordinate.latitude ?? 0.0
            longitude = locationManager?.location?.coordinate.longitude ?? 0.0
            
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
}
