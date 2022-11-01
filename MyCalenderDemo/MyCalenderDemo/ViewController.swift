//
//  ViewController.swift
//  MyCalenderDemo
//
//  Created by Mohan on 29/10/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calender: FSCalendar!
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]?
    var disableDates = ["2022-11-05","2022-11-10","2022-11-15"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calender.delegate = self
        calender.dataSource = self
        calender.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        calender.allowsMultipleSelection = true
    }
    //    private func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "EEEE MMM-dd-YYYY"
    //        let string = formatter.string(from: date)
    //        print("\(string)")
    //    }
    //Set Minimum Date
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    //Set maximum Date
    func maximumDate(for calendar: FSCalendar) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from: "2023-01-01") ?? Date()
    }
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
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let calendarDate = formatter.string(from: date)
        
        
        // Disable date is string Array of Dates
        if disableDates.contains(calendarDate){
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = .darkGray
        }else{
            cell.isUserInteractionEnabled = true
        }
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
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                
                print("datesRange contains: \(datesRange!)")
                
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            
            lastDate = range.last
            if range.count <= 5{
            for d in range {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                let calendarDate = formatter.string(from: d)
                if disableDates.contains(calendarDate){
                    print("contains already booked date")
                    for d in datesRange! {
                        calendar.deselect(d)
                    }
                    return
                }
                calendar.select(d)
            }
            
            datesRange = range
            
            print("datesRange contains: \(datesRange!)")
            
            return
            }
            else{
                for d in calendar.selectedDates {
                    calendar.deselect(d)
                }
                print("More than five days selected")
                
                lastDate = nil
                firstDate = nil
                
                datesRange = []
                
                print("datesRange contains: \(datesRange!)")
            }
        }
        
        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            
            print("datesRange contains: \(datesRange!)")
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:
        
        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in datesRange! {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            print("datesRange contains: \(datesRange!)")
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
}

