//
//  ContentView.swift
//  finalProject
//
//  Created by 林聖祐 on 2022/6/24.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct SearchBusView: View {
    let tdxApi = tdxAPI()
    var taipeiRoutes:[BusRoute] = []
    @State var busStops:[BusStop] = []
    @State var search:String = "";
    @FocusState private var isFocused: Bool
    init(){
        taipeiRoutes = tdxApi.getBusRouteByCity(city: "Taipei")
    }
    func searchChanged(to value:String){
        busStops = []
        if search != "" {
            for route in taipeiRoutes {
                if let routeName = route.routeName {
                    if routeName.zhTw.contains(search){
                        busStops.append(BusStop(busId: routeName.zhTw , startStop: route.departureStopNameZh!, endStop: route.destinationStopNameZh!, city: "台北"))
                    }
                }
            }
        }
    }
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "bus")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .shadow(radius: 10)
                Text("要去哪呢？")
                    .font(.system(size:30))
                    .bold()
                    .padding()
            }
            .frame(width: 350, height: 100)
            .padding(.trailing, 70)

            
            HStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 10)
                    TextField("公車路線搜尋", text: $search.onChange(searchChanged))
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                     if search != "" {
                        Button {
                            search = ""
                        } label: {
                            Image(systemName: "xmark.circle")
                        }
                    }
                }.frame(width: 350, height: 50)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Color(red: 0.905, green: 0.91, blue: 0.906)))
                    .padding(.top, 40)
                if isFocused {
                    Button("取消"){
                        isFocused = false
                    }.buttonStyle(.borderless)
                        .scaledToFit()
                }
            }
            List{
                ForEach (busStops) { stop in
                    SearchResultRowView(stop: stop)
                }
            }
            .listStyle(.plain)
            Spacer()
        }
        .frame(width: 350, height: 700)
        .onTapGesture {
            isFocused = false
        }
    }
}

struct SearchBusView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBusView()
    }
}
