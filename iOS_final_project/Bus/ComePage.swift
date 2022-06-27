//
//  ComePage.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct ComePage: View {
    var tdxApi = tdxAPI()
    let direction = 1
    var busId: String
    var startStop: String
    var endStop: String
    @State var detailStops:[detailStop] = []
    @State private var timer: Timer?
    var body: some View {
        VStack{
            HStack{
                Text("\(busId) - 往\(startStop)").font(.title)
            }.padding()
            List{
                ForEach (detailStops, id:\.id) { stop in
                    busDetailRow(stop: stop)
                }
            }
            .listStyle(.plain)

        }.onAppear{
            if detailStops.count == 0 {
                let routeStops = tdxApi.getBusStopsByRoute(city: "Taipei", route: busId, direction: direction)
                for stop in routeStops!.stops {
                    detailStops.append(detailStop(busId: busId, stopName: stop?.stopName?.zhTw ?? "", i_time: -1, updated: false))
                }
            }

            self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (_) in
                tdxApi.getBusEstimatedTimeOfArrivalByRoute(city: "Taipei", routeName: busId) { stops in
                    for i in 0...detailStops.count-1 {
                        detailStops[i].updated = false
                    }
                    for stop in stops {
                        if stop.direction != direction {
                            continue
                        }
                        let stopName = stop.stopName?.zhTw
                        var estimateTime = -1
                        if let time = stop.estimateTime {
                            estimateTime = time / 60
                        }
                        let stopIndex = detailStops.firstIndex { $0.stopName == stopName }
                        if let index = stopIndex {
                            debugPrint(stopIndex! ,stopName as Any ,estimateTime)
                            debugPrint(detailStops[index])
                            if detailStops[index].updated {
                                if detailStops[index].i_time == -1 {
                                    detailStops[index].i_time = estimateTime
                                    detailStops[index].id = UUID()
                                }else{
                                    detailStops[index].i_time = min(detailStops[index].i_time, estimateTime)
                                    detailStops[index].id = UUID()
                                }
                                
                            }else{
                                detailStops[index].updated = true
                                detailStops[index].id = UUID()
                                detailStops[index].i_time = estimateTime
                            }
                        }
                    }
                }
            }
        }.onDisappear {
            self.timer?.invalidate()
        }
    }
}

struct ComePage_Previews: PreviewProvider {
    static var previews: some View {
        ComePage(busId: "307", startStop: "撫遠街", endStop: "板橋")
    }
}
