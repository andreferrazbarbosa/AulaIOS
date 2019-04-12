//
//  Todo.swift
//  TodoList
//
//  Created by user151729 on 4/11/19.
//  Copyright © 2019 user151729. All rights reserved.
//

import Foundation

struct Todo : Codable{
    var task : String
    var isCompleted : Bool
    var id: Int?
    
    init(task: String){
        self.task = task
        self.isCompleted = false
    }
}
