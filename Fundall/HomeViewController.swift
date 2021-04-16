//
//  HomeViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 15/04/2021.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var fundTable: UITableView!
    let constant = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fundTable.delegate = self
        fundTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fundacell", for: indexPath) as! FundallHomeTableViewCell
        cell.setup()
        return cell
    }
    
    @IBAction func dismissToSignUp(){
        self.dismiss(animated: true)
    }
    
    @IBAction func requestCard(){
        constant.presentVC(presenter: self, identifier: "CardViewController")
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
