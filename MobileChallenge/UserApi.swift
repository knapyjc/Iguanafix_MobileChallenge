//
//  UserApi.swift
//  MobileChallenge
//
//  Created by Juan Carlos Cardozo on 29/6/17.
//  Copyright © 2017 Juan Carlos Cardozo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserApi {
    
    // MARK: - Singelton
    static let sharedInstance:UserApi = UserApi()
    
    private init() {}
    
    //MARK: - Activity Indicator
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let container: UIView = UIView()
    let loadingView: UIView = UIView()
    
    private let pathUrl = User.getUsers
    
    // ********************************************************
    // MARK: Get All Users
    // ********************************************************
    func getAllUsersRequest(myView: UIView, completion: @escaping (_ users: JSON) -> Void) {
        
        myView.displayIndicator(indicator: indicator, container: container, loadingView: loadingView)
        
        Alamofire.request(pathUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON{
            response in
            
            switch response.result {
            case .success:
                
                if let value: AnyObject = response.result.value as AnyObject? {
                    
                    let apiReturn = JSON(value)
                    myView.stopIndicator(indicator: self.indicator, container: self.container)
                    
                    if apiReturn["errors"] != nil{
                        self.processApiError(apiReturn: apiReturn)
                    }
                    completion(apiReturn)
                }
            break
                
            case .failure(let error):
                print("ERROR IN CONECTION: \(error)")
                self.displayMyAlertMessage(userMessage: "Server Conection Fail", userTitle: "Error")
                myView.stopIndicator(indicator: self.indicator, container: self.container)
            break
            }
        }
    }
    


    // ********************************************************
    // MARK: Process API Error Case
    // ********************************************************
    func processApiError(apiReturn:JSON){
        
        var alertTitle:String = ""
        var messageToDisplay:String = ""
        
        print("Alamofire status Error")
        alertTitle = "Error"
        let msjTemp = apiReturn["errors"]
        let msjChat = apiReturn["error_body"]
        
        print("------> msjTemp: \(msjTemp)")
        print("------> msjChat: \(msjChat)")
        
        print(msjTemp)
        var errorTxt = "";
        
        for (index, text) in msjTemp {
            print("\(index): \(text)")
            let msjtext = text.rawString()
            errorTxt = errorTxt + msjtext! + ", "
        }
        
        for (index, text) in msjChat {
            print("\(index): \(text)")
            let msjtext = text.rawString()
            errorTxt = errorTxt + msjtext! + ", "
        }
        
        print("errorTxt: \(errorTxt)")
        
        //var truncated = errorTxt.substringToIndex(errorTxt.endIndex.predecessor())
        var truncated = errorTxt.substring(to: errorTxt.endIndex)
        
        //truncated = truncated.substringToIndex(truncated.endIndex.predecessor())
        truncated = truncated.substring(to: truncated.endIndex)
        
        messageToDisplay = truncated
        
        self.displayMyAlertMessage(userMessage: messageToDisplay, userTitle: alertTitle)
    }
    
    
    
    // ********************************************************
    // MARK: Display Alert Message
    // ********************************************************
    func displayMyAlertMessage(userMessage:String, userTitle:String){
        //It takes the title and the alert message and prefferred style
        let alertController = UIAlertController(title: userTitle, message: userMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        //now we are adding the default action to our alertcontroller
        alertController.addAction(defaultAction)
        
        //Get Top View Controller
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
            print("topVC \(String(describing: topVC))")
        }
        
        //Show Alert
        topVC?.present(alertController, animated: true, completion: nil)
    }
}
