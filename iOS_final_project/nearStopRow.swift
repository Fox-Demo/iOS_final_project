//
//  nearStopRow.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct nearStop:Identifiable {
    var id:String{busId}
    var busId:String
    var name :String
    var distance :Double
}
extension nearStop{
    static let demo = nearStop(busId: "307", name: "板橋車站", distance: 200)
}

struct nearStopRow: View {
    @State var stop:nearStop;
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                
                Text(stop.name).font(.system(size: 25))
            }
            Spacer()
            VStack(spacing:10){
        
                Text("\(String(format: "%.2f", stop.distance)) m")
                    .padding()
                    .overlay(Capsule(style: .continuous)
                             //.stroke(Color.blue,style: StrokeStyle(lineWidth:4,dash: [10]))
                        .stroke(Color.blue,lineWidth: 5)
                    )
                
            }
        }.padding()
    }
}

struct nearStopRow_Previews: PreviewProvider {
    static var previews: some View {
        nearStopRow(stop: nearStop.demo).previewLayout(.sizeThatFits)
    }
}
