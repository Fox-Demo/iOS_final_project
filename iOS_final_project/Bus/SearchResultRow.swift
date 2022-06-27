////
////  SearchResultRow.swift
////  iOS_final_project
////
////  Created by 林峻霆 on 2022/6/24.
////
//
//import SwiftUI
//struct BusStop:Identifiable {
//    var id:String{busId}
//    var busId:String
//    var startStop:String
//    var endStop:String
//    var city:String
//}
//extension BusStop{
//    static let demo = BusStop(busId: "307", startStop: "板橋", endStop: "撫遠街", city: "台北")
//}
//
//struct SearchResultRow: View {
//    @State var stop:BusStop;
//    @State var detail = false
////    @Binding var tempId = stop.busId
////    @StateObject var tempBus: BusStop
////    @State private var tempID = stop.busId
//    var body: some View {
//        HStack{
//            VStack(alignment: .leading){
//                Text(stop.busId)
//                Text("\(stop.startStop) - \(stop.endStop)")
//            }
//            Spacer()
//            VStack(spacing:10){
//                Button {
//                    detail = true
//                } label: {
//                    Image(systemName: "star")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                }
//                .sheet(isPresented: $detail) {
//                    busDetail()
//                }
//                Text(stop.city)
//            }
//        }.padding()
//    }
//}
