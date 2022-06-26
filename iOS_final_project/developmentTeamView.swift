//
//  developmentTeamView.swift
//  iOS_final_project
//
//  Created by 林峻霆 on 2022/6/26.
//

import SwiftUI

struct developmentTeamView: View {
    @State private var teams = [
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
                            .frame(width: 300, height: 50)
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
