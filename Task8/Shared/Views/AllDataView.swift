//
//  AllDataView.swift
//  Task8 (iOS)
//
//  Created by Arun_Skyraan on 13/10/22.
//

import SwiftUI

struct AllDataView: View {
    
    @State var dataModels: [UserModel] = []
    @State var skills: String = ""
    
    var body: some View {
        VStack {
            
            List(self.dataModels.reversed()) { data in
                VStack {
                Text("name: \(data.name)")
                Text("email: \(data.email)")
                Text("DOB : \(data.dob)")
//                    Text(data.skill)
                }
            }
            
            }
        .onAppear {
            self.dataModels = DB_Manager().getUsers()
//            self.dataModels = DB_Manager1().getUsers()
//            skills = d
        }
        
        }
       
}

struct AllDataView_Previews: PreviewProvider {
    static var previews: some View {
        AllDataView()
    }
}
