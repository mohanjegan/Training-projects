//
//  ViewController.swift
//  CoreData-TodoList
//
//  Created by Mohan on 12/09/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    private var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        home()
       
    }

    func home(){
        title = "CoreData-ToDoList"
        view.addSubview(tableView)
        getAllitems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Enter New Item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler:{ [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
                return
            }
            
            self?.createitem(name: text)
        }))
        
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler:{ _ in
            
            let alert = UIAlertController(title: "Edit Item", message: "Edit Your Item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler:{ [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else{
                    return
                }
                
                self?.updateitem(item: item, newName: newName)
            }))
            
            self.present(alert, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{ [weak self] _ in
            self?.deleteitem(item: item)
        }))
        
        present(sheet, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            tableView.deselectRow(at: indexPath, animated: true)
            let item = models[indexPath.row]
            
            let sheet = UIAlertController(title: "Confirm Delete", message: nil, preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            sheet.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler:{ [weak self] _ in
                self?.deleteitem(item: item)
            }))
            
            present(sheet, animated: true)
            
            tableView.endUpdates()
            
            
        }
    }
    
    
    
    
    
    
    
    
    //CoreData
//    func getAllitems() {
//
//        do {
//             models = try context.fetch(ToDoListItem.fetchRequest())
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//        catch  {
//            //error
//        }
//    }
    
    func getAllitems() {

        do {
            let request = ToDoListItem.fetchRequest() as NSFetchRequest<ToDoListItem>
            // filtering
//            let pred = NSPredicate(format: "name CONTAINS 'pack'")
//            request.predicate = pred
            //sorting
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
             models = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch  {
            //error
        }
    }
    
    func createitem(name: String) {
        
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllitems()
        } catch  {
            
        }
    }
    
    func deleteitem(item: ToDoListItem) {
        
        context.delete(item)
        do {
            try context.save()
            getAllitems()
        } catch  {
            
        }
        
    }
    
    func updateitem(item: ToDoListItem, newName: String) {
        
        item.name = newName
        do {
            try context.save()
            getAllitems()
        } catch  {
            
        }
        
        
    }
}

