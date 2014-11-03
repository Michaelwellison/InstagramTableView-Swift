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
    
    var photos: NSArray! = []
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
        configureTableView()
        configureURLConnection()
    }
    
    // MARK: Configuration
    
    func configureTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 300
    
    }
    
    func configureURLConnection () {
        
        var clientId = "e6135d83e50c4d9184e937a61fa54bbe"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        var request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.photos = responseDictionary["data"] as NSArray
            self.tableView.reloadData()
            
            println("response: \(self.photos)")
        }
    }
    
    // MARK: Table View Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as PhotoCell
        
        var photo = photos[indexPath.row] as NSDictionary
        cell.photoView.frame.size = CGSize(width: 286, height: 236)
        cell.imageCaption.text = photo.valueForKeyPath("caption.text") as? String
        var imageURL = photo.valueForKeyPath("images.low_resolution.url") as? String
        cell.photoView.setImageWithURL(NSURL(string: imageURL!))
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      //  tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        performSegueWithIdentifier("PhotoDetailSegue", sender: self)
        
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
        return 50
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NAVIGATION
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Determine which row was selected
        println("we got here")
        
        let indexPath = tableView.indexPathForSelectedRow()
        
        println("We got this far")
        
        println(indexPath)
        
        // Get the view controller that we're transitioning to.
        var photoDetailsViewController = segue.destinationViewController as PhotosDetailsViewController

        // Set the data of the view controller
      
        var photo = photos[indexPath!.row] as NSDictionary
        photoDetailsViewController.photo = photo

    }

}

