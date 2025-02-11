//
//  POIsTableViewController.swift
//  Grail Diary Part 1
//
//  Created by Dillon P on 7/29/19.
//  Copyright © 2019 Dillon P. All rights reserved.
//

import UIKit

class POIsTableViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var pois: [POI] = []
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPOIModalSegue" {
            if let addPOIVC = segue.destination as? AddPOIViewController {
                addPOIVC.delegate = self
            }
        } else if segue.identifier == "ShowPOIDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow, let detailPOIVC = segue.destination as? POIDetailViewController {
                let poi = pois[indexPath.row]
                detailPOIVC.poi = poi
            }
        }
    }
}

    // MARK: - Protocols

    extension POIsTableViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pois.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "POICell", for: indexPath) as? POITableViewCell else { return UITableViewCell() }
            
            let poi = pois[indexPath.row]
            cell.poi = poi
            
            return cell
        }
    }

    extension POIsTableViewController: AddPOIDelegate {
        func poiWasAdded(_ poi: POI) {
            pois.append(poi)
            dismiss(animated: true, completion: nil)
            tableView.reloadData()
        }
    }
