//
//  ViewController.swift
//  GetStockPirce
//
//  Created by laputer on 12/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stocks: [Stock] = [Stock]()
    var indexSelected = 0
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllValue()
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let stock = stocks[indexPath.row]
        cell.textLabel?.text = "\(stock.companyName) (\(stock.companySymbol)) : \(stock.stockPrice) $"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        indexSelected = indexPath.row
        performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueDetails") {
            let destVC = segue.destination as! DetailsViewController
            let selectedStock = stocks[indexSelected]
            destVC.symbol = selectedStock.companySymbol
            print(selectedStock.companySymbol)
        }
    }
    
    func getAllValue(){
        let url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"
        
        SwiftSpinner.show("Getting Stock Values")
        
        AF.request(url).responseJSON { responseData in
            //print(responseData)
            SwiftSpinner.hide()
            
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            
            guard let stockJSONArray = JSON(responseData.data!).array else { return }
            
            self.stocks = [Stock]()
            for stockJSON in stockJSONArray {
                let stock = Stock()
                stock.companyName = stockJSON["CompanyName"].stringValue
                stock.companySymbol = stockJSON["Symbol"].stringValue
                stock.stockPrice = stockJSON["Price"].floatValue
                
                self.stocks.append(stock)
            }
            self.tblView.reloadData()
        }
    }
    

}

