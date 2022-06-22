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
    @State var login = false
    @State var signup = false
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userInfor: UserInfor
    
    let genders = ["Male", "Female"]
    
    var body: some View {
        VStack{
            let date = userInfor.birthday
            if let user = Auth.auth().currentUser {
                Image("pic")
                    .resizable()
                    .frame(width: 200, height:200)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(20)
                
                Text(user.displayName ?? "Unknow")
                    .font(.system(size: 28))
                    .bold()
                List{
                    HStack{
//                        Image(systemName: "envelope")
//                            .padding(-8.0)
                        Text("Email:")
                            .padding(-6.0)
                        Text("\(user.email ?? "error")")
                            .padding(.leading,35)
                        
                    }
                    HStack{
                        
                        Text("Birthday:")
                            .padding(-6.0)
                        Text("\(userInfor.birthday,style: .date)")
                            .padding(.leading,10)
                    }


                    HStack{
                        Text("Gender:")
                            .padding(-6.0)
                        Text(self.genders[userInfor.selectedGender]).tag(userInfor.selectedGender)
                            .padding(.leading,20)
                            .fixedSize()
                    
                            
                    }
                    
                    HStack{
                        Text("Address:")
                            .padding(-6.0)
                        Text("\(userInfor.address)")
                            .padding(.leading,20)
                            .fixedSize()
                    
                            
                    }
                    
                    
                }.listStyle(.inset)
                    .frame(width: 400, height: 400)
                
                HStack(spacing: 0){
                    Button("登出"){
                        do{
                            try Auth.auth().signOut()
                        }
                        catch{}
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    Button("編輯"){
                        edit = true
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sheet(isPresented: $edit) {
                        EditName()
                    }
                }.frame(minWidth: 0, maxWidth: .infinity)
            }
            else{
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
        .frame(width: 400, height: 850)
        .padding()
        
        
        
    }
}

struct memberPage_Previews: PreviewProvider {
    static var previews: some View {
        memberPage()
            .environmentObject(UserInfor())
    }
}
