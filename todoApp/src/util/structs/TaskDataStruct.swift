//
//  TaskDataStruct.swift
//  todoApp
//
//  Created by RIVER on 2019/05/23.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct TaskDataStruct {
    var name: String
    var date: String
    var time: String?
    var completion: Bool
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as! String
        self.date = dictionary["date"] as! String
        self.time = dictionary["time"] as? String
        self.completion = dictionary["completion"] as! Bool
    }
    
}
