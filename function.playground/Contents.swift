//: Playground - noun: a place where people can play

import UIKit

func sayHello(personName:String)->String{
    let greeting="Hello" + personName + "!"
    return greeting
}
println(sayHello(" jack "))


//多重输入参数
func halfOfRangeLengyh(start:Int,end:Int)->Int{
    return end-start
}
halfOfRangeLengyh(10, 5)

//无参数函数
func sayHelloWorld()->String{
    return "Hello world"
}

sayHelloWorld()

/////////////////////////////////////////////
func printAndCount(stringToPring:String)->Int{
    println(stringToPring)
    return count(stringToPring)
}

func printWithOutCounting(stringToPrint:String){
    printAndCount(stringToPrint)
}

printAndCount("hello, world")

printWithOutCounting("hello , world")

func swapToInt(inout a:Int,inout b:Int){
    let temp=a
    a=b
    b=temp
}
var someInt=10
var anotherInt=103
swapToInt(&someInt, &anotherInt)
println("\(someInt), \(anotherInt)")

//闭包
func voidFunc()->(){
    println("aaaaaaaa")
}

func closureAction(closure:()->()){
    closure()
}
let c=10
closureAction(){
    
    println(c)
//    println(c)
//    println("sssssssss")
}


let digitNames=[0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",5:"Five",6:"Six",7:"Seven",8:"Eight",9:"nine"]

let numbers=[16,58,510]

let strings=numbers.map{
    (var number)->String in
    var output=""
    while number > 0 {
        output=digitNames[number%10]! + output
        number/=10
    }
    return output
}
//捕获值
func makeIncrementor(forIncreMent amount:Int)->()->Int{
    var runningTotal=0
    func incrementor()->Int{
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incre=makeIncrementor(forIncreMent: 10)
incre()












