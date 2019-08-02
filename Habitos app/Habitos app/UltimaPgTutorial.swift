//
//  UltimaPgTutorial.swift
//  Habitos app
//
//  Created by iago salomon on 15/07/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit

class UltimaPgTutorial: UIViewController {
    
    
    var mainVC: MainPage?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func ComecarJornada(_ sender: Any) {
        
        let temHabito = UserDefaults.standard.bool(forKey: "temhabito")
        
        if !temHabito{
        
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = mainStoryboardIpad.instantiateViewController(withIdentifier: "criacaodeHabito") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nav
        }else{
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nav = mainStoryboardIpad.instantiateViewController(withIdentifier: "PaginaPrincipal") as! UINavigationController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = nav
            
        }
    }
    
}
