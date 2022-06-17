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
//    @State var loginState:String = "未登入"
    @State var edit = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView{
            VStack{
                if let user = Auth.auth().currentUser {
                    Text("名字：\(user.displayName ?? "error")")
                    
                    Text("email: \(user.email ?? "error")").padding(10)
                        .padding(10)
                    HStack{
                        Button("登出"){
                            do{
                                try Auth.auth().signOut()
                            }
                            catch{
                                
                            }
                        }.padding(10)
                        
                        
                        
                        Button("編輯使用者名字"){
                            edit = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .padding(10)
                        .sheet(isPresented: $edit) {
                            EditName()
                        }
                    }
                    
                }
                else{
                    HStack{
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
