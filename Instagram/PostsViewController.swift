//
//  PostsViewController.swift
//  Instagram
//
//  Created by Victoria Zhou on 3/7/17.
//  Copyright © 2017 Victoria Zhou. All rights reserved.
//

import UIKit
import Parse

class PostsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            // PFUser.currentUser() will now be nil
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userDidLogout"), object: nil)
        print("I've logged out")
        print("Current user: " + PFUser.current().debugDescription)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
