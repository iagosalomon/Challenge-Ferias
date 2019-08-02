//
//  HistoricoCell.swift
//  Habitos app
//
//  Created by iago salomon on 02/08/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit

class HistoricoCell: UITableViewCell {
    @IBOutlet weak var nomeHabito: UILabel!
    @IBOutlet weak var dataHabito: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
