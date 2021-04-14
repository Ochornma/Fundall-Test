//
//  SignUpViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(){
        let stoaryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVc = stoaryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        mainVc.modalPresentationStyle = .fullScreen
        self.present(mainVc, animated: true, completion: nil)
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
