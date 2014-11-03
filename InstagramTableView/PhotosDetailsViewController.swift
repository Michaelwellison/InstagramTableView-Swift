//
//  PhotosDetailsViewController.swift
//  InstagramTableView
//
//  Created by Michael Ellison on 11/2/14.
//  Copyright (c) 2014 MichaelWEllison. All rights reserved.
//

import UIKit

class PhotosDetailsViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var photoDetailLabel: UILabel!
    
    
    var photo: NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoDetailLabel.text = photo!.valueForKeyPath("caption.text") as? String
        var imageURL = photo!.valueForKeyPath("images.low_resolution.url") as? String
        photoImageView.setImageWithURL(NSURL(string: imageURL!))
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
