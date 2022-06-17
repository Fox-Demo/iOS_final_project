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

func setName(name: String){
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.displayName = name
    changeRequest?.commitChanges(completion: { error in
        guard error == nil else {
           print(error?.localizedDescription)
           return
        }
        print("Set Success")
    })
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
        VStack{

            Text("會員註冊")
                .font(.largeTitle)
            
            TextField(
                "name",
                text: $name
            )
                .padding()
                .textFieldStyle(.roundedBorder)
            
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
            
            SecureField(
                "Re-enter password",
                text: $Password
            )
                .padding()
                .textFieldStyle(.roundedBorder)
            
            Button{
                if (Password == password){
                    
                    signup(email: email, password: password)
                    setName(name: name)
                    
                    isSuccess = true
                }else{
                    isFailed = true
                }
            }label: {
                Text("註冊")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(
                         RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 5)
                    )
            }
        
            NavigationLink{
                loginPage()
            }label: {
                Text("已是會員？ 請登入")
                    .font(.title2)
            }
            
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
    
        }
        
    }
}

struct signupPage_Previews: PreviewProvider {
    static var previews: some View {
        signupPage()
    }
}
