//
//  futureFunctionView.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/27.
//

import SwiftUI
struct futureF{
    let name :String
    let index:String
}


struct futureFunctionView: View {
    @State private var futureFs = [
        futureF(name: "到站通知", index: "➢"),
        futureF(name: "最愛站牌", index: "➢"),
        futureF(name: "結合捷運", index: "➢"),
        futureF(name: "結合ubike", index: "➢"),
        futureF(name: "結合火車", index: "➢"),
        futureF(name: "結合高鐵", index: "➢"),
        futureF(name: "訂票系統", index: "➢"),
        futureF(name: "支付系統", index: "➢"),
        futureF(name: "增加導航功能", index: "➢")
    ]
    var body: some View {
        VStack{
            Text("未來打算增加的功能")
                .padding()
            List{
                ForEach(futureFs.indices,id:\.self){index in
                    HStack{
                        Text("\(futureFs[index].index)")
                            .padding()
                            .frame(width: 90, height: 30)
                        
                        Text(futureFs[index].name)
                            .padding()
                    }
                }
            }
        }
        
    }
}

struct futureFunctionView_Previews: PreviewProvider {
    static var previews: some View {
        futureFunctionView()
    }
}
