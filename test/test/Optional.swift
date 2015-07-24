//
//  Optional.swift
//  test
//
//  Created by henyep on 15/6/24.
//  Copyright (c) 2015年 com. All rights reserved.
//

import Foundation


class Person1 {
    var residence:Residence?
}

class Residence {
    var rooms=[Room]()
    var numberofRooms:Int{
        return rooms.count
    }
    subscript(i:Int)->Room{
        return rooms[i]
    }
    func printNumberOfRooms(){
        println("The number of rooms is \(numberofRooms)")
    }
    
    var address:Address?
}

class Room {
    let name:String
    init(name:String){self.name=name}
}

class Address {
    var buildingName:String?
    var buildingNumber:String?
    var street:String?
    func buildingIdentifier()->String?{
        if (buildingName != nil) {
            return buildingName
        }else if (buildingNumber != nil){
            return buildingNumber
        }else{
            return nil
        }
    }
}



