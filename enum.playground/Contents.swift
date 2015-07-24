//: Playground - noun: a place where people can play

import UIKit

enum CompassPoint{
    case North
    case South
    case East
    case West
}
let direction=CompassPoint.North

switch direction{
case .North:
    println(1)
case .South:
    println(2)
case .West:
    println(3)
case .East:
    println(4)
}

//相关值

//enum Barcode{
//    case UPCA(Int,Int,Int)
//    case QRCode(String)
//}
//
//var productBarCode=Barcode.UPCA(8, 85909_51226, 3)
//productBarCode=.QRCode("ABCDEFGHIJKLMN")


//原始值
enum Planet:Int{
    case Mercury=1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let earthOrder=Planet.Earth.rawValue
let possiblePlanet=Planet(rawValue: 7)

let positionToFind=9

if let someplanet=Planet(rawValue: positionToFind){
    switch someplanet{
    case .Earth:
        println("Mostly harmless")
    default:
        println("Not a safe place for humans")
        
    }
}else{
    println("There isn't a planet position \(positionToFind)")
}





