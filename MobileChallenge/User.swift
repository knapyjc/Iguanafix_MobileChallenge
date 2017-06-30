//
//  User.swift
//  MobileChallenge
//
//  Created by Juan Carlos Cardozo on 29/6/17.
//  Copyright © 2017 Juan Carlos Cardozo. All rights reserved.
//


class User {
    
    // MARK: Properties
    var id:String
    var create:String
    var birth_date:String
    var first_name:String
    var last_name:String
    var phones:[Phone]
    var thumb:String
    var photo:String
    
    static let getUsers = "https://private-d0cc1-iguanafixtest.apiary-mock.com/contacts"
    
    // MARK: Initialization
    init?(id:String, create:String, birth_date:String, first_name:String, last_name:String, phones:[Phone], thumb:String, photo:String) {
        self.id = id
        self.create = create
        self.birth_date = birth_date
        self.first_name = first_name
        self.last_name = last_name
        self.phones = phones
        self.thumb = thumb
        self.photo = photo
    }
}
