//
//  ResultViewController.swift
//  MyGoogleMaps
//
//  Created by Mohan on 01/10/22.
//

import UIKit
import CoreLocation
protocol ResultViewControllerDelegate: AnyObject {
    func didTapPlace(with coordinates: CLLocationCoordinate2D)
}

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: ResultViewControllerDelegate?
    
    private var places: [Place] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate  = self
        tableView.dataSource = self
        //view.backgroundColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func update(with places: [Place]){
        self.tableView.isHidden = false
        self.places = places
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
        let place = places[indexPath.row]
        GooglePlacesManager.shared.resolveLocation(for: place) {[weak self] (result) in
            switch result{
                case .success(let coordinate):
                    DispatchQueue.main.async {
                        self?.delegate?.didTapPlace(with: coordinate)
                    }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
