//
//  泛型.swift
//  类型转换
//
//  Created by henyep on 15/6/25.
//  Copyright (c) 2015年 com. All rights reserved.
//

import Foundation

//类型约束语法
//第一个类型参数是T 有一个需要T必须是someclass子类的类型约束,第二个类型参数是U，有一个需要U必须遵循someprotocol协议的类型约束
//func someFunction<T:SomeClass,U:SomeProtocol>(someT:T,someU:U){}

func findIndex<T:Equatable>(array:[T],valueToFind:T)->Int?{
    for (index,value) in enumerate(array){
        if value==valueToFind{
            return index
        }
    }
    return nil
}

//1)关联类型
protocol Container{
    typealias ItemType
    mutating func append(item:ItemType)
    var count:Int{get}
    subscript(i:Int)->ItemType{get}
}

struct IntStack:Container {
    var items=[Int]()
    mutating func push(item:Int){
        items.append(item)
    }
    mutating func pop()->Int{
       return items.removeLast()
    }
    
    //遵循协议的实现
    typealias ItemType=Int
    mutating func append(item: Int) {
        self.push(item)
    }
    
    var count:Int{
        return items.count
    }

    subscript(i:Int)->Int{
        return items[i]
    }
}

struct Stack<T>:Container {
    var items=[T]()
    mutating func push(item:T){
        items.append(item)
    }
    mutating func pop()->T{
        return items.removeLast()
    }
    
    //遵循协议
//    typealias ItemType=T
    mutating func append(item: T) {
        self.push(item)
    }
    var count:Int{return items.count}
    subscript(i:Int)->T{return items[i]}
}

//where语句
func allItemsMatch<C1:Container,C2:Container where C1.ItemType==C2.ItemType,C1.ItemType:Equatable>(someContainer:C1,anotherContainer:C2)->Bool{
    //检查两个Container的元素个数是否相同
    if someContainer.count != anotherContainer.count{
        return false
    }
    
    for i  in 0..<someContainer.count{
        if someContainer[i] != anotherContainer[i]{
            return false
        }
    }
    return true
}

