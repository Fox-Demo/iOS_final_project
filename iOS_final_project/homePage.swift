//
//  homePage.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/21.
//

import SwiftUI
import Combine


struct homePage: View {
    @State var weather: WeatherData?
    @State var weatherWx: WeatherElement?
    @State var weatherPop: WeatherElement?
    @State var weatherMinT: WeatherElement?
    @State var weatherCI: WeatherElement?
    @State var weatherMaxT: WeatherElement?
    @State private var busRoute = ""
    @State var searchbus = false
    let nearStops = [nearStop.demo,nearStop.demo]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        VStack(){
            Text("公車").padding()
            Button("尋找公車路線"){
                searchbus = true
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding(10)
            .sheet(isPresented: $searchbus) {
                SearchBusView()
            }
            .padding(.top,50)

            if let weather = weather {
                let parameterWx = weatherWx!.time[0].parameter
                let parameterPop = weatherPop!.time[0].parameter
                let parameterMinT = weatherMinT!.time[0].parameter
                let parameterMaxT = weatherMaxT!.time[0].parameter
                let photoWT = String(parameterWx.parameterValue!)
//              Text(photoWT)
                HStack{
                    VStack {
                        Text("32℃").font(.system(size: 30)).bold()
                        Text("\(parameterMinT.parameterName)℃~\(parameterMaxT.parameterName)℃")
                            .fixedSize()
                    }
                    .frame(width: 100, height: 140)
                    .padding()
                    
                    Divider().frame(width: 2, height: 100).overlay(.gray)
                    
                    Image(photoWT)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding(.leading,20)
                    
                    VStack{
                        Text(parameterWx.parameterName)
                            .font(.system(size: 25))
                        Text("降雨率:\(parameterPop.parameterName)%")
                    }
                    .frame(width: 140, height: 140)
                    .padding(.trailing,10)
                }
                .frame(width: 350, height: 140)
             
                List{
                    ForEach (nearStops) { stop in
                        nearStopRow(stop: stop)
                    }
                }
            }else{
                Text("Loading...")
                    .onAppear(perform: self.loadData)
            }
            Divider()
            Spacer()
            //            站牌API

        }
        .frame(width: 360, height: 750)
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
    }
}
