//
//  CardViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 15/04/2021.
//

import UIKit

class CardViewController: UIViewController {
    
    var selectedIndex:Int = -1
    @IBOutlet weak var confirmationView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cardCollection: UICollectionView!
    @IBOutlet weak var cardTable: UITableView!
    var cell:FundallCardTableViewCell!
    var cell2:FundallCardCollectionViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollection.delegate = self
        cardCollection.dataSource = self
        cardTable.delegate = self
        cardTable.dataSource = self
        confirmationView.layer.cornerRadius = 10
        //cardCollection.isUserInteractionEnabled = false
       // cardTable.isUserInteractionEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func dismiss() {
        self.dismiss(animated: true)
    }
    
    @IBAction func continuePressed(){
       /* UIView.animate(withDuration: 0.5, animations: {
            self.confirmationView.alpha = 1
        }) { [self] _ in
            cardCollection.isUserInteractionEnabled = false
           cardTable.isUserInteractionEnabled = false
            confirmationView.isHidden = false
            continueButton.isUserInteractionEnabled = false
        }*/
        let alert = UIAlertController(
            title: "Yippeee!",
            message: "Card Request Successful.Welcome to tomorrow",
            preferredStyle: UIAlertController.Style.alert
        )
        let action = UIAlertAction(title: "REFER YOUR FRIENDS & EARN", style: .default, handler: nil)
        action.setValue(UIColor.init(red: 32/255, green: 209/255, blue: 35/255, alpha: 1), forKey: "titleTextColor")
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismissPopUp(){
        UIView.animate(withDuration: 1, animations: {
            self.confirmationView.alpha = 0
        }) { [self] _ in
            confirmationView.isHidden = true
            cardCollection.isUserInteractionEnabled = true
           cardTable.isUserInteractionEnabled = true
            continueButton.isUserInteractionEnabled = true
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

extension CardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FundallCardTableViewCell", for: indexPath) as! FundallCardTableViewCell
        self.cell = cell
        cell.setUp()
        print("here is \(selectedIndex)")
        print("here2 is \(indexPath.row)")
        if indexPath.row == selectedIndex {
            cell.reloadForIndicator()
        }else{
            cell.setUp()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
       // let cell = tableView.cellForRow(at: indexPath) as! FundallCardTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        cardTable.reloadData()
       // cardCollection.reloadData()
       // cell.checked = !cell.checked
    }
    
    
}


extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FundallCardCollectionViewCell", for: indexPath) as! FundallCardCollectionViewCell
        cell.image.image = UIImage(named: "Rectangle")
        self.cell2 = cell
        if indexPath.row == selectedIndex {
            cell.image.contentMode = .scaleAspectFill
        }else{
            cell.image.contentMode = .scaleAspectFit
        }
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selectedIndex = indexPath.row
        //cardCollection.reloadData()
        self.selectedIndex = indexPath.row
      //  collectionView.deselectItem(at: indexPath, animated: true)
       let selectedCell = cardCollection.cellForItem(at: indexPath)  as? FundallCardCollectionViewCell
        cardCollection.bringSubviewToFront(selectedCell!)
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
            selectedCell?.transform = CGAffineTransform(scaleX: 1.2, y: 2)
        })
        cardTable.reloadData()
        //cardCollection.reloadData()
    }
    
   func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let unselectedCell = cardCollection.cellForItem(at: indexPath)  as? FundallCardCollectionViewCell
           UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
               unselectedCell?.transform = .identity
           })
    self.selectedIndex = indexPath.row
    cardTable.reloadData()
    }
}
