//
//  ContentView.swift
//  iOS_final_project
//
//  Created by li on 2022/6/12.
//

import SwiftUI



struct homePage: View{
    @State var weather: WeatherData?
    @State var weatherWx: WeatherElement?
    @State var weatherPop: WeatherElement?
    @State var weatherMinT: WeatherElement?
    @State var weatherCI: WeatherElement?
    @State var weatherMaxT: WeatherElement?

    var body: some View{
        if let weather = weather {
            VStack{
                let parameterWx = weatherWx!.time[0].parameter
                let parameterPop = weatherPop!.time[0].parameter
                let parameterMinT = weatherMinT!.time[0].parameter
                let parameterCI = weatherCI!.time[0].parameter
                let parameterMaxT = weatherMaxT!.time[0].parameter
                
                Image(parameterWx.parameterValue!)
                Text(parameterWx.parameterName)
                Text(parameterPop.parameterName)
                Text(parameterCI.parameterName)
                Text("氣溫：\(parameterMinT.parameterName) - \(parameterMaxT.parameterName)")
            }
        }
        
        
        Text("Loading...")
            .onAppear(perform: self.loadData)
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

struct ContentView: View {
    var body: some View {
        TabView{
            homePage()
                .tabItem{
                    Label("home page", systemImage: "house")
                }
            Text("定位")
                .tabItem{
                    Label("google map", systemImage: "map")
                }
            memberPage()
                .tabItem{
                    Label("setting", systemImage: "gearshape")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
