//
//  HijriCalenderViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 15/11/2020.
//

import UIKit
import FSCalendar

class HijriCalenderViewController: UIViewController,FSCalendarDataSource,FSCalendarDelegate {

    @IBOutlet weak var todaysHijriDate: UILabel!
    @IBOutlet weak var clickedHijriDate: UILabel!
    @IBOutlet weak var selctedDateLabel: UILabel!
    var formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selctedDateLabel.isHidden = true
       
        let currentDateInHijri = todayHijriDate()
        let currentDayInHijri = assignDate(date: currentDateInHijri)
        let currentMonthInHijri = assignMonth(date: currentDateInHijri)
        let currentYearInHijri = assignYear(date: currentDateInHijri)
        
        
        todaysHijriDate.text = "\(currentDayInHijri) \(currentMonthInHijri) \(currentYearInHijri)"
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    
    



}
extension HijriCalenderViewController{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        selctedDateLabel.isHidden = false
        
        formatter.dateFormat = "dd/MM/yyyy"
        let dateInString = formatter.string(from: date)
        let dataArray = dateInString.components(separatedBy: "/")
        
        //convert dateInto
        let convertedDate = convertDateIntoHijriDate(day: dataArray[0], month: dataArray[1], year: dataArray[2])
        clickedHijriDate.text = convertedDate
        
    }
}
