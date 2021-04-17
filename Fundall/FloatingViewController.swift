//
//  FloatingViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 17/04/2021.
//

import UIKit

class FloatingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var cardCollection: UICollectionView!
    @IBOutlet weak var cardTable: UITableView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTable.delegate = self
        cardTable.dataSource = self
        cardCollection.delegate = self
        cardCollection.dataSource = self
        self.view.layer.cornerRadius = 20
        pageControl.numberOfPages = 5

        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
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

extension FloatingViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FundallCardCollectionViewCell", for: indexPath) as! FundallCardCollectionViewCell
         return cell
    }
    
}

extension FloatingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FloatingTableViewCell", for: indexPath) as! FloatingTableViewCell
        return cell
    }
    
    
}
