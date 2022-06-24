//
//  homePage.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/21.
//

import SwiftUI
import Combine

final class KeyboardGuardian: ObservableObject {

    let objectWillChange = PassthroughSubject<Void, Never>()

    public var rects: Array<CGRect>
    public var keyboardRect: CGRect = CGRect()

    // keyboardWillShow notification may be posted repeatedly,
    // this flag makes sure we only act once per keyboard appearance
    public var keyboardIsHidden = true

    public var slide: CGFloat = 0 {
        didSet {
            objectWillChange.send()
        }
    }

    public var showField: Int = 0 {
        didSet {
            updateSlide()
        }
    }

    init(textFieldCount: Int) {
        self.rects = Array<CGRect>(repeating: CGRect(), count: textFieldCount)

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if keyboardIsHidden {
            keyboardIsHidden = false
            if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                keyboardRect = rect
                updateSlide()
            }
        }
    }

    @objc func keyBoardDidHide(notification: Notification) {
        keyboardIsHidden = true
        updateSlide()
    }

    func updateSlide() {
        if keyboardIsHidden {
            slide = 0
        } else {
            let tfRect = self.rects[self.showField]
            let diff = keyboardRect.minY - tfRect.maxY
            print("tfRect", tfRect, "\nself.showField", self.showField)
            if diff > 0 {
                slide += diff
            } else {
                slide += min(diff, 0)
            }
        }
    }
}

struct homePage: View {
    @State var weather: WeatherData?
    @State var weatherWx: WeatherElement?
    @State var weatherPop: WeatherElement?
    @State var weatherMinT: WeatherElement?
    @State var weatherCI: WeatherElement?
    @State var weatherMaxT: WeatherElement?
    @State private var busRoute = ""
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    var body: some View{
        VStack(){
            TextField("尋找公車路線", text: $busRoute, prompt: Text("尋找公車路線"))
                .textFieldStyle(.roundedBorder)
                .padding(.top,50)
                
            
            if let weather = weather {
                let parameterWx = weatherWx!.time[0].parameter
                let parameterPop = weatherPop!.time[0].parameter
                let parameterMinT = weatherMinT!.time[0].parameter
                let parameterMaxT = weatherMaxT!.time[0].parameter
                let photoWT = String(parameterWx.parameterValue!)
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
                
            }else{
                Text("Loading...")
                    .onAppear(perform: self.loadData)
            }
            Divider()
            Spacer()
            //            站牌API

        }
        .frame(width: 360, height: 750)
        .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
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
