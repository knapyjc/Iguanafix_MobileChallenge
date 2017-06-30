//
//  MyHelpers.swift
//  MobileChallenge
//
//  Created by Juan Carlos Cardozo on 29/6/17.
//  Copyright © 2017 Juan Carlos Cardozo. All rights reserved.
//

import UIKit

class MyHelpers {
    
    static let sharedInstance:MyHelpers = MyHelpers()
    
    private init(){}
    
    static func isLessThanIPhone6() -> Bool{
        
        let model: String = UIDevice.current.modelName
        return (model == "iPod 5" || model == "iPhone 5" || model == "iPhone 5c" ||
            model == "iPhone 5s" || model == "iPhone SE")
        //|| model == "Simulator")
    }
    
    static func isPlus() -> Bool{
        
        let model: String = UIDevice.current.modelName
        return (model == "iPhone 6 Plus" || model == "iPhone 6s Plus" || model == "iPhone 7 Plus")
        //|| model == "Simulator")
    }
    
}

