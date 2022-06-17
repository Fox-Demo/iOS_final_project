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
    @State var name = ""
    var body: some View {
        VStack{
            TextField("name", text:$name)
                .padding()
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
                    .font(.system(size: 20, weight: .bold, design: .default))
//                    .foregroundColor(.purple)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 1)
                    )
            }
            
            
        }
    }
    
}

struct EditName_Previews: PreviewProvider {
    static var previews: some View {
        EditName()
    }
}
