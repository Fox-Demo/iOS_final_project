//
//  homePage.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/21.
//

import SwiftUI
import Combine
import MapKit

struct homePage: View {
    @State var weather: WeatherData?
    @State var weatherWx: WeatherElement?
    @State var weatherPop: WeatherElement?
    @State var weatherMinT: WeatherElement?
    @State var weatherCI: WeatherElement?
    @State var weatherMaxT: WeatherElement?
    @State private var busRoute = ""
    @State var searchbus = false
    
    @EnvironmentObject var viewModel: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        VStack(){
            Text("公車即時動態查詢APP")
                .font(.system(size: 25))
                .bold()
                .padding(.top, 50)

            if let weather = weather {
                let parameterWx = weatherWx!.time[0].parameter
                let parameterPop = weatherPop!.time[0].parameter
                let parameterMinT = weatherMinT!.time[0].parameter
                let parameterMaxT = weatherMaxT!.time[0].parameter
                let photoWT = String(parameterWx.parameterValue!)
                let degree = String((Int(parameterMinT.parameterName)! + Int(parameterMaxT.parameterName)!)/2)
                HStack{
                    VStack {
                        Text("\(degree)℃").font(.system(size: 30)).bold()
                        Text("\(parameterMinT.parameterName)℃/\(parameterMaxT.parameterName)℃")
                            .font(.system(size: 15)).bold()
                            .fixedSize()
                    }
                    .frame(width: 100, height: 130)
                    .padding(.leading,10)
                    
                    Divider().frame(width: 2, height: 70).overlay(.gray)
                    
                    Image(photoWT)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding(.leading,20)
                    
                    VStack{
                        Text(parameterWx.parameterName)
                            .font(.system(size: 20))
                            .bold()
                            .multilineTextAlignment(.center)
                        Text("降雨率:\(parameterPop.parameterName)%")
                            .font(.system(size: 12))
                    }
                    .frame(width: 150, height: 140)
                    .padding(.trailing,10)
                }
                .frame(width: 350, height: 130)
                
                Button("尋找公車路線"){
                    searchbus = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .font(.system(size: 20))
                .frame(width: 150, height: 10)
                .foregroundColor(Color(red: 201/255, green: 203/255, blue: 255/255))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 201/255, green: 203/255, blue: 255/255), lineWidth: 3)
                    )
                .padding()
                .sheet(isPresented: $searchbus) {
                    SearchBusView()
                }
             
                List{
                    ForEach (viewModel.nearStops) { stop in
                        nearStopRow(stop: stop)
                    }
                }
                .frame(width: 330, height: 400)
            }else{
                Text("Loading...")
                    .onAppear{
                        self.loadData()
                        viewModel.checkIfLocationServiceIsEnable()
                    }
            }
            Divider()
            Spacer()
        }
        .frame(width: 400, height: 750)
    }
    
    
    func loadData(){
        let url = URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-97F69598-88F8-4EF1-A7D6-F8D68CB225DA&format=JSON&locationName=%E8%87%BA%E5%8C%97%E5%B8%82&elementName=")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let weatherResponse = try decoder.decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self.weather = weatherResponse
                        self.weatherWx = weatherResponse.records.location[0].weatherElement[0]
                        self.weatherPop = weatherResponse.records.location[0].weatherElement[1]
                        self.weatherMinT = weatherResponse.records.location[0].weatherElement[2]
                        self.weatherCI = weatherResponse.records.location[0].weatherElement[3]
                        self.weatherMaxT = weatherResponse.records.location[0].weatherElement[4]
                    }
                    print(weatherResponse.success)
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}

struct homePage_Previews: PreviewProvider {
    static var previews: some View {
        homePage()
            .environmentObject(ContentViewModel())
    }
}
