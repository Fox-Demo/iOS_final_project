//
//  ContentView.swift
//  iOS_final_project
//
//  Created by li on 2022/6/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Text("首頁")
                .tabItem{
                    Label("home page", systemImage: "house")
                }
            Text("定位")
                .tabItem{
                    Label("google map", systemImage: "map")
                }
            memberPage()
                .tabItem{
                    Label("setting", systemImage: "gearshape")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
