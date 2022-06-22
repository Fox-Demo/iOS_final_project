//
//  EditName.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/17.
//

import SwiftUI
import FirebaseAuth
struct EditName: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var userInfor: UserInfor

    let genders = ["Male", "Female"]
    
    @State var name = ""
    var body: some View {
        VStack{
            Text("編輯使用者資料")
                .font(.largeTitle)
                .padding(.top, 80)
            Divider()
                .frame(width: 300, height: 2)
                .overlay(.black)
                .padding(.bottom,30)
            
            VStack {
                Text("User name")
                    .padding(.trailing, 280)
                TextField(
                    "Edit your name",
                    text: $name
                )
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 50)
            }.frame(width: 370, height: 70)
            
            VStack {
                Text("User address")
                    .padding(.trailing, 270)
                    .fixedSize()
                TextField(
                    "Edit your address",
                    text: $userInfor.address
                )
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 50)
            }.frame(width: 370, height: 70)
            
            VStack {
                Text("User birthday")
                
                    .padding(.trailing, 265)
                    .fixedSize()
                DatePicker("", selection: $userInfor.birthday, displayedComponents: .date)
                    .padding(.trailing,50)
                
            }.frame(width: 370, height: 70)
            
            VStack {
                Text("User gender")
                    .padding(.trailing, 275)
                    .fixedSize()
                //                TextField(
                //                    "Enter your email",
                //                    text: $name
                //                )
                //                .textFieldStyle(.roundedBorder)
                //                .padding(.bottom, 50)
                
                Picker("", selection: $userInfor.selectedGender) {
                    
                    ForEach(0..<genders.count) { index in
                        Text(self.genders[index]).tag(index).font(.title)
                    }
                }
                .padding()
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(Color.blue)
                
            }.frame(width: 370, height: 70)
            
            Divider()
                .frame(width: 300, height: 2)
                .overlay(.black)
                .padding(.bottom,30)
            
            Button(action: {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: { error in
                    guard error == nil else{
                        print(error?.localizedDescription)
                        dismiss()
                        return
                    }
                })
                dismiss()
            }) {
                Text("Submit")
                    .font(.system(size: 25))
                    .frame(width: 250, height: 10)
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 3)
                    )
            }
        }.frame(width: 400, height: 200)
    }
    
}

struct EditName_Previews: PreviewProvider {
    static var previews: some View {
        EditName()
            .environmentObject(UserInfor())
    }
}
