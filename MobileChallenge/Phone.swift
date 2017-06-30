//
//  Phone.swift
//  MobileChallenge
//
//  Created by Juan Carlos Cardozo on 29/6/17.
//  Copyright © 2017 Juan Carlos Cardozo. All rights reserved.
//

class Phone {
    
    // MARK: Properties
    var type:String
    var number:String
    
    // MARK: Initialization
    init?(type:String, number:String) {
        self.type = type
        self.number = number
    }
    
}
