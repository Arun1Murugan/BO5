//
//  DB_Manager.swift
//  SQLTask (iOS)
//
//  Created by Arun_Skyraan on 12/10/22.
//

 
import Foundation
import SQLite

class DB_Manager {

    private var db: Connection!

    private var users: Table! //table1
    


    private var id: Expression<Int64>!
    private var aadhaar: Expression<String>!
    private var name: Expression<String>!
    private var email: Expression<String>!
    private var phone: Expression<String>!
    private var dob: Expression<Date>!
    
   
    
    private var institute: Expression<String>!
    private var department: Expression<String>!
    private var passout: Expression<String>!
    private var percentage: Expression<Int64>!

    init() {

        do {

let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""

            db = try Connection("\(path)/my_users.sqlite3")

            users = Table("users")

            id = Expression<Int64>("id")
            aadhaar = Expression<String>("aadhaar")
            name = Expression<String>("name")
            email = Expression<String>("email")
            phone = Expression<String>("phone")
            dob = Expression<Date>("dob")
            
//            skill = Expression<String>("skill")
            
//            institute = Expression<String>("institute")
//            department = Expression<String>("department")
//            passout = Expression<String>("passout")
//            percentage = Expression<Int64>("percentage")
        

            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {


                try db.run(users.create {(t) in
                    t.column(id, primaryKey: true)
                    t.column(aadhaar, unique: true)
                    t.column(name)
                    t.column(email, unique: true)
                    t.column(phone)
                    t.column(dob)

                })

                UserDefaults.standard.set(true, forKey: "is_db_created")
            }

        } catch {
            print(error.localizedDescription)
        }
    }

    public func getUserData(idValue: Int64!, aadhaarValue: String, nameValue: String, emailValue: String, phoneValue: String, dobValue: Date) {
        do {
            try db.run(users.insert(id <- idValue, aadhaar <- aadhaarValue, name <- nameValue, email <- emailValue, phone <- phoneValue, dob <- dobValue))
        } catch {
            print(error.localizedDescription)
        }
    }

    public func updateUserData(idValue: Int64, aadhaarValue: String, nameValue: String, emailValue: String, phoneValue: String, dobValue: Date) {
        do {
            // get user using ID
            let user: Table = users.filter(id == idValue)
            try db.run(user.update(aadhaar <- aadhaarValue, name <- nameValue, email <- emailValue, phone <- phoneValue, dob <- dobValue))
        } catch {
            print(error.localizedDescription)
        }
    }

    public func deleteUser(idValue: Int64) {
        do {
            let user: Table = users.filter(id == idValue)
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }

    public func getUsers() -> [UserModel] {

        var userModels: [UserModel] = []

        users = users.order(id.desc)

        do {

            for user in try db.prepare(users) {

                let userModel: UserModel = UserModel()

                userModel.id = user[id]
                userModel.aadhaar = user[aadhaar]
                userModel.name = user[name]
                userModel.email = user[email]
                userModel.phone = user[phone]
                userModel.dob = user[dob]

                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }

        return userModels
    }

    public func getUser(idValue: Int64) -> UserModel {

        let userModel: UserModel = UserModel()

        do{
            let user: AnySequence<Row> = try db.prepare(users.filter(id == idValue))

            try user.forEach({ rowValue in
                userModel.id = try rowValue.get(id)
                userModel.aadhaar = try rowValue.get(aadhaar)
                userModel.name = try rowValue.get(name)
                userModel.email = try rowValue.get(email)
                userModel.phone = try rowValue.get(phone)
                userModel.dob = try rowValue.get(dob)
            })
        }

        catch {
            print(error.localizedDescription)
        }

        return userModel
    }

}


class DB_Manager1 {

    private var db: Connection!

    private var users: Table! //table1
    private var skills: Table!

    private var id: Expression<Int64>!
//    private var name: Expression<String>!
//    private var email: Expression<String>!
//    private var age: Expression<Int64>!
    private var skill: Expression<String>!


    init() {

        do {

let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""

            db = try Connection("\(path)/my_users.sqlite3")


            users = Table("users")

            id = Expression<Int64>("id")
            skill = Expression<String>("skills")
//            name = Expression<String>("name")
//            email = Expression<String>("email")
//            age = Expression<Int64>("age")


            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {

                try db.run(users.create {(t) in
                    t.column(id, primaryKey: true)
                    t.column(skill)
//                    t.column(name)
//                    t.column(email, unique: true)
//                    t.column(age)

                })


                UserDefaults.standard.set(true, forKey: "is_db_created")
            }

        } catch {
            print(error.localizedDescription)
        }
    }

    public func addUser(skillValue: String) {
        do {
            try db.run(users.insert(skill <- skillValue))
        } catch {
            print(error.localizedDescription)
        }
    }

//    public func updateUser(idValue: Int64, nameValue: String, emailValue: String, ageValue: Int64) {
//        do {
//
//            let user: Table = users.filter(id == idValue)
//            try db.run(user.update(name <- nameValue, email <- emailValue, age <- ageValue))
//        } catch {
//            print(error.localizedDescription)
//        }
//    }

//    public func deleteUser(idValue: Int64) {
//        do {
//            let user: Table = users.filter(id == idValue)
//            try db.run(user.delete())
//        } catch {
//            print(error.localizedDescription)
//        }
//    }


    public func getUsers() -> [UserModel] {

        var userModels: [UserModel] = []


        users = users.order(id.desc)


        do {

            for user in try db.prepare(users) {

                let userModel: UserModel = UserModel()


                userModel.id = user[id]
                userModel.skill = user[skill]
//                userModel.name = user[name]
//                userModel.email = user[email]
//                userModel.age = user[age]

                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }

        return userModels
    }


    public func getUser(idValue: Int64) -> UserModel {
        // create an empty object
        let userModel: UserModel = UserModel()


        do{
            // get user using ID
            let user: AnySequence<Row> = try db.prepare(users.filter(id == idValue))

            // get row
            try user.forEach({ rowValue in
                // set values in model
                userModel.id = try rowValue.get(id)
                userModel.skill = try rowValue.get(skill)
//                userModel.name = try rowValue.get(name)
//                userModel.email = try rowValue.get(email)
//                userModel.age = try rowValue.get(age)
            })
        }

        catch {
            print(error.localizedDescription)
        }

        return userModel
    }

}
