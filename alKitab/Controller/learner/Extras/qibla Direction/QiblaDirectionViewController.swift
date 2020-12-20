//
//  QiblaDirectionViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 13/11/2020.
//

import UIKit
import CoreLocation

class QiblaDirectionViewController: UIViewController,CLLocationManagerDelegate {

    let canvasView = CanvasView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvasView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.width)
        canvasView.center = view.center
        canvasView.backgroundColor = .clear
        view.addSubview(canvasView)

        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    

}
extension QiblaDirectionViewController{
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let angle = newHeading.trueHeading * .pi / 180
        UIView.animate(withDuration: 0.5) {
            self.canvasView.transform = CGAffineTransform(rotationAngle: -CGFloat(angle))
        }
    }
    
}
