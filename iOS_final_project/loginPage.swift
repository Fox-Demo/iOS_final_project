//
//  loginPage.swift
//  iOS_final_project
//
//  Created by li on 2022/6/12.
//

import SwiftUI
import FirebaseAuth

func login(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
        guard error == nil else {
            print(error?.localizedDescription)
            return
        }
        print("Login Success")
        memberPage()
    }
}

struct loginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing:15){
                Text("會員登入")
                    .font(.largeTitle)
                    .padding(.top, 80)
                Divider()
                    .frame(width: 300, height: 2)
                    .overlay(.black)
                    .padding(.bottom,30)
                
                VStack {
                    Text("Account")
                        .padding(.trailing, 300)
                    TextField(
                        "Enter your email",
                        text: $email
                    )
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 50)
                }.frame(width: 370, height: 100)
                
                VStack {
                    Text("Password")
                        .padding(.trailing, 290)
                    SecureField(
                        "Enter your password",
                        text: $password
                    )
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 50)
                }.frame(width: 370, height: 80)
                
                
                Button{
                    login(email: email, password: password)
                    
                }label: {
                    Text("登入")
                        .font(.system(size: 25))
                        .frame(width: 330, height: 10)
                        .foregroundColor(.blue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 3)
                        )
                }.padding()
                
                Divider()
                    .frame(width: 300, height: 2)
                    .overlay(.black)
                    .padding()
                
                HStack(spacing:-5) {
                    Text("還沒有帳號？")
                    NavigationLink{
                        signupPage()
                    }label: {
                        Text("註冊")
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .edgesIgnoringSafeArea(.all)
                }
                .frame(width: 370, height: 50)
                .padding(.trailing,230)
                
                
                
                HStack(spacing:-5) {
                    NavigationLink{
//                        forgetPage()
                    }label: {
                        Text("忘記密碼？")
                    }
                }
                .frame(width: 370, height: 50)
                .padding(.trailing,280)
                
                Spacer()
            }
            .frame(width: 400, height: 850)
        }
    }
}

struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}
