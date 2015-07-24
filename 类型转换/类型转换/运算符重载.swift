//
//  运算符重载.swift
//  类型转换
//
//  Created by henyep on 15/6/25.
//  Copyright (c) 2015年 com. All rights reserved.
//

import Foundation

struct Vetor2D {
    var x=0.0,y=0.0
}

func + (left:Vetor2D,right:Vetor2D)->Vetor2D{
    return Vetor2D(x:left.x+right.x, y: left.y+right.y)
}

//前置运算符
prefix func -(vector:Vetor2D)->Vetor2D{
    return Vetor2D(x: -vector.x, y: -vector.y)
}
func += (inout left:Vetor2D,inout right:Vetor2D){
    left=left + right
}

