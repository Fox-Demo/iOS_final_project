//
//  IntroduceView.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct IntroduceView: View {
    var body: some View {
        VStack{
            Text("App Introduce").font(.system(.title))
                .padding(.top, 50)
            Text("免責聲明（下載本程式即表示同意）：\n對於本程式所轉載或描述之資料的準確性、可用性、完整性或效用，概不做出明確或暗示的保證、聲明或陳述，在法律許可的範圍內，對於提供或使用這些資料而可能直接或間接導致的損失、損壞或傷害，亦不負任何法律承擔或責任（包含疏忽責任）\n\n資料來源：\n1. 交通部tdx平臺\n2. 全台各縣市開放資料平臺\n3. 天氣資訊：中央氣象局開放資料平臺\n")
                
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 320, height: 400)
                .padding(.top, 50)
            Spacer()
        }
    }
}

struct IntroduceView_Previews: PreviewProvider {
    static var previews: some View {
        IntroduceView()
    }
}
