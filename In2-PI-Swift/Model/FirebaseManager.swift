//
//  FirebaseManager.swift
//  
//
//  Created by Terry Bu on 2/7/16.
//
//

import Foundation
import Firebase

class FirebaseManager {
    
    static let sharedManager = FirebaseManager()
    var firebaseDBRootRef = Firebase(url:"https://in2-pi.firebaseio.com")

    func loginUser(email: String, password: String, completion: ((success: Bool) -> Void)) {
        firebaseDBRootRef.authUser(email, password: password,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    print(error)
                    completion(success: false)
                } else {
                    // Authentication just completed successfully :)
                    // The logged in user's unique identifier
                    print(authData.uid)
//                    print(authData.providerData)
//                    let providerData = authData.providerData as NSDictionary
//                    let profileURL = providerData.objectForKey("profileImageURL")
//                    print(profileURL) 
                    completion(success: true)
                }
        })
    }
    
    func createUser(email: String, password: String, firstName: String, lastName: String, birthdayString: String, completion: ((success:Bool) -> Void)) {
        firebaseDBRootRef.createUser(email, password: password,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    print(error)
                    completion(success: false)
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                    completion(success: true)
                    // Create a new user dictionary accessing the user's info
                    // provided by the authData parameter
                    let newUser = [
                        "firstName": firstName,
                        "lastName": lastName,
                        "birthday": birthdayString
                    ]
                    // Create a child path with a key set to the uid underneath the "users" node
                    // This creates a URL path like the following:
                    //  - https://<YOUR-FIREBASE-APP>.firebaseio.com/users/<uid>
                    self.firebaseDBRootRef.childByAppendingPath("users")
                        .childByAppendingPath(uid).setValue(newUser)
                    
                    //Because Firebase signup does not AUTHENTICAT the user, must fire login again 
                    self.loginUser(email, password: password, completion: { (success) -> Void in
                        //completion block
                    })
                }
        })
    }
    
}