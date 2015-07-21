//
//  ViewController.swift
//  In2-PI-Swift
//
//  Created by Terry Bu on 6/27/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON
import AFNetworking

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var navbarOnnuriLogoImage = UIImage(named: "in2Icon44")
        self.navigationItem.titleView = UIImageView(image: navbarOnnuriLogoImage)
        
        //FB login boilerplate
//        var loginButton = FBSDKLoginButton()
//        loginButton.center = self.view.center
//        self.view.addSubview(loginButton)
        
        var paramsDictionary = [
            "access_token": kAppAccessToken
        ]
        FBSDKGraphRequest(graphPath: "1384548091800506/albums", parameters: paramsDictionary).startWithCompletionHandler { (connection, data, error) -> Void in
            
            //Terry's test page
            //752896354818721/albums will get you the page's albums
            //757485894359767 is Untitled Album
            //757485937693096 is one image
            
            //In2 real page PI magazine
            //1384548091800506/albums will get you page's albums
            
            if (error == nil) {
                let jsonData = JSON(data)
                let albumsList = jsonData["data"]
                let firstAlbumID = albumsList[0]["id"].string
                    let lastParamsDictionary = [
                        "access_token": kAppAccessToken,
                        "fields" : "photos{picture}"

                    ]
                    FBSDKGraphRequest(graphPath: firstAlbumID, parameters: lastParamsDictionary).startWithCompletionHandler { (connection, albumPhotos, error) -> Void in
                        println(albumPhotos)
                        let albumPhotosJSON = JSON(albumPhotos)
                        let photos = albumPhotosJSON["photos"]
                        let photosArray = photos["data"]
                        let onePhotoObject = photosArray[0]
                        let onePhotoURLString = onePhotoObject["picture"].string
                        dispatch_async(dispatch_get_main_queue(),{
                            var imageView = UIImageView(frame: CGRectMake(50,50,100,100))
                            imageView.setImageWithURL(NSURL(string: onePhotoURLString!))
                            self.view.addSubview(imageView)
                        })
                    }
            }
            else {
                println(error)
            }
        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        return cell
    }
    

}

