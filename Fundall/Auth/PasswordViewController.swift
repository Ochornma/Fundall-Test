//
//  PasswordViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import UIKit
import RxSwift
import TransitionButton

class PasswordViewController: UIViewController{
    
    
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var avartar: UIImageView!
    @IBOutlet weak var loginButton: TransitionButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    let eyebutton = UIButton(type: .custom)
    
    let constant = Constants()
    var issecret = true
    var email: String!
    var name: String!
    var soft = SoftViews()
    let defaults = UserDefaults.standard
    private var disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordtext.toogglepassword()
     //   passwordtext.delegate = self
        constant.addPasswordToggle(field: passwordtext, eyebutton: eyebutton)
        eyebutton.addTarget(self, action: #selector(taprecognise), for: .touchUpInside)
        
        email = defaults.string(forKey: "email")
        name = defaults.string(forKey: "name")
        
        NetworkUpload.shared.generaldelegate = self
        NetworkUpload.shared.unaunthenticateDelegae = self
        NetworkUpload.shared.uploadDelegate = self
        emailLabel.text = email
        welcomeLabel.text = "We miss you, \(name ?? " ")"
        let urlString = defaults.string(forKey: "avatar")
        if urlString != nil && !(urlString?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            let url = URL(string: urlString ?? " ")
            avartar.kf.setImage(with: url)
        }
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.uploadData))
        uploadLabel.addGestureRecognizer(tap1)
        indicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func stopAnimation(){
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    @IBAction func cancelPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newAccountPressed(){
        constant.presentVC(presenter: self, identifier: "SignUpViewController")
    }
    
    @IBAction func loginPressed(){
        let password = passwordtext.text!
        if password.passwordValid() {
            loginButton.startAnimation()
            APIClient.shared.login(email: email, password: password).observe(on: MainScheduler.instance).subscribe(onNext: {[self] result in
                defaults.set(result.success?.user?.accessToken, forKey: "token")
                defaults.set(result.success?.user?.email, forKey: "email")
                defaults.set(result.success?.user?.firstname, forKey: "name")
                defaults.set(result.success?.user?.avatar, forKey: "avatar")
                loginButton.stopAnimation()
                //token
                constant.presentVC(presenter: self, identifier: "HomeViewController")
            }, onError: {
                [self] error in
                SoftError.errorReturned(button: loginButton, error422message: "Unknown Error", error: error, soft: soft, vc: self)
            }).disposed(by: disposebag)
        }else{
            soft.showOkayableMessage("", message: "Enter a valid password", vc: self)
        }
       
       
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

extension PasswordViewController{
    
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
    
    @objc func uploadData(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
       // vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
   
}

/**
 var generaldelegate: UploadErrorMessage?
 var uploadDelegate: UploadSuccess?
 var unaunthenticateDelegae: Unaunthenticated?
 */

extension PasswordViewController: UploadErrorMessage, UploadSuccess, Unaunthenticated{
    func uploadError() {
        stopAnimation()
        soft.showOkayableMessage("Error", message: "Error in uploading avartar", vc: self)
    }
    
    func upload(respone: AvatarResponse) {
        stopAnimation()
        let url = URL(string: respone.success?.url ?? " ")
        avartar.kf.setImage(with: url)
        soft.showOkayableMessage("Success", message: "Successful", vc: self)
    }
    
    func errow() {
        stopAnimation()
        soft.unauntenticated(" ", message: "Session Expired", vc: self)
    }
    
    
}

extension PasswordViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            indicator.startAnimating()
            indicator.isHidden = false
            let imageUrl = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
            NetworkUpload.shared.uploadDocument(image: image, imageUrl: imageUrl)
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        stopAnimation()
    }
}

