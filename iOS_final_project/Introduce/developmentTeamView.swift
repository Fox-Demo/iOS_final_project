//
//  developmentTeamView.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct developmentTeamView: View {
    @State private var teams = [
       "陸永強 ✉ : luyongqiang1827@gmail.com",
       "林聖祐 ✉ : shiow620412@gmail.com",
       "李永祺 ✉ : a2369028@gmail.com",
       "林峻霆 ✉ : timlin891207@gmail.com"
    ]
    var body: some View {
        VStack{
            Text("Team member")
                .padding()
            List{
                ForEach(teams.indices,id:\.self){index in
                    HStack{
                        Text("\(teams[index].self) ")
                            .font(.system(size: 16))
                            .frame(width: 320, height: 50)
                    }
                }
            }
        }
        
    }
}

struct developmentTeamView_Previews: PreviewProvider {
    static var previews: some View {
        developmentTeamView()
    }
}
