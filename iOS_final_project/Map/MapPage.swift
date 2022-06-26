//
//  MapPage.swift
//  iOS_final_project
//
//  Created by li on 2022/6/24.
//

import SwiftUI
import MapKit



struct MapPage: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View{
        VStack{
            Text("Map")
                .font(.system(.title))
                .padding(.top,50)
            VStack{
                Map(coordinateRegion: $viewModel.region,
                    showsUserLocation: true,
                    annotationItems: viewModel.MapLocations,
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
                    
            }
            .cornerRadius(50)
            .padding(.bottom,20)
        }
        .frame(width: 350, height: 680)
    }
    
}
struct MapPage_Previews: PreviewProvider {
    static var previews: some View {
        MapPage()
    }
}

