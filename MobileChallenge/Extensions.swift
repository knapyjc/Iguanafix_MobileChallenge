//
//  Extensions.swift
//  MobileChallenge
//
//  Created by Juan Carlos Cardozo on 29/6/17.
//  Copyright © 2017 Juan Carlos Cardozo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: Display Message Alert
    func displayMyAlertMessage(userMessage:String, userTitle:String){
        let myAlert = UIAlertController(title: userTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil)
    }
    
}

extension UIView{
    
    func displayIndicator(indicator:UIActivityIndicatorView, container:UIView, loadingView: UIView){
        //MARK: - Conteiner View
        container.frame = self.frame
        container.center = self.center
        container.backgroundColor = UIColor(red:0.69, green:0.68, blue:0.67, alpha:1.0).withAlphaComponent(0.4)
        
        //MARK: - Loading View
        loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
        loadingView.center = self.center
        loadingView.backgroundColor = UIColor.clear
        
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 15
        
        //MARK: - Activity Indicator
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.color = Color.myColor
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        indicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        //MARK: - Show Indicator
        loadingView.addSubview(indicator)
        container.addSubview(loadingView)
        self.addSubview(container)
        container.isHidden = false
        indicator.startAnimating()
    }
    
    func stopIndicator(indicator:UIActivityIndicatorView, container:UIView){
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        container.isHidden = true
    }
    
}

extension UINavigationController {
    
    func customNavBar() {
        self.navigationBar.tintColor = Color.myColor
        self.navigationBar.barTintColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.lightGray]
    }
    
}

extension UILabel{
    
    func setTextGrey(){
        
        var fontSize = 0
        if MyHelpers.isLessThanIPhone6(){
            fontSize = 14
        }
        else if MyHelpers.isPlus(){
            fontSize = 16
        }
        else{
            fontSize = 15
        }
        
        let myFont : UIFont = UIFont(name: "Helvetica", size: CGFloat(fontSize))!
        self.font = myFont
        self.textColor = Color.TextGrey
        
    }
    
    func setTextHeader(){
        var fontSize = 0
        if MyHelpers.isLessThanIPhone6(){
            fontSize = 16
        }
        else if MyHelpers.isPlus(){
            fontSize = 18
        }
        else{
            fontSize = 17
        }
        
        let myFont : UIFont = UIFont(name: "Helvetica", size: CGFloat(fontSize))!
        self.font = myFont
        self.textColor = Color.myColor
    }
}

