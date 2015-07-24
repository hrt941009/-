//: Playground - noun: a place where people can play

import UIKit

class Vehicle {
    var currentSpeed=0.0
    var description:String{
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise(){
        
    }
}

let someVehicle=Vehicle()

class Bicycle: Vehicle {
    var hasBasket=false
    //重写父类方法
    override func makeNoise() {
        println("choo choo")
    }
    //重写父类属性 如果在重写属性中提供了setter，一定也要提供getter 如果不想再重写版本中德尔getter里修改继承来的属性值 可以直接通过super.someproperty返回继承来的值
    override var description:String{
        return super.description + " hello"
    }
}
let bicycle=Bicycle()
bicycle.hasBasket=true
bicycle.currentSpeed=15.0
bicycle.makeNoise()
bicycle.description

class Car:Vehicle{
    //final防止重写
    final var gear=1
    override var description:String{
        return super.description + "in gear \(gear)"
    }
}

let car=Car()
car.currentSpeed=25.9
car.gear=3
car.description

//重写属性观察器
class AutomaticCar:Car{
    override var currentSpeed:Double{
        didSet{
            gear=Int(currentSpeed/10.0)+1
        }
    }
}

let automatic=AutomaticCar()
automatic.currentSpeed=25.0
automatic.description

//类的指定构造器 init  便捷构造器convenience init
class Food{
    var name:String;
    init(name:String){
        self.name=name
    }
    convenience init(){
        self.init(name:"[Unnamed]")
    }
}

let mysteryMeat=Food(name: "Bacon")

class RecoeOmgredoemt: Food {
    var quantity:Int
    init(name: String,quantity:Int) {
        self.quantity=quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name:name,quantity:1)
    }
}

let oneMysteryItem=RecoeOmgredoemt()
let oneBacon=RecoeOmgredoemt(name: "Jack")
let sixEggs=RecoeOmgredoemt(name: "Eggs", quantity: 7)

class ShoppingListItem:RecoeOmgredoemt {
    var purchased=false
    var description:String{
        var output="\(quantity) x \(name.lowercaseString)"
        output +=purchased?"正确":"错误"
        return output
    }
}

//var breakfastList=[ ShoppingListItem(),
//                    ShoppingListItem(name: "Bacon"),
//                    ShoppingListItem(name: "Eggs", quantity: 6)
//]
//breakfastList[0].name="Orange juice"
//breakfastList[0].purchased=true
//for item in breakfastList{
//    println(item.description)
//}


//可失败构造器
class Animal{
    let species:String
    init?(species:String){
    
        if species.isEmpty{
            return nil
        }
        self.species=species
    }
}

let someCreature=Animal(species: "Giragge")
if let giraffe=someCreature{
    println("error \(giraffe.species)")
}

