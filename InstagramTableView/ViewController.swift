//
//  ViewController.swift
//  InstagramTableView
//
//  Created by Michael Ellison on 10/26/14.
//  Copyright (c) 2014 MichaelWEllison. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    
    var users = [
        [
            "name":"Hana",
            "hometown":"Detroit"
        ],
        [
            "name":"Ida",
            "hometown":"San Francisco"
        ],
        [
            "name":"Jessica",
            "hometown":"Detroit"
        ],
        [
            "name":"Bjorn",
            "hometown":"Oslo"
        ],
        [
            "name":"Alli",
            "hometown":"San Francisco"
        ],
        [
            "name":"Jayne",
            "hometown":"Louis"
        ],
        [
            "name":"David",
            "hometown":"Kodiak"
        ],
        [
            "name":"Hamza",
            "hometown":"Los Angeles"
        ]
    ]
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureTableView()
        configureURLConnection()
    }
    
    // MARK: Configuration
    
    func configureTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
    
    }
    
    func configureURLConnection () {
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=e6135d83e50c4d9184e937a61fa54bbe")
        
        var request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            // got our code here
            
            var objects: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
            
            println("objects \(objects)")
        }
    }
    
    // MARK: Table View Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(users.count)
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("NamesCell") as NamesCell
        
        var user = users[indexPath.row]
        
        cell.nameLabel.text = user["name"]
        cell.hometownLabel.text = user["hometown"]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected row \(indexPath.row) at section \(indexPath.section)")
        
        var user = users[indexPath.row]
        var name = user["name"]
        println("Hello \(name)")
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // create our top level header view
        var headerView = UIView(frame: CGRect(x: 10, y: 0, width: 310, height: 100))
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        
        // add our label
        var label = UILabel(frame: headerView.frame)
        label.text = "Section \(section)"
        label.font = UIFont.systemFontOfSize(20)
        
        // don't forget to add label as a subview of header view
        headerView.addSubview(label)
        
        // return the headerView to the tableView
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

