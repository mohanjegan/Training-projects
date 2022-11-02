//
//  ViewController.swift
//  MyCalenderDemo
//
//  Created by Mohan on 29/10/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.allowsMultipleSelection = true
        let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        if let rgDates = rgDates {
            print(rgDates)
            for d in rgDates{
                calendar.select(d)
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        // Disable saved range of dates
        //        let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        //        if let rgDates = rgDates {
        //            if rgDates.contains(date){
        //                cell.isUserInteractionEnabled = false
        //            }}else{
        //                cell.isUserInteractionEnabled = true
        //            }
        return cell
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    
    //multiple date selection 1
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        //        if firstDate == nil {
        //            firstDate = date
        //            datesRange = [firstDate!]
        //
        //            print("datesRange contains: \(datesRange!)")
        //            let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        //            if let rgDates = rgDates {
        //                print(rgDates)
        //                for d in rgDates{
        //                    calendar.select(d)
        //                }
        //            }
        //            return
        //        }
        //
        //        // only first date is selected:
        //        if firstDate != nil && lastDate == nil {
        //            // handle the case of if the last date is less than the first date:
        //            if date <= firstDate! {
        //                calendar.deselect(firstDate!)
        //                firstDate = date
        //                datesRange = [firstDate!]
        //
        //                print("datesRange contains: \(datesRange!)")
        //                let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        //                if let rgDates = rgDates {
        //                    print(rgDates)
        //                    for d in rgDates{
        //                        calendar.select(d)
        //                    }
        //                }
        //                return
        //            }
        //
        //            let range = datesRange(from: firstDate!, to: date)
        //
        //            lastDate = range.last
        //            if range.count <= 5{
        //                for d in range {
        //                    calendar.select(d)
        //                }
        //
        //                datesRange = range
        //
        //                print("datesRange contains: \(datesRange!)")
        //                let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        //                if let rgDates = rgDates {
        //                    print(rgDates)
        //                    for d in rgDates{
        //                        calendar.select(d)
        //                    }
        //                }
        //
        //                return
        //            }
        //            else{
        //                for d in calendar.selectedDates {
        //                    calendar.deselect(d)
        //                }
        //                print("More than five days selected")
        //
        //                lastDate = nil
        //                firstDate = nil
        //
        //                datesRange = []
        //
        //                print("datesRange contains: \(datesRange!)")
        //                let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        //                if let rgDates = rgDates {
        //                    print(rgDates)
        //                    for d in rgDates{
        //                        calendar.select(d)
        //                    }
        //                }
        //            }
        //        }
        //
        //        // both are selected:
        //        if firstDate != nil && lastDate != nil {
        //
        //            for d in calendar.selectedDates {
        //                calendar.deselect(d)
        //            }
        //
        //            lastDate = nil
        //            firstDate = nil
        //
        //            datesRange = []
        //
        //            print("datesRange contains: \(datesRange!)")
        //            let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        //            if let rgDates = rgDates {
        //                print(rgDates)
        //                for d in rgDates{
        //                    calendar.select(d)
        //                }
        //            }
        //        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //        if firstDate != nil && lastDate != nil {
        //            for d in datesRange! {
        //                calendar.deselect(d)
        //            }
        //
        //            lastDate = nil
        //            firstDate = nil
        //
        //            datesRange = []
        //            print("datesRange contains: \(datesRange!)")
        //        }
        
        if calendar.selectedDates.contains(date){
            calendar.deselect(date)
        }
        
    }
    @IBAction func sample(_ sender: Any) {
        //        if firstDate != nil && lastDate != nil{
        //            print("Saving")
        //            let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        //            if let rgDates = rgDates, var datesRange = datesRange{
        //            var AllDates = datesRange + rgDates
        //            let registeredDates: Void = UserDefaults.standard.set(datesRange, forKey: "myDates")
        //            print(registeredDates)
        //            }} else if {
        let rgDates = UserDefaults.standard.object(forKey: "myDates") as? [Date]
        if let rgDates = rgDates{
            if rgDates != calendar.selectedDates{
                datesRange = calendar.selectedDates
                let registeredDates: Void = UserDefaults.standard.set(datesRange, forKey: "myDates")
                print(registeredDates)
            }
        } else {
            print("Can't save")
        }
        
    }
    
    @IBAction func Delete(_ sender: Any) {
        
        for d in calendar.selectedDates {
            calendar.deselect(d)
        }
        
        lastDate = nil
        firstDate = nil
        
        datesRange = []
        let registeredDates: Void = UserDefaults.standard.set(datesRange, forKey: "myDates")
        print(registeredDates)
    }
    
}
//multiple date selection 2
//    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        performDateDeselect(calendar, date: date)
//        return true
//    }
//
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        performDateSelection(calendar)
//    }
//
//    private func performDateDeselect(_ calendar: FSCalendar, date: Date) {
//        let sorted = calendar.selectedDates.sorted { $0 < $1 }
//        if let index = sorted.firstIndex(of: date)  {
//            let deselectDates = Array(sorted[index...])
//            calendar.deselectDates(deselectDates)
//        }
//    }
//
//    private func performDateSelection(_ calendar: FSCalendar) {
//        let sorted = calendar.selectedDates.sorted { $0 < $1 }
//        if let firstDate = sorted.first, let lastDate = sorted.last {
//            let ranges = datesRange(from: firstDate, to: lastDate)
//            calendar.selectDates(ranges)
//        }
//    }
//
//    func datesRange(from: Date, to: Date) -> [Date] {
//        if from > to { return [Date]() }
//        var tempDate = from
//        var array = [tempDate]
//        while tempDate < to {
//            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
//            array.append(tempDate)
//        }
//        return array
//    }
//
//    private func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE MMM-dd-YYYY"
//        let string = formatter.string(from: date)
//        print("\(string)")
//    }
////Set Minimum Date
//func minimumDate(for calendar: FSCalendar) -> Date {
//    return Date()
//}
//
////Set maximum Date
//func maximumDate(for calendar: FSCalendar) -> Date {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "YYYY-MM-dd"
//    return dateFormatter.date(from: "2023-01-01") ?? Date()
//}
//    //Title for date
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY-MM-dd"
//        let string = formatter.string(from: date)
//        if string == "2022-11-01"{
//        return "title"
//        }
//        let getDate = DateFormatter()
//        getDate.dateFormat = "dd"
//        let dateString = getDate.string(from: date)
//        return dateString
//    }
//    //Subtitle for date
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY-MM-dd"
//        let string = formatter.string(from: date)
//        if string == "2022-11-01"{
//        return "subtitle"
//        }
//        return ""
//    }
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY-MM-dd"
//        let string = formatter.string(from: date)
//        if string == "2022-11-05"{
//        return true
//        }
//        return false
//    }

