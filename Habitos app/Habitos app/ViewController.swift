//
//  ViewController.swift
//  Habitos app
//
//  Created by iago salomon on 12/07/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    var contex : NSManagedObjectContext?
    var habitos : [Habito] = [Habito]()
    
    
    func fetchHabito(){
        var request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habito")
        request.returnsObjectsAsFaults = false
        if let contex = contex{
            do {
                let result = try contex.fetch(request)
                habitos = []
                for data in result as! [NSManagedObject]{
                    habitos.append(data as! Habito)
                    print(data as! Habito)
                    print("entrou")
                }
            }catch{
                fatalError("Entity error")
            }
        }
    
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if habitos.count == 0{
            return 1
        }
        return habitos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var aCelula:UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "umaCelula")
        if habitos.count == 0{
            let aCelula:HistoricoCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HistoricoCell
            aCelula.nomeHabito.text = "Quabdo completar seu habito"
            aCelula.dataHabito.text = "Ele aparecera aqui"
            
            return aCelula
        }
        
        let aCelula:HistoricoCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HistoricoCell
        aCelula.nomeHabito.text = habitos[indexPath.row].nome_habito
        var data = habitos[indexPath.row].data_completo
        aCelula.dataHabito.text = "Habito completo em : \(data!)"
        
        return aCelula
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        fetchHabito()
        tableView.delegate = self
        tableView.dataSource = self
       
        // Do any additional setup after loading the view.
    }


}

