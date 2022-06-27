//
//  AboutView.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct AboutView: View {
    
    @State var login = false
    @State var introduce = false
    @State var development = false
    @State var fIntorduce = false
    @State var available = false
    @State var future = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Text("關於App")
                .font(.system(.title))
                .bold()
                .padding(.top,70)
            
            List{
                Button("產品介紹"){
                    introduce = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(10)
                .sheet(isPresented: $introduce) {
                    IntroduceView()
                }
                
                Button("開發團隊"){
                    development = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(10)
                .sheet(isPresented: $development) {
                    developmentTeamView()
                }
                
                Button("App 功能"){
                    fIntorduce = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(10)
                .sheet(isPresented: $fIntorduce) {
                    functionIntroduceView()
                }
                
                Button("可用的型號"){
                    available = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(10)
                .sheet(isPresented: $available) {
                    availableModelsView()
                }
                
                Button("未來計畫"){
                    future = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(10)
                .sheet(isPresented: $future) {
                    futureFunctionView()
                }
            }
            .frame(width: 350, height: 350)
            Spacer()
        }
        .frame(width: 400, height: 750)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
