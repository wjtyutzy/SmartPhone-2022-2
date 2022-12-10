//
//  ViewController.swift
//  WeatherForecast
//
//  Created by laputer on 11/19/22.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
   
    var temp = [String]()
    var conditions = [String]()

    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var tblView: UITableView!
    
    let locationManager = CLLocationManager()
    
    var lat: CLLocationDegrees?
    var lng: CLLocationDegrees?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
    }

    
    @IBAction func getLocationAction(_ sender: Any) {
        let locationStr = "\(self.lat!),\(self.lng!)"

        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        url += locationStr
        url += "&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"

        AF.request(url).responseJSON { responseData in

            if responseData.error != nil {
                print(responseData.error!)
                return
            }

            let weatherData = JSON(responseData.data as Any)

            let forecastValues =  weatherData["locations"][locationStr]["values"]
            
            self.temp = [String]()
            self.conditions = [String]()
            
            for forecast in forecastValues {
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let forecastString = forecastJSON["conditions"].stringValue
                
                self.temp.append("\(temp)")
                self.conditions.append(forecastString)
                print(forecastString)
            }
            self.tblView.reloadData()
        }
        
        //locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        lat = location.coordinate.latitude
        lng = location.coordinate.longitude
        
        print(lat)
        print(lng)
        
    }
    
    
    
    @IBAction func getWeatherAction(_ sender: Any) {
        let cityName = txtLocation.text!

        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        url += cityName
        url += "&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"

        AF.request(url).responseJSON { responseData in

            if responseData.error != nil {
                print(responseData.error!)
                return
            }

            let weatherData = JSON(responseData.data as Any)
            let forecastValues =  weatherData["locations"][self.txtLocation.text!]["values"]

            self.temp = [String]()
            self.conditions = [String]()

            for forecast in forecastValues {
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let forecastString = forecastJSON["conditions"].stringValue
                let str = "Temperature = \(temp), \(forecastString)"
                self.temp.append("\(temp)")
                self.conditions.append(forecastString)

                print(forecastString)
            }
            self.tblView.reloadData()
        }
        
        locationManager.requestLocation()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("WeatherTableViewCell", owner: self)?.first as! WeatherTableViewCell

        cell.Temperature.text = temp[indexPath.row]
        cell.forecast.text = conditions[indexPath.row]

        return cell
    }
    
    
}

