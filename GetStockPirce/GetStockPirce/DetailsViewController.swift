//
//  DetailsViewController.swift
//  GetStockPirce
//
//  Created by laputer on 12/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var symbol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllValues()
        // Do any additional setup after loading the view.
    }
    
    func getAllValues(){
        let url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/getstock?symbol=\(symbol)"
        
        AF.request(url).responseJSON { responseData in
            //print(responseData)
            //SwiftSpinner.hide()
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            
            let stockJSON = JSON(responseData.data!)
            let stock = Stock()
            stock.companyName = stockJSON["CompanyName"].stringValue
            stock.companySymbol = stockJSON["Symbol"].stringValue
            stock.stockPrice = stockJSON["Price"].floatValue
           
            self.lblName.text = "Company Name: \(stock.companyName)"
            self.lblSymbol.text = "Company Symbol: \(stock.companySymbol)"
            self.lblPrice.text = "Stock Price: \(stock.stockPrice) $"
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
