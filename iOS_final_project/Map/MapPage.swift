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
            Text("附近站牌")
                .font(.system(.title))
                .bold()
                .padding(.top,50)
            VStack{
                Map(coordinateRegion: $viewModel.region,
                    showsUserLocation: true,
                    annotationItems: viewModel.MapLocations,
                    annotationContent: { location in
                        MapAnnotation(coordinate: location.coordinate){
                            VStack {
                                Text(location.stopName?.Zh_tw ?? "Stop")
                                    .font(.system(size: 10))
                                    .frame(width: 80, height: 20)
                                    .background(Color.white.opacity(0.7))
                                    .fixedSize()
                                    .overlay(RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 1)
                                    )
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.red)
                                
                            }.padding(10)
                        }
                    })
                    .ignoresSafeArea()
            }
            .frame(width: 350, height: 550)
            .cornerRadius(50)
            .padding(.bottom,20)
        }
        .frame(width: 400, height: 750)
    }
    
}
struct MapPage_Previews: PreviewProvider {
    static var previews: some View {
        MapPage()
    }
}

