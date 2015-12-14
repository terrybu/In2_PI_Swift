//
//  LoginViewController.swift
//  In2-PI-Swift
//
//  Created by Terry Bu on 10/19/15.
//  Copyright © 2015 Terry Bu. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var dismissBlock : (() -> Void)?
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        let backgroundGradientImageView = UIImageView(image: UIImage(named: "bg_gradient"))
        backgroundGradientImageView.frame = view.frame
        view.insertSubview(backgroundGradientImageView, atIndex: 0)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let usernamePlaceHolderStr = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName:UIColor(white: 1, alpha: 0.5)])
        usernameTextField.attributedPlaceholder = usernamePlaceHolderStr
        let passwordPlaceHolderStr = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName:UIColor(white: 1, alpha: 0.5)])
        passwordTextField.attributedPlaceholder = passwordPlaceHolderStr
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.hidden = true
    }
    
    /**
    * Called when 'return' key pressed. return NO to ignore.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
    * Called when the user click on the view (outside the UITextField).
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func didPressLoginbutton() {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if username != nil && password != nil {
            let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
            hud.labelText = "로그인 실행중입니다."
            hud.color = UIColor.clearColor()
            PFUser.logInWithUsernameInBackground(username!, password: password!) { (user, error) -> Void in
                if let user = user {
                    print(user)
                    if let dismissBlock = self.dismissBlock {
                        dismissBlock()
                    }
                } else {
                    print(error)
                    let alertController = UIAlertController(title: "\(error!.localizedDescription)", message: "로그인이 실패하였습니다. Username, Password 의 입력을 다시 확인해 주세요.", preferredStyle: UIAlertControllerStyle.Alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alertController.addAction(ok)
                    alertController.view.tintColor = UIColor.In2DeepPurple()
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
