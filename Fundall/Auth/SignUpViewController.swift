//
//  SignUpViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import UIKit
import TransitionButton

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var signUpButton: TransitionButton!
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    let eyebutton = UIButton(type: .custom)
    let constant = Constants()
    var issecret = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.cornerRadius = 5
        passwordtext.toogglepassword()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.loginPressed))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(tap)
        passwordtext.delegate = self
        constant.addPasswordToggle(field: passwordtext, eyebutton: eyebutton)
        eyebutton.addTarget(self, action: #selector(taprecognise), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(){
        constant.presentVC(presenter: self, identifier: "LoginViewController")
    }
    
    @objc func loginPressed(){
        constant.presentVC(presenter: self, identifier: "LoginViewController")
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

extension SignUpViewController{
    
    @objc func taprecognise(){
        if self.issecret {
            // imageview.image = UIImage(systemName: "eye.slash")
            eyebutton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordtext.toogglepassword()
        } else{
            //  imageview.image = UIImage(systemName: "eye")
           eyebutton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordtext.toogglepassword()
        }
        issecret = !issecret
        
    }
   
}
