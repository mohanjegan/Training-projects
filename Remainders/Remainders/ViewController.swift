//
//  ViewController.swift
//  Remainders
//
//  Created by Mohan on 07/10/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var table: UITableView!
    var models = [Remainder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource =  self
        getAllitems()
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapAdd(){
        //show add vc
        guard  let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        vc.title = "New Remainder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                self.createitem(title: title, message: body, date: date)
//                let new = MyRemainders(title: title, date: date, identifier: "id_\(title)")
//                self.models.append(new)
//                self.table.reloadData()
                let content = UNMutableNotificationContent()
            content.title = title
            content.body  = body
            content.sound = .default
            
                let targetDate = date
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
            let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                if error != nil{
                    print("error occured")
                }
            })
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didTapTest(){
        //Test Notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success{
                //schedule test
                self.scheduleTest()
            }
            else if error != nil{
                print("Error Occured")
            }
        })
    }
    func scheduleTest(){
            let content = UNMutableNotificationContent()
        content.title = "test"
        content.body  = "test body,test body, test body, test body, test body, test body"
        content.sound = .default
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil{
                print("error occured")
            }
        })
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = models[indexPath.row]
            deleteitem(item: item)
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date!)
        return cell
    }
}

//core data

extension ViewController{
    func getAllitems() {
      
        do {
             models = try context.fetch(Remainder.fetchRequest())
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        catch  {
            //error
        }
    }
    
    func createitem(title: String, message: String, date: Date) {
        
        let newItem = Remainder(context: context)
        newItem.title = title
        newItem.message = message
        newItem.date = date
        
        do {
            try context.save()
            getAllitems()
        } catch  {
            
        }
    }
    
    func deleteitem(item: Remainder) {
        
        context.delete(item)
        do {
            try context.save()
            getAllitems()
        } catch  {
            //error
        }
        
    }
    
    func updateitem(item: Remainder, newTitle: String, newMessage: String, newDate: Date) {
        
        item.title = newTitle
        item.message = newMessage
        item.date = newDate
        do {
            try context.save()
            getAllitems()
        } catch  {
            //error
        }
        
        
    }
}

//struct MyRemainders {
//    let title: String
//    let date: Date
//    let identifier: String
//}
