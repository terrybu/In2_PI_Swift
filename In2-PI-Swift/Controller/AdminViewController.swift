//
//  AdminViewController.swift
//  In2-PI-Swift
//
//  Created by Terry Bu on 2/7/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    
    @IBOutlet weak var noticeButton: UIButton!
    @IBOutlet weak var socialServicesScheduleButton: UIButton!
    
    @IBAction func xButtonPressed() {
        self.navigationController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func noticeButtonPressed(sender: AnyObject) {
        let noticeVC = NoticeAdminViewController()
        self.navigationController?.pushViewController(noticeVC, animated: true)
    }
    
    
    @IBAction func socialServicesSchedulePressed(sender: AnyObject) {
        
    }
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIForNavBarAndStatus()
        
        if AuthenticationManager.sharedManager.currentUserMode == .SocialServicesAdmin {
            noticeButton.enabled = false
        } else {
            noticeButton.enabled = true
        }
    }
    
    private func setUpUIForNavBarAndStatus() {
        let statusBarBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 20))
        statusBarBackgroundView.backgroundColor = UIColor(patternImage: UIImage(named:"status_bar")!)
        navigationController!.view.addSubview(statusBarBackgroundView)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_bar"), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "NanumBarunGothic", size: 18.0)!
        ]
        navigationController!.navigationBar.shadowImage = UIImage()
        let whiteHairLineCustom = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0.5))
        whiteHairLineCustom.backgroundColor = UIColor.clearColor()
        whiteHairLineCustom.alpha = 0.5
        view.addSubview(whiteHairLineCustom)
    }
    
}
