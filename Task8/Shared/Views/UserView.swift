//
//  UserView.swift
//  Task8 (iOS)
//
//  Created by Arun_Skyraan on 13/10/22.
//

import SwiftUI

struct UserView: View {
    
    @State var aadhaarNo : String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var DOB: Date = Date()
    
    @State var dataModels: [UserModel] = []
    
    var body: some View {
        VStack {
            TextField("aadhaar", text: $aadhaarNo)
                .padding()
            TextField("name", text: $name)
                .padding()
            TextField("phone", text: $phone)
                .padding()
            TextField("email", text: $email)
                .padding()
            DatePicker(selection: $DOB, label: { Text("Date") })
                .padding()
            Button(action: {
                
                DB_Manager().getUserData(idValue: 0, aadhaarValue: self.aadhaarNo, nameValue: self.name, emailValue: self.email, phoneValue: self.phone, dobValue: self.DOB)
                let dbManager: DB_Manager = DB_Manager()
                self.dataModels = dbManager.getUsers()


            }, label: {
                Text("Next")
            })
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            
            NavigationLink(destination: {
                AllDataView()
            }, label: {
                Text("show")
            })
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            Spacer()
        }
        .navigationTitle("UserView")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
