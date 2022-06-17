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
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack{
            Text("會員登入")
                .font(.largeTitle)
            
            TextField(
                "email",
                text: $email
            )
                .padding()
                .textFieldStyle(.roundedBorder)
            
            SecureField(
                "password",
                text: $password
            )
                .padding()
                .textFieldStyle(.roundedBorder)
            
            Button{
                login(email: email, password: password)
                
            }label: {
                Text("登入")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(
                         RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 5)
                    )
            }
            
            NavigationLink{
                signupPage()
            }label: {
                Text("是否註冊會員")
                    .font(.title2)
            }                
        }
    }
}

struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}
