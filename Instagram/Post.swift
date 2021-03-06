//
//  Post.swift
//  Instagram
//
//  Created by Victoria Zhou on 3/7/17.
//  Copyright © 2017 Victoria Zhou. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    var pfObject: PFObject?
    var media: PFFile?
    var author: PFUser?
    var caption: String?
    var likeCount: Int?
    var commentsCount: Int?
    
    init(object: PFObject) {
        self.pfObject = object
        self.media = object["media"] as? PFFile
        self.author = object["author"] as? PFUser
        self.caption = object["caption"] as? String
        self.likeCount = (object["likesCount"] as? Int) ?? 0
        self.commentsCount = (object["commentsCount"] as? Int) ?? 0
    }
    
    class func postsWithArray(pfobjects: [PFObject]) -> [Post]{
        var posts = [Post]()
        
        for obj in pfobjects {
            let post = Post(object: obj)
            posts.append(post)
        }
        return posts
    }
    
    /**
     * Method to add a user post to Parse (uploading image file)
     *
     * - parameter image: Image that the user wants upload to parse
     * - parameter caption: Caption text input by the user
     * - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     * Method to convert UIImage to PFFile
     *
     * - parameter image: Image that the user wants to upload to parse
     *
     * - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    /**
     * Resize image
     */
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
