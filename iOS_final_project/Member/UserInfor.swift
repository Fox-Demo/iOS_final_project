//
//  UserInfor.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/22.
//

import Foundation

class UserInfor: ObservableObject {
    @Published var birthday = Date()
    @Published var selectedGender = 0
    @Published var address = ""
}
