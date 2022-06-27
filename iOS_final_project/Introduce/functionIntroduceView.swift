//
//  functionIntroduceView.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct functionIntroduceView: View {
    @State private var functions = [
       "公車查詢","顯示附近站牌","會員登入","會員註冊","使用者資料編輯","App介紹"
    ]
    var body: some View {
        VStack{
            Text("Support Function")
                .padding()
            List{
                ForEach(functions.indices,id:\.self){index in
                    HStack{
                        Text("\(functions[index].self) ")
                            .frame(width: 300, height: 50)
                    }
                }
            }
        }
    }
}

struct functionIntroduceView_Previews: PreviewProvider {
    static var previews: some View {
        functionIntroduceView()
    }
}
