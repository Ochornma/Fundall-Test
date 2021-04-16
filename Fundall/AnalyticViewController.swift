//
//  AnalyticViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import UIKit
import Charts

class AnalyticViewController: UIViewController {
    
    @IBOutlet weak var analyticsCollection: UICollectionView!
    @IBOutlet weak var analyticsTableView: UITableView!
    @IBOutlet weak var analyticsView: UIView!
    @IBOutlet weak var analyticsChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsCollection.delegate = self
        analyticsCollection.dataSource = self
        analyticsTableView.delegate = self
        analyticsTableView.dataSource = self
        analyticsView.layer.cornerRadius = 20
        let avg = ChartLimitLine(limit: 10.0, label: "Average")
        analyticsChart.rightAxis.addLimitLine(avg)
        setChart()
        // Do any additional setup after loading the view.
    }
    
    func setChart(){
        let months = ["May 1", "May 2", "May 3", "May 4", "May 5", "May 6"]
        let points = [20.0, 4.0, 3.0, 6.0, 12.0, 16.0]
        let scans = [2.0, 4.0, 3.0, 6.0, 2.0, 4.0]
        let points2 = [20.0, 4.0, 3.0, 6.0, 12.0, 16.0]
        let scans2 = [2.0, 4.0, 3.0, 6.0, 2.0, 4.0]
        let points3 = [20.0, 4.0, 3.0, 6.0, 12.0, 16.0]
        let scans3 = [2.0, 4.0, 3.0, 6.0, 2.0, 4.0]
        analyticsChart.xAxis.drawGridLinesEnabled = false
        analyticsChart.xAxis.drawAxisLineEnabled = false
        analyticsChart.leftAxis.drawAxisLineEnabled = false
        analyticsChart.rightAxis.drawAxisLineEnabled = false
        
        analyticsChart.setBarChartData(xValues: months, yValues1: scans, yValues2: scans, yValues3: scans2, yValues4: scans, yValues5: scans3, yValues6: scans)
        
    }
    
    @IBAction func dismiss() {
        self.dismiss(animated: true)
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

extension AnalyticViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalyticsCollectionViewCell", for: indexPath) as! AnalyticsCollectionViewCell
        cell.trackView.layer.cornerRadius = (cell.trackView.frame.height)/2
        return cell
    }
    
    
}

extension AnalyticViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnalyticsTableViewCell", for: indexPath) as! AnalyticsTableViewCell
        
        return cell
    }
    
    
    
    
}


