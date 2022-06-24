//
//  ContentView.swift
//  iOS_final_project
//
//  Created by li on 2022/6/12.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var userInfor = UserInfor()
    var body: some View {
        TabView{
            homePage()
                .tabItem{
                    Label("home page", systemImage: "house")
                }
            MapPage()
                .tabItem{
                    Label("google map", systemImage: "map")
                }
            memberPage()
                .tabItem{
                    Label("setting", systemImage: "gearshape")
                }
        }.environmentObject(userInfor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
