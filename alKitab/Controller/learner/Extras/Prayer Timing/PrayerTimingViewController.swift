//
//  PrayerTimingViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 12/11/2020.
//

import UIKit
import Adhan
import CoreLocation

class PrayerTimingViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var fajrView: UIView!
    @IBOutlet weak var sunRiseView: UIView!
    @IBOutlet weak var dhuhrView: UIView!
    @IBOutlet weak var asrView: UIView!
    @IBOutlet weak var maghribView: UIView!
    @IBOutlet weak var ishaView: UIView!
    
    @IBOutlet weak var fajrLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var dhuhrLabel: UILabel!
    @IBOutlet weak var asrLabel: UILabel!
    @IBOutlet weak var maghribLabel: UILabel!
    @IBOutlet weak var ishaLabel: UILabel!
    
    @IBOutlet weak var todayDate: UILabel!
    
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maketheViewShadow(view: fajrView)
        maketheViewShadow(view: sunRiseView)
        maketheViewShadow(view: dhuhrView)
        maketheViewShadow(view: asrView)
        maketheViewShadow(view: maghribView)
        maketheViewShadow(view: ishaView)
        
        
        checkLocationServices()
        
    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    // MARK:-                                   SETUP LOCATION MANAGER
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    // MARK:-                                   CHECK LOCATION SERVICES
    
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled() {
            //setup our location manager
            setupLocationManager()
            checkLocationAurtherization()
        }
        else{
            //show alert letting the user know they have to turn it on
            requestToOpenLocation()
            
        }
    }
    
    // MARK:-                              CHECK LOCATION AUTHERIZATION
    
    func checkLocationAurtherization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            // do our stuff when the permission is given
            var currentLoc:CLLocation!
            currentLoc = locationManager.location
            getAddress(Lat:currentLoc.coordinate.latitude,Long:currentLoc.coordinate.longitude)
            findPrayerTiming(Lat: currentLoc.coordinate.latitude, Long: currentLoc.coordinate.longitude)
            
            
            break
        case .denied:
            requestToOpenLocation()
            //show alert instruction them how to turn on the location
            
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        case .authorizedAlways:
            break
        case .restricted:
            //show them alert letting them what's up
            break
        @unknown default:
            break
            
        }
    }
    
    // MARK:-                                 REQUEST TO OPEN LOCATION
    
    func requestToOpenLocation(){
        let alert = UIAlertController(title: "Need Authorization", message: "This Module is unusable if you don't authorize this app to use your location!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {(cAlertAction) in
            self.dismiss(animated: false, completion: nil)
        })
        alert.addAction(cancelAction)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK:-                            MAKE THE VIEW SHADOW
    
    func maketheViewShadow(view:UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
    }
    
    // MARK:-                             FIND THE PRAYER TIMING
    
    func findPrayerTiming(Lat:Double,Long:Double){
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: Lat, longitude: Long)
        print("latitiude \(Lat) longitude \(Long)")
        var params = CalculationMethod.moonsightingCommittee.params
        params.madhab = .hanafi
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            //formatter.timeZone = TimeZone(identifier: "America/New_York")!
            
           
            fajrLabel.text = formatter.string(from: prayers.fajr)
            sunRiseLabel.text = formatter.string(from: prayers.sunrise)
            dhuhrLabel.text = formatter.string(from: prayers.dhuhr)
            asrLabel.text = formatter.string(from: prayers.asr)
            maghribLabel.text = formatter.string(from: prayers.maghrib)
            ishaLabel.text = formatter.string(from: prayers.isha)
            
            // find date
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "dd/MM/yyyy"
            let result = format.string(from: date)
            todayDate.text = ("Date: \(result)")
            
//            print("fajr \(formatter.string(from: prayers.fajr))")
//            print("sunrise \(formatter.string(from: prayers.sunrise))")
//            print("dhuhr \(formatter.string(from: prayers.dhuhr))")
//            print("asr \(formatter.string(from: prayers.asr))")
//            print("maghrib \(formatter.string(from: prayers.maghrib))")
//            print("isha \(formatter.string(from: prayers.isha))")
        }
    }
    
}


// MARK:-                               EXTENSIONS

extension PrayerTimingViewController{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // when the user first time allow the location manager
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        getAddress(Lat:locValue.latitude,Long:locValue.longitude)
        findPrayerTiming(Lat: locValue.latitude, Long: locValue.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAurtherization()
    }
    
    func getAddress(Lat:Double,Long:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: Lat, longitude: Long)
        //selectedLat and selectedLon are double values set by the app in a previous process
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary ?? "")
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                //print(locationName)
            }
            
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                //print(street)
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                self.cityLabel.text = city as String
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                //print(zip)
            }
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                self.countryLabel.text = country as String
            }
            
        })
        
        
    }
}
