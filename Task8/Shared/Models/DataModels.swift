//
//  UserModel.swift
//  SQLTask (iOS)
//
//  Created by Arun_Skyraan on 12/10/22.
//

import Foundation
 
class UserModel: Identifiable {
    
    public var id: Int64 = 0
    public var aadhaar: String = ""
    public var name: String = ""
    public var email: String = ""
    public var phone: String = ""
    public var age: Int64 = 0
    public var dob: Date = Date()
    
    public var skill: String = ""
    
    public var institute: String = ""
    public var department: String = ""
    public var passoutYear: String = ""
    public var percentage: Int64 = 0
    
}


//class DataModel: Identifiable {
//
//    //user
//    public var id: Int64 = 0
//    public var aadhaar: String = ""
//    public var name: String = ""
//    public var phone: String = ""
//    public var email: String = ""
//    public var dob: Date = Date()
//
//    //skills
//    public var skill: String = ""
//
//    //education
//    public var institute: String = ""
//    public var department: String = ""
//    public var passoutYear: String = ""
//    public var percentage: Int64 = 0
//
//}
