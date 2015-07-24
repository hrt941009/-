////
////  main.swift
////  test
////
////  Created by henyep on 15/6/23.
////  Copyright (c) 2015年 com. All rights reserved.
////
//
import Foundation
//
//class Person{
//    let name:String
//    init(name:String){
//        self.name=name
//    }
//    var apartment:Apartment?
//    deinit{
//        println("\(name) is being deinitialized")
//    }
//}
//
//class Apartment {
//    let number:Int
//    init(number:Int){
//        self.number=number
//    }
//    weak var tenat:Person?
//    deinit{
//        println("Appatment #\(number) is being deinitlized")
//    }
//}
//
//var john:Person?
//var number74:Apartment?
//
//john=Person(name: "john Apartment")
//number74=Apartment(number: 74)
//
//john!.apartment=number74
//number74!.tenat=john
////john=nil
////number74=nil
//
//
//class Customer {
//    let name:String
//    var card:CreditCard?
//    init(name:String){
//        self.name=name
//    }
//    deinit{
//        println("\(name) is being deinitialized")
//    }
//}
//
//class CreditCard {
//    let number:Int
//    unowned let customer:Customer
//    init(number:Int,customer:Customer){
//        self.number=number
//        self.customer=customer
//    }
//    deinit{
//        println("card #\(number) is being deinitialized)")
//    }
//}
//
//var jack:Customer?
//
//jack=Customer(name: "jack")
//jack!.card=CreditCard(number: 13746521475, customer: jack!)
//
////jack=nil
//
//
//class HTMLElement {
//    let name:String
//    let text:String?
//    
//    lazy var asHTML:()->String={
//        [unowned self] in
//        if let text=self.text{
//            return "<\(self.name)>\(text)</\(self.name)>"
//        }else
//        {
//            return "<\(self.name)/>"
//        }
//    }
//    init(name:String,text:String?=nil){
//        self.name=name
//        self.text=text!
//    }
//    deinit{
//        println("\(name) is being deinitialized")
//    }
//}
//
//var paragraph:HTMLElement?=HTMLElement(name: "p", text: "hello world")
//
//
//println(paragraph!.asHTML())
//
//paragraph=nil
//

///可选链调用属性
let jack=Person1()
if let roomcount=jack.residence?.numberofRooms{
    println("1")
}else{
    println("0")
}

///可选链调用方法
if (jack.residence?.printNumberOfRooms() != nil){
    println("1")
}else {
    println("0")
}

///可选链调用下标脚本
if let firstRoomName=jack.residence?[0].name{
    println(1)
}else{
    println(0)
}


let jackHouse=Residence()
jackHouse.rooms.append(Room(name: "living Room"))
jackHouse.rooms.append(Room(name: "Kitchen"))
jack.residence=jackHouse

if let firstRoomName=jack.residence?[0].name{
    println(1)
}else{
    println(0)
}

//多层链接
if let jackStreet=jack.residence?.address?.street{
    println(1)
}else{
    println(0)
}

let jackAddress=Address()
jackAddress.buildingName="The larches"
jackAddress.street="Laurel Street"
jack.residence!.address=jackAddress

if let jackStreet=jack.residence?.address?.street{
    println("jack's street is \(jackStreet)")
}else{
    println(0)
}

//可选返回值方法
if let buildingIdentifier = jack.residence?.address?.buildingIdentifier(){
    println("jack's buildingIdentifier is \(buildingIdentifier)")
}


