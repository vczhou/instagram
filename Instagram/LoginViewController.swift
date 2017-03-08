//
//  LoginViewController.swift
//  Instagram
//
//  Created by Victoria Zhou on 3/7/17.
//  Copyright © 2017 Victoria Zhou. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                if user != nil {
                    print("User logged in successfully")
                    print("Current user: " + PFUser.current().debugDescription)
                    // display view controller that needs to shown after successful login
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
                
            }
        }
    }


    @IBAction func onSignUpButton(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                if (error._code == 202) {
                    print("User name is taken")
                }
            } else {
                print("User Registered successfully")
                print("Current user: " + PFUser.current().debugDescription)
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)                
            }
        }
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
