//
//  Habito+CoreDataProperties.swift
//  Habitos app
//
//  Created by iago salomon on 02/08/19.
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
    @NSManaged public var data_completo: String?

}
