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
    }
}

struct loginPage: View {
    
    @State private var isSuccess = false
    @State private var isFailed = false
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing:15){
                Text("會員登入")
                    .font(.largeTitle)
                    .padding(.top, 40)
                
                Divider()
                    .frame(width: 300, height: 2)
                    .overlay(.black)
                    .padding(.bottom,15)
                
                VStack {
                    Text("Account")
                        .padding(.trailing, 250)
                        .fixedSize()
                    TextField(
                        "Enter your email",
                        text: $email
                    )
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                }
                .frame(width: 320, height: 80)
                
                VStack {
                    Text("Password")
                        .padding(.trailing, 240)
                        .fixedSize()
                    SecureField(
                        "Enter your password",
                        text: $password
                    )
                    .textFieldStyle(.roundedBorder)
                }
                .frame(width: 320, height: 80)
                
                Button{
                    login(email: email, password: password)
                    if let user = Auth.auth().currentUser {
                        print("\(user.uid) login")
                        isSuccess = true
                    } else {
                        print("not login")
                        isFailed = true
                    }
                }label: {
                    Text("登入")
                        .font(.system(size: 25))
                        .frame(width: 250, height: 10)
                        .foregroundColor(.blue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 3)
                        )
                }
                .padding()
                .alert("帳號或密碼錯誤", isPresented: $isFailed, actions:{
                    Button("重試"){
                        isFailed = false
                    }
                })
                .alert("成功", isPresented: $isSuccess, actions:{
                    Button("OK"){
                        isSuccess = false
                        dismiss()
                    }
                })

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
                .frame(width: 320, height: 30)
                .padding()
            
//                HStack(spacing:-5) {
//                    NavigationLink{
//                        forgetPasswordView()
//                    }label: {
//                        Text("忘記密碼？")
//                    }
//                }
//                .frame(width: 320, height: 5)
//                .padding()
                Spacer()
            }
            .frame(width: 350, height: 700)
        }
    }
}

struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}
