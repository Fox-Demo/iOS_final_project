//
//  memberPage.swift
//  iOS_final_project
//
//  Created by li on 2022/6/12.
//

import SwiftUI

struct memberPage: View {
    var body: some View {
        
        NavigationView{
            VStack{
//                Text("成為會員")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
                
                NavigationLink{
                    loginPage()
                }label: {
                    Text("會員登入")
                        .padding()
                }
                
                NavigationLink{
                    signupPage()
                }label: {
                    Text("會員註冊")
                        .padding()
                }
            }
            
            .padding()
            .navigationTitle("會員頁面")
        }
        
    }
}

struct memberPage_Previews: PreviewProvider {
    static var previews: some View {
        memberPage()
    }
}
