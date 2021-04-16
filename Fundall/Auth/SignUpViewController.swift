//
//  SignUpViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import UIKit
import TransitionButton
import RxSwift

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var signUpButton: TransitionButton!
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    let eyebutton = UIButton(type: .custom)
    let constant = Constants()
    var issecret = true
    var soft = SoftViews()
    
    private var disposebag = DisposeBag()
    
    
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
        let password =  passwordtext.text!
        let email = emailField.text!
        let name = firstName.text!
        if password.passwordValid() && email.isValidEmail() {
            signUpButton.startAnimation()
            APIClient.shared.register(firstname: firstName.text!, lastname: lastName.text!, password: passwordtext.text!, password_confirmation: passwordtext.text!, email: emailField.text!).observe(on: MainScheduler.instance).subscribe(onNext: {
                [self] result in
                let defaults = UserDefaults.standard
                //
                defaults.set(email, forKey: "email")
                defaults.set(name, forKey: "name")
                signUpButton.stopAnimation()
                constant.presentVC(presenter: self, identifier: "PasswordViewController")
            }, onError: {
                [self] error in
                SoftError.errorReturned(button: signUpButton, error422message: "Unknown Error", error: error, soft: soft, vc: self)
            }).disposed(by: disposebag)
        }else{
            soft.showOkayableMessage(" ", message: "Enter a Valid Email and Password", vc: self)
        }
        
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
