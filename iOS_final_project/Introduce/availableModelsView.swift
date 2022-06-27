//
//  availableModelsView.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct availableModelsView: View {
    @State private var phones = [
        iPhone(name: "iPhone 13 pro ",  size: "6.1"),
        iPhone(name: "iPhone 13 pro Max",  size: "6.7"),
        iPhone(name: "iPhone 12 pro ",  size: "6.1"),
        iPhone(name: "iPhone 12 pro Max",  size: "6.7"),
        iPhone(name: "iPhone 11 pro Max",  size: "6.5"),
        iPhone(name: "iPhone Xs Max",  size: "6.5"),
    ]
    var body: some View {
        VStack{
            Text("畫面可符合的型號")
                .padding()
            List{
                ForEach(phones.indices,id:\.self){index in
                    HStack{
                        Text("\(phones[index].size) 吋")
                            .padding()
                            .frame(width: 90, height: 30)
                        
                        Text(phones[index].name)
                            .padding()
                    }
                }
            }
            
            Text(" 需 ios 15.5 以上\n 畫面大小為 6.1 吋 最佳 \n 上述為 6.1 吋已以上的機型")
                .multilineTextAlignment(.center)
                .foregroundColor(Color.red)
            
        }
        
    }
}

struct availableModelsView_Previews: PreviewProvider {
    static var previews: some View {
        availableModelsView()
    }
}
