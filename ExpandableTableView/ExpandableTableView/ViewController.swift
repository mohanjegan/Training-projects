//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by Mohan on 01/11/22.
//

import UIKit

class section{
    let title:String
    let options: [String]
    var isOpened: Bool = false
    
    init(title: String,
         options: [String],
         isOpened: Bool = false)
    {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [section]()
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = [
            section(title: "Section 1", options: [1,2,3].compactMap({ return "cell \($0)" })),
            section(title: "Section 2", options: [1,2,3].compactMap({ return "cell \($0)" })),
            section(title: "Section 3", options: [1,2,3].compactMap({ return "cell \($0)" })),
            section(title: "Section 4", options: [1,2,3].compactMap({ return "cell \($0)" }))
        ]
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let section = sections[section]
        if section.isOpened{
            return section.options.count + 1
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = sections[indexPath.section].title
            cell.backgroundColor = .systemBlue
        }
        else{
            cell.textLabel?.text = sections[indexPath.section].options[indexPath.row - 1]
            cell.backgroundColor = .systemTeal
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        }
        else{
            print(sections[indexPath.section].options[indexPath.row - 1])
        }
    }
}

