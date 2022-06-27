//
//  busDetailRow.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI
struct detailStop:Identifiable {
    var id = UUID()
    var busId:String
    var stopName:String
    var s_time:String {
        get{
            if i_time == -1 {
                return "未發車"
            }
            return i_time == 0 ? "進站中" : "\(i_time) 分"
        }
    }
    var i_time:Int
    var updated:Bool
}
extension detailStop{
    static let demo = detailStop(busId: "298", stopName: "板橋車站", i_time: 2, updated: false)
}

struct busDetailRow: View {
    @State var stop:detailStop;
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(stop.stopName).font(.system(size: 18))
            }
            Spacer()
            VStack(spacing:10){
                Text(stop.s_time)
                    .font(.system(size: 18))
                    .frame(width: 60, height: 10)
                    .padding()
                    .overlay(Capsule(style: .continuous)
                        .stroke(Color.blue,lineWidth: 2)
                    )
            }
        }.padding()
    }
}

struct busDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        busDetailRow(stop: detailStop.demo)
            .previewLayout(.sizeThatFits)
    }
}

