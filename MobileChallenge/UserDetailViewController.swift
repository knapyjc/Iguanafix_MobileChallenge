//
//  UserDetailViewController.swift
//  MobileChallenge
//
//  Created by Juan Carlos Cardozo on 29/6/17.
//  Copyright © 2017 Juan Carlos Cardozo. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    //MARK: - Static Labels
    @IBOutlet weak var labelHeaderTitle: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var phonesLabel: UILabel!
    @IBOutlet weak var phone1Label: UILabel!
    @IBOutlet weak var phone2Label: UILabel!
    @IBOutlet weak var phone3Label: UILabel!
    
    //MARK: - Var Labels
    @IBOutlet weak var nameData: UILabel!
    @IBOutlet weak var birthData: UILabel!
    @IBOutlet weak var phone1Data: UILabel!
    @IBOutlet weak var phone2Data: UILabel!
    @IBOutlet weak var phone3Data: UILabel!
    
    //MARK: - Views
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var foobarBar: UIView!
    @IBOutlet weak var globalView: UIView!
    @IBOutlet weak var headerBar: UIView!
    @IBOutlet weak var userImage: UIImageView!
    
    //MARK: Data
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style
        navigationController?.customNavBar()
        
        foobarBar.backgroundColor = Color.myColor
        headerBar.backgroundColor = Color.barColor
        labelHeaderTitle.setTextHeader()
        
        nameLabel.setTextGrey()
        birthLabel.setTextGrey()
        phonesLabel.setTextGrey()
        phone1Label.setTextGrey()
        phone2Label.setTextGrey()
        phone3Label.setTextGrey()
        
        nameData.setTextGrey()
        birthData.setTextGrey()
        phone1Data.setTextGrey()
        phone2Data.setTextGrey()
        phone3Data.setTextGrey()
        
        
        if(user?.photo != nil && user?.photo != ""){
            
            let imgstr = (user?.photo)!
            if let url = NSURL(string: imgstr){
                
                print("---> url: \(url)")
                URLSession.shared.dataTask(with: url as URL, completionHandler: {(data, respones, error) in
                    
                    if error != nil{
                        print("Error Image Url: \(String(describing: error))")
                        self.userImage.image = UIImage(named: "user_icon")
                        return
                    }
                    
                    DispatchQueue.main.async{
                        self.userImage.image = UIImage(data: data!)
                        self.userImage.layer.masksToBounds = true
                        self.userImage.clipsToBounds = true
                        self.userImage.contentMode = UIViewContentMode.scaleAspectFit
                    }
                    
                }).resume()
            }
        }
        else{
            userImage.image = UIImage(named: "user_icon")
        }
        
        let phoneCount = user?.phones.count
        
        nameData.text = (user?.first_name)! + " " + (user?.last_name)!
        birthData.text = user?.birth_date
        phoneCount! > 0 ? (phone1Data.text = user?.phones[0].number) : (phone1Data.text = "")
        phoneCount! > 1 ? (phone2Data.text = user?.phones[1].number) : (phone2Data.text = "")
        phoneCount! > 2 ? (phone3Data.text = user?.phones[2].number) : (phone3Data.text = "")
        
    }
}
