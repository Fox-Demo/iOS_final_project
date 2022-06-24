//
//  EditName.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/17.
//

import SwiftUI
import FirebaseAuth
struct EditName: View {
    
    @State var name = ""

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userInfor: UserInfor

    let genders = ["Male", "Female"]
    
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
                    .padding(.trailing, 240)
                    .fixedSize()
                TextField(
                    "Edit your name",
                    text: $name
                )
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            }
            .frame(width: 330, height: 80)
            
            VStack {
                Text("User address")
                    .padding(.trailing, 220)
                    .fixedSize()
                TextField(
                    "Edit your address",
                    text: $userInfor.address
                )
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            }.frame(width: 330, height: 80)
            
            VStack {
                HStack {
                    Text("User birthday")
                        .padding(.leading,5)
                    DatePicker("", selection: $userInfor.birthday, displayedComponents: .date)
                        .padding(.leading)
                }
            }.frame(width: 330, height: 60)
            
            VStack {
                HStack {
                    Text("User gender")
                        .padding(.leading,5)
                    
                    Picker("", selection: $userInfor.selectedGender) {
                        ForEach(0..<genders.count) { index in
                            Text(self.genders[index]).tag(index).font(.title)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .foregroundColor(Color.blue)
                    .padding(.leading,100)
                }
            }
            .frame(width: 330, height: 60)
            
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
            Spacer()
        }
        .frame(width: 350, height: 700)
    }
}

struct EditName_Previews: PreviewProvider {
    static var previews: some View {
        EditName()
            .environmentObject(UserInfor())
    }
}
