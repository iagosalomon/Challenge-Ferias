//
//  Habito+CoreDataProperties.swift
//  Habitos app
//
//  Created by iago salomon on 23/07/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//
//

import Foundation
import CoreData


extension Habito {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habito> {
        return NSFetchRequest<Habito>(entityName: "Habito")
    }

    @NSManaged public var nome_habito: String?
    @NSManaged public var nome_recompensa: String?
    @NSManaged public var horario_do_alarme: NSDate?
    @NSManaged public var progresso_habito: Int16

}
