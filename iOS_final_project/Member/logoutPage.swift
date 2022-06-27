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
                .font(.system(.title))
                .bold()
                .padding(.top,50)
            VStack{
                Button("會員登入"){
                    login = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .font(.system(size: 20))
                .frame(width: 150, height: 10)
                .foregroundColor(Color(red: 201/255, green: 203/255, blue: 255/255))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 201/255, green: 203/255, blue: 255/255), lineWidth: 3)
                    )
                .padding(10)
                .sheet(isPresented: $login) {
                    loginPage()
                }
                
                Button("會員註冊"){
                    signup = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .font(.system(size: 20))
                .frame(width: 150, height: 10)
                .foregroundColor(Color(red: 201/255, green: 203/255, blue: 255/255))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 201/255, green: 203/255, blue: 255/255), lineWidth: 3)
                    )
                .padding(10)
                .sheet(isPresented: $signup) {
                    signupPage()
                }
                Spacer()
            }
        }
    }
}

struct logoutPage_Previews: PreviewProvider {
    static var previews: some View {
        logoutPage()
    }
}
