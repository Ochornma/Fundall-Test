//
//  LoginViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import UIKit

class LoginViewController: UIViewController {
    let constant = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInPressed(){
            constant.presentVC(presenter: self, identifier: "SignUpViewController")
    }
    
    @IBAction func passwordPressed(){
        constant.presentVC(presenter: self, identifier: "PasswordViewController")
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
