//
//  UserListViewController.swift
//  MobileChallenge
//
//  Created by Juan Carlos Cardozo on 29/6/17.
//  Copyright © 2017 Juan Carlos Cardozo. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Data
    var itemSelected:User?
    var myPhones = [Phone]()
    var dataFromAPI = [User]()
    var filteredData = [User]()
    var chosenCellIndex = 0
    
    // MARK: Static Labels
    @IBOutlet weak var labelHeaderTitle: UILabel!
    
    // MARK: Views
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var foobarBar: UIView!
    @IBOutlet weak var globalView: UIView!
    @IBOutlet weak var headerBar: UIView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style
        navigationController?.customNavBar()
        
        foobarBar.backgroundColor = Color.myColor
        headerBar.backgroundColor = Color.barColor
        labelHeaderTitle.setTextHeader()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        
        definesPresentationContext = true
        dataTableView.tableHeaderView = searchController.searchBar
        
        loadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredData.count
        }
        
        return dataFromAPI.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "UserCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        
        if searchController.isActive && searchController.searchBar.text != ""{
            itemSelected = filteredData[indexPath.row]
        }
        else{
            itemSelected = dataFromAPI[indexPath.row]
        }
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.clear
        }
        else{
            cell.backgroundColor = UIColor.lightText
        }
        
        if(itemSelected?.thumb != nil && itemSelected?.thumb != ""){
            
            let imgstr = (itemSelected?.thumb)!
            if let url = NSURL(string: imgstr){
                
                print("---> url: \(url)")
                URLSession.shared.dataTask(with: url as URL, completionHandler: {(data, respones, error) in
                    
                    if error != nil{
                        print("Error Image Url: \(String(describing: error))")
                        cell.userImg.image = UIImage(named: "user_icon")
                        return
                    }
                    
                    DispatchQueue.main.async{
                        cell.userImg.image = UIImage(data: data!)
                        cell.userImg.layer.masksToBounds = true
                        cell.userImg.clipsToBounds = true
                        cell.userImg.contentMode = UIViewContentMode.scaleAspectFit
                    }
                    
                }).resume()
            }
        }
        else{
            cell.userImg.image = UIImage(named: "user_icon")
        }
        
        let firstName = itemSelected?.first_name
        let lastName = itemSelected?.last_name
        cell.userName.text = "\(firstName!) \(lastName!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var heigth = 70
        
        if MyHelpers.isLessThanIPhone6(){
            heigth = Int(Float(heigth) * general.fact5)
        }
        else if MyHelpers.isPlus(){
            heigth = Int(Float(heigth) * general.factPlus)
        }
        
        return CGFloat(heigth)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchController.isActive && searchController.searchBar.text != ""{
            itemSelected = filteredData[indexPath.row]
        }
        else{
            itemSelected = dataFromAPI[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredData = dataFromAPI.filter { itemSelected in
            
            return (itemSelected.first_name.lowercased().range(of: searchText.lowercased()) != nil || itemSelected.last_name.lowercased().range(of: searchText.lowercased()) != nil)
        }
        
        dataTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let detailVC = segue.destination as! UserDetailViewController
            
            detailVC.user = itemSelected
            
        }
    }
    
    func loadData(){
        
        UserApi.sharedInstance.getAllUsersRequest(myView: self.view, completion: {(users) -> Void in
            
            let NumOfRows = users.count
            
            for i in 0...(NumOfRows-1){
                
                var newRow = users[i]
                self.myPhones.removeAll()
                
                let userPhones = newRow["phones"]
                let NumOfPhones = userPhones.count
                
                for j in 0...(NumOfPhones-1){
                    
                    var newPhone = userPhones[j]
                    
                    if(newPhone["number"] != nil && newPhone["number"] != "null"){
                        let NewItem = Phone(
                            type: newPhone["type"].string as String!,
                            number: newPhone["number"].string as String!
                        )
                        self.myPhones.append(NewItem!)
                    }
                }
                
                let NewUser = User(
                    id: newRow["user_id"].string as String!,
                    create: newRow["created_at"].string as String!,
                    birth_date: newRow["birth_date"].string as String!,
                    first_name: newRow["first_name"].string as String!,
                    last_name: newRow["last_name"].string as String!,
                    phones: self.myPhones,
                    thumb: newRow["thumb"].string as String!,
                    photo: newRow["photo"].string as String!
                )
                
                self.dataFromAPI.append(NewUser!)
            }
            self.dataTableView.reloadData()
        })
        
    }
    
}

extension UserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}



