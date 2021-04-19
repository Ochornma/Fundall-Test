//
//  HomeViewController.swift
//  Fundall
//
//  Created by Promise Ochornma on 15/04/2021.
//

import UIKit
import RxSwift
import FloatingPanel


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FloatingPanelControllerDelegate {

    @IBOutlet weak var fundTable: UITableView!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var avartar: UIImageView!

    let constant = Constants()
    let defaults = UserDefaults.standard
    var soft = SoftViews()
    var naira = "₦"
    private var disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createfloatingPanel()
        fundTable.delegate = self
        fundTable.dataSource = self
        spentLabel.text = "\(naira)\(defaults.string(forKey: "spent") ?? "")"
        incomeLabel.text = "\(naira)\(defaults.string(forKey: "income") ?? " ")"
        totalLabel.text = "\(naira)\(defaults.string(forKey: "total") ?? " ")"
        let urlString = defaults.string(forKey: "avatar")
        if urlString != nil && !(urlString?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            let url = URL(string: urlString ?? " ")
            avartar.kf.setImage(with: url)
        }
        avartar.layer.cornerRadius = avartar.frame.height/2
        getProfile()
      
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fundacell", for: indexPath) as! FundallHomeTableViewCell
        if indexPath.row % 2 != 0 {
            cell.tableCard.backgroundColor = .clear
        }
        cell.setup()
        return cell
    }
    
    @IBAction func dismissToSignUp(){
        self.dismiss(animated: true)
    }
    
    @IBAction func requestCard(){
        constant.presentVC(presenter: self, identifier: "CardViewController")
    }
    
    @IBAction func checkAnalytics(){
        
        constant.presentVC(presenter: self, identifier: "AnalyticViewController")
    }
    
    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return FloatingPanelStocksLayout()
    }
    
    func createfloatingPanel() {
        let float = FloatingPanelController()
        float.delegate = self
        guard let vc = storyboard?.instantiateViewController(identifier: "FloatingViewController") as? FloatingViewController? else { return  }
        float.set(contentViewController: vc)
        //add spring behaviour to the float
        float.behavior = FloatingPanelStocksBehavior()
        float.cornerRadius()
        //float.track(scrollView: (vc?.cardTable)!)
        float.addPanel(toParent: self, at: view.subviews.firstIndex(of: spentLabel) ?? -1, animated: false)
        //self.present(float, animated: true, completion: nil)
        
    }
    
    func getProfile() {
        APIClient.shared.getProfile().observe(on: MainScheduler.instance).subscribe(onNext: {
            [self] result in
            defaults.set(result.success?.data?.email, forKey: "email")
            defaults.set(result.success?.data?.firstname, forKey: "name")
            defaults.set(result.success?.data?.avatar, forKey: "avatar")
            defaults.set(result.success?.data?.firstname, forKey: "spent")
            defaults.set(result.success?.data?.avatar, forKey: "income")
            defaults.set(result.success?.data?.totalBalance, forKey: "total")
            spentLabel.text = "\(naira)\(result.success?.data?.spent ?? " ")"
            incomeLabel.text = "\(naira)\(result.success?.data?.income ?? " ")"
            totalLabel.text = "\(naira)\(result.success?.data?.totalBalance ?? " ")"
            let urlString = result.success?.data?.avatar
            if urlString != nil && !(urlString?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
                let url = URL(string: result.success?.data?.avatar ?? "")
                avartar.kf.setImage(with: url)
            }
        
        }, onError: {
            [self] error in
            switch error{
            case ApiError.unauthenticated:
                soft.unauntenticated("", message: "Session Expired", vc: self)
            default:
                print("")
            }
        }).disposed(by: disposebag)
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

//add corner radius of the panel
extension FloatingPanelController{
    func cornerRadius() {
        let appearance = SurfaceAppearance()
        appearance.cornerCurve = .continuous
        appearance.cornerRadius = 10.0
        appearance.backgroundColor = .clear
        surfaceView.appearance = appearance
    }
}

// MARK: - FloatingPanelLayout
// set the maximum height for the floating pannel
class FloatingPanelStocksLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 56.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 262.0, edge: .bottom, referenceGuide: .safeArea),
             /* Visible + ToolView */
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}

// MARK: - FloatingPanelBehavior
class FloatingPanelStocksBehavior: FloatingPanelBehavior {
    let springDecelerationRate: CGFloat = UIScrollView.DecelerationRate.fast.rawValue
    let springResponseTime: CGFloat = 0.25
}
