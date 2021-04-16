//
//  LoginViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import UIKit
import Kingfisher

class LoginViewController: UIViewController {
    let constant = Constants()
    var name: String!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var avartar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        name = defaults.string(forKey: "name")
        welcomeLabel.text = "\(name ?? " ")'s LifeStyle"
        let urlString = defaults.string(forKey: "avatar")
        if urlString != nil && !(urlString?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            let url = URL(string: urlString ?? " ")
            avartar.kf.setImage(with: url)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInPressed(){
            constant.presentVC(presenter: self, identifier: "SignUpViewController")
    }
    
    @IBAction func passwordPressed(){
        constant.presentVC(presenter: self, identifier: "PasswordViewController")
    }
    
    
  
    
    
    @IBAction func biometricPressed(){
        constant.presentVC(presenter: self, identifier: "HomeViewController")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
