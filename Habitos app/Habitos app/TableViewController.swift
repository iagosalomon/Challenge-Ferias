//
//  TableViewController.swift
//  Habitos app
//
//  Created by iago salomon on 01/08/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController  {

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
//    @IBOutlet weak var tableView: UITableView!
//    tableView.delegate = self
//    tableView.dataSource = self
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let aCelula:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "celulaStoryboard") as! HistoricoCell
//
//
//        return aCelula
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var aCelula:UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "umaCelula")
        
        let aCelula:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "celulaStoryboard") as! HistoricoCell
        
        return aCelula
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
