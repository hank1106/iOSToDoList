//
//  Event.swift
//  CalendarTable
//
//  Created by Zihan Zhang on 3/8/16.
//  Copyright © 2016 Zihan Zhang. All rights reserved.
//

import Foundation
import CoreData


class Event : NSObject {
    
    var title: String
    
    init(withTitle t: String){
        title = t
    }
    
    init(withCoder coder:NSCoder){
        title = coder.decodeObject(forKey: "title") as! String
    }
    
    func encodeWithCoder(_ coder:NSCoder){
        coder.encode(title,forKey: "title")
        
    }

}
