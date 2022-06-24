//
//  logoutPage.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/24.
//

import SwiftUI

struct logoutPage: View {
    
    @State var login = false
    @State var signup = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack{
            Text("成為會員")
                .font(.title)
            HStack{
                Button("會員登入"){
                    login = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(10)
                .sheet(isPresented: $login) {
                    loginPage()
                }
                
                Button("會員註冊"){
                    signup = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(10)
                .sheet(isPresented: $signup) {
                    signupPage()
                }
            }
        }
    }
}

struct logoutPage_Previews: PreviewProvider {
    static var previews: some View {
        logoutPage()
    }
}
