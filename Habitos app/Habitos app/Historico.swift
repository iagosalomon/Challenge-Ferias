//
//  Historico.swift
//  Habitos app
//
//  Created by iago salomon on 01/08/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit

class Historico: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var listaMedalhas: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
