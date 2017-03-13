//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Victoria Zhou on 3/12/17.
//  Copyright © 2017 Victoria Zhou. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var tapSelectButton: UIButton!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captionField.delegate = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        //imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        let image = Post.resize(image: editedImage, newSize: CGSize(width: 300, height: 300))
        tapSelectButton.setTitle("", for: .normal)
        selectedImageView.image = image
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCaptureButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        Post.postUserImage(image: selectedImageView.image, withCaption: captionField.text) { (success: Bool, error: Error?) in
            self.selectedImageView.image = nil
            self.tapSelectButton.setTitle("Tap to select image", for: .normal)
            self.dismiss(animated: true, completion: nil)
            print("Posted image! :D")
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
