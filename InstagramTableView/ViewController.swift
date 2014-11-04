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
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as PhotoCell
        
        var photo = photos[indexPath.section] as NSDictionary
        cell.imageCaption.text = photo.valueForKeyPath("caption.text") as? String
        var imageURL = photo.valueForKeyPath("images.low_resolution.url") as? String
        cell.photoView.setImageWithURL(NSURL(string: imageURL!))
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //  tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("PhotoDetailSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // create the header view
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        // Retrieve data for each object in our header
        var photo = photos[section] as NSDictionary
        var user = photo["user"] as NSDictionary
        var username = user["username"] as String
        var profileUrl = NSURL(string: user["profile_picture"] as String)
        var label = UILabel(frame: headerView.frame)
        
        // Create the profile image view and add to header view
        var profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1
        profileView.setImageWithURL(profileUrl)
        headerView.addSubview(profileView)
        
        // Create the Profile label and add it to the header view
        var usernameLabel = UILabel(frame: CGRect(x: 50, y: 10, width: 250, height: 30))
        usernameLabel.text = username
        usernameLabel.font = UIFont.boldSystemFontOfSize(16)
        usernameLabel.textColor = UIColor(red: 8/255.0, green: 64/255.0, blue: 127/255.0, alpha: 1)
        headerView.addSubview(usernameLabel)
        
        // return the headerView to the tableView
        
        return headerView
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NAVIGATION
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Determine which row was selected
        
        let indexPath = tableView.indexPathForSelectedRow()
        
        // Get the view controller that we're transitioning to.
        var photoDetailsViewController = segue.destinationViewController as PhotosDetailsViewController

        // Set the data of the view controller
      
        var photo = photos[indexPath!.section] as NSDictionary
        photoDetailsViewController.photo = photo

    }

}

