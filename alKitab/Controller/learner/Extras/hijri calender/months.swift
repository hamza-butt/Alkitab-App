//
//  months.swift
//  alKitab
//
//  Created by Hamza Butt on 15/11/2020.
//

import Foundation


func todayHijriDate() -> Date{
    
    let dateFor = DateFormatter()
    
    let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
    dateFor.locale = Locale.init(identifier: "en") // or "en" as you want to show numbers
    
    dateFor.calendar = hijriCalendar
    
    dateFor.dateFormat = "dd/MM/yyyy"
    let dateInString = dateFor.string(from: Date())
    
    //convert string date into date
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let date = dateFormatter.date(from: dateInString)
    return date!
}


func assignYear(date:Date)->Int{
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    let year = components.year
    return year!
}

func assignDate(date:Date)->Int{
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    let day = components.day
    return day!
}

func assignMonth(date:Date)->String{
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    let month = components.month
    switch month {
    case 1:
        return "Muharram"
    case 2:
        return "Safar"
    case 3:
        return "Rabi-ul-Awal"
    case 4:
        return "Rabi-ul-Sani"
    case 5:
        return "Jumada-Al-Awwal"
    case 6:
        return "Jumada-Al-Sani"
    case 7:
        return "Rajab"
    case 8:
        return "Shaban"
    case 9:
        return "Ramadan"
    case 10:
        return "Shawwal"
    case 11:
        return "Dhul-Qadah"
    default:
        return "Dhul-Hijjah"
    }
}

func assignMonth(month:Int)->String{
    switch month {
    case 1:
        return "Muharram"
    case 2:
        return "Safar"
    case 3:
        return "Rabi-ul-Awal"
    case 4:
        return "Rabi-ul-Sani"
    case 5:
        return "Jumada-Al-Awwal"
    case 6:
        return "Jumada-Al-Sani"
    case 7:
        return "Rajab"
    case 8:
        return "Shaban"
    case 9:
        return "Ramadan"
    case 10:
        return "Shawwal"
    case 11:
        return "Dhul-Qadah"
    default:
        return "Dhul-Hijjah"
    }
}

func convertDateIntoHijriDate(day:String,month:String,year:String)->String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    let GregorianDate = dateFormatter.date(from: "\(day)-\(month)-\(year)")
    let islamic = NSCalendar(identifier: NSCalendar.Identifier.islamicUmmAlQura)
    let components = islamic?.components(NSCalendar.Unit(rawValue: UInt.max), from: GregorianDate!)
    
    
    let day = components!.day
    let month = assignMonth(month: components!.month!)
    let year = components!.year
    return("\(day!) \(month) \(year!)")
    
     
}

