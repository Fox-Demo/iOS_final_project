//
//  homePage.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/21.
//

import SwiftUI

struct homePage: View {
    @State var weather: WeatherData?
    @State var weatherWx: WeatherElement?
    @State var weatherPop: WeatherElement?
    @State var weatherMinT: WeatherElement?
    @State var weatherCI: WeatherElement?
    @State var weatherMaxT: WeatherElement?
    @State private var busRoute = ""
    
    var body: some View{
        VStack(spacing:5){
            TextField("尋找公車路線", text: $busRoute, prompt: Text("尋找公車路線"))
                .textFieldStyle(.roundedBorder)
            // .leftView(Image(systemName: "magnifyingglass"))
                .padding(.top,50)
            
            if let weather = weather {
                let parameterWx = weatherWx!.time[0].parameter
                let parameterPop = weatherPop!.time[0].parameter
                let parameterMinT = weatherMinT!.time[0].parameter
                //                let parameterCI = weatherCI!.time[0].parameter
                let parameterMaxT = weatherMaxT!.time[0].parameter
                let photoWT = String(parameterWx.parameterValue!)
                HStack{
                    VStack {
                        
                        Text("32℃").font(.system(size: 30)).bold()
                        Text("\(parameterMinT.parameterName)℃~\(parameterMaxT.parameterName)℃")                        
                        
                    }
                    .frame(width: 100, height: 150)
                    
                    .padding()
                    //Spacer()
//                    .frame(width: 100, height: 200)`
                    //                    .padding(.leading,50)
                    Divider().frame(width: 2, height: 100).overlay(.black)
//                    Image(systemName: "sun.max")
                    Image(photoWT)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                    
                    VStack{
                        Text(parameterWx.parameterName)
                            .padding()
                            .font(.system(size: 28.0))
                        Text("降雨:\(parameterPop.parameterName)%")
                        //                Text(parameterCI.parameterName)
                    }
                    .frame(width: 150, height: 150)
                    .padding()
                }
            }else{
                Text("Loading...")
                    .onAppear(perform: self.loadData)
            }
            
            Divider()
            Spacer()
//            站牌API
            Image("附近站牌")
        }
        .frame(width: 400, height: 850)
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
