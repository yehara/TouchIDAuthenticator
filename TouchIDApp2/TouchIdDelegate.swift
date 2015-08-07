//
//  TouchIdDelegate.swift
//  TouchIdApp
//
//  Created by 江原 良典 on 2015/08/07.
//  Copyright (c) 2015年 yehara.com. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class TouchIdDelegate : NSObject, IACDelegate {
    
    func supportsIACAction(action:String) -> Bool {
        println("supports?: \(action)")

        return (["login", "hoge"] as NSArray).containsObject(action)
    }
    
    func performIACAction(action:String, parameters:[NSObject : AnyObject]!, onSuccess:IACSuccessBlock, onFailure:IACFailureBlock) -> Void {
        println("action: \(action)")
        println("parameter \(parameters)")
        if(action == "login") {
            self.doLogin(parameters, onSuccess: onSuccess, onFailure: onFailure)
        }
    }
    
    func doLogin(parameters:[NSObject : AnyObject]!, onSuccess:IACSuccessBlock, onFailure:IACFailureBlock) {
        let context = LAContext()
        let localizedReason = "テストです。"
        context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason) {(success: Bool, authenticationError: NSError!) in
            if success {
                //let alertController = self.alertViewController("TouchID", message: "認証に成功しました！")
                //self.getViewController().presentViewController(alertController, animated: true, completion: nil)
                onSuccess(["aaaa":"bbbb"], false)
            } else {
                //let message = "認証に失敗しました。\n\(authenticationError.localizedDescription)"
                //let alertController = self.alertViewController("TouchID", message: message)
                //self.getViewController().presentViewController(alertController, animated: true, completion: nil)
                onFailure(NSError(domain: "domain", code:-1, userInfo: nil))
            }
        }
    }

    private func getViewController() -> ViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController:ViewController = storyboard.instantiateViewControllerWithIdentifier("fingerprint") as! ViewController
        return viewController
    }
    
    
    private func alertViewController(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) in
        }
        alertController.addAction(okAction)
        return alertController
    }

}