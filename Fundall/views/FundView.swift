//
//  FundView.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
import UIKit


class SoftViews {
    
 
    func showOkayableMessage(_ title: String, message: String, vc: UIViewController){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        action.setValue(UIColor.init(red: 32/255, green: 209/255, blue: 35/255, alpha: 1), forKey: "titleTextColor")
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func unauntenticated(_ title: String, message: String, vc: UIViewController){
        let alert = UIAlertController(
            title: "",
            message: "Session Expired",
            preferredStyle: UIAlertController.Style.alert
        )
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in
            let stoaryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVc = stoaryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            mainVc.modalPresentationStyle = .fullScreen
            vc.present(mainVc, animated: true, completion: nil)
        })
        action.setValue(UIColor.init(red: 32/255, green: 209/255, blue: 35/255, alpha: 1), forKey: "titleTextColor")
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}

