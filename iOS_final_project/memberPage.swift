//
//  memberPage.swift
//  iOS_final_project
//
//  Created by li on 2022/6/12.
//

import SwiftUI
import FirebaseAuth

struct memberPage: View {
    @State var name: String? = ""
    @State var isLogin: Bool = false
    @State var loginState:String = "未登入"
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text(loginState)
                    .font(.largeTitle)
                
                Text("名字：\(name!)")
                    .onAppear {
                        if let user = Auth.auth().currentUser {
                            if let Name = user.displayName{
                                self.name = Name
                                loginState = "已登入"
                            }else{
                                self.name = ""
                                loginState = "未登入"
                            }
                            //self.email = user.email
                        }
                        
                     }
                
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
