//
//  signupPage.swift
//  iOS_final_project
//
//  Created by li on 2022/6/13.
//

import SwiftUI
import FirebaseAuth

func signup(email: String, password: String){
    let create = Auth.auth().createUser(withEmail: email, password: password) { result, error in
        guard let user = result?.user,
              error == nil else {
            print(error?.localizedDescription)
            return
        }
        print(user.email, user.uid)
    }
}


struct signupPage: View {
    @State private var isSuccess = false
    @State private var isFailed = false
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var Password: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing:15) {
                Text("會員註冊")
                    .font(.largeTitle)
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
                    .padding(.bottom, 50)
                }.frame(width: 320, height: 70)
            
                VStack {
                    Text("Password")
                        .padding(.trailing, 240)
                        .fixedSize()
                    SecureField(
                        "Enter your password",
                        text: $password
                    )
                    .textFieldStyle(.roundedBorder)
                    Text("*Must be at least 6 words")
                        .fixedSize()
                        .font(.system(size:13))
                        .foregroundColor(.red)
                        .padding(EdgeInsets(top:0, leading: 0, bottom: 50, trailing: 150))
                }.frame(width: 320, height: 100)
                
                VStack {
                    Text("Confirm Password")
                        .padding(.trailing, 175)
                        .fixedSize()
                    SecureField(
                        "Confirm your password",
                        text: $Password
                    )
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 50)
                }.frame(width: 320, height: 70)
                
                Button{
                    if (Password == password){
                        signup(email: email, password: password)
                        isSuccess = true
                    }else{
                        isFailed = true
                    }
                }label: {
                    Text("註冊")
                        .font(.system(size: 25))
                        .frame(width: 250, height: 10)
                        .foregroundColor(.blue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 3)
                            )
                }
                Divider()
                    .frame(width: 300, height: 2)
                    .overlay(.black)
                    .padding()
                
                HStack(spacing:-5) {
                    Text("已經成為會員？")
                    NavigationLink{
                        loginPage()
                    }label: {
                        Text("登入")
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .edgesIgnoringSafeArea(.all)
                }
                .frame(width: 320, height: 50)
                .padding()
                        
                .alert("成功註冊", isPresented: $isSuccess, actions:{
                    Button("OK"){
                        isSuccess = false
                        dismiss()
                    }
                })
            
                .alert("密碼不一樣", isPresented: $isFailed, actions:{
                    Button("重試"){
                        isFailed = false
                    }
                })
                Spacer()
            }.frame(width: 350, height: 700)
        }
    }
}

struct signupPage_Previews: PreviewProvider {
    static var previews: some View {
        signupPage()
    }
}
