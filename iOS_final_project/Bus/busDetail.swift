//
//  busDetail.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct busDetail: View {
    let busStops = [BusStop.demo, BusStop.demo, BusStop.demo, BusStop.demo, BusStop.demo, BusStop.demo, BusStop.demo, BusStop.demo, BusStop.demo, BusStop.demo, BusStop.demo]
    @State var search:String = "";
    @State var startStop:String = "";
    @State var endStop:String = "";
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack{
            TabView{
                GoPage(busId: search, startStop: startStop, endStop: endStop)
                    .tabItem{
                        Label("去程", systemImage: "arrowshape.turn.up.right")
                    }
                ComePage(busId: search, startStop: startStop, endStop: endStop)
                    .tabItem{
                        Label("返程", systemImage: "arrowshape.turn.up.left")
                    }
            }
            Spacer()
        }
    }
}

struct busDetail_Previews: PreviewProvider {
    static var previews: some View {
        busDetail()
    }
}
