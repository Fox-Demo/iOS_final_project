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
                .padding()
            Text("免責聲明（下載本程式即表示同意）：\n對於本程式所轉載或描述之資料的準確\n性、可用性、完整性或效\n用，概不做出明確或暗示的保證、聲明或陳述，在法\n律許可的範圍內，對於提供或使用這些資料而可能直\n接或間接導致的損失、損壞或傷害，亦不負任何法律\n承擔或責任（包含疏忽責任）\n資料來源：\n1. 交通部PTX 平臺\n2. 全台各縣市開放資料平臺\n3. 天氣資訊：中央氣象局開放資料平臺\n4. 停車場資訊：由「停車大聲公」合作提供\n5. 捷運路線圖：臺北大眾捷運股份有限公司、桃園大\n眾捷運股份有限公司、高雄捷運股份有限公司\n6. data.taipei平台")
                
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 300, height: 500)
        }
    }
}

struct IntroduceView_Previews: PreviewProvider {
    static var previews: some View {
        IntroduceView()
    }
}
