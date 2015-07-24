//
//  main.swift
//  类型转换
//
//  Created by henyep on 15/6/24.
//  Copyright (c) 2015年 com. All rights reserved.
//

import Foundation

class MediaItem {
    var name:String
    init(name:String){
        self.name=name
    }
}

class Movie: MediaItem {
    var director:String
    init(name: String,director:String ) {
        self.director=director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist:String
    init(name: String,artist:String) {
        self.artist=artist
        super.init(name: name)
    }
}

let library=[Movie(name: "casabalance", director: "Michael Curtiz"),
            Song(name: "Blue suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Haekes")
            ]

var movieCount=0
var songCount=0

for item in library{
//    if item is Movie{
//        ++movieCount
//    }else if item is Song{
//        ++songCount
//    }

    if let movie=item as? Movie{
        println("Movie: '\(movie.name)',dir \(movie.director)")
    }else if let song=item as? Song{
        println("Song :'\(song.name)', by \(song.artist)")
    }
}

//println("Media library contains \(movieCount) movies and \(songCount) songs")

//扩展方法
extension Int{
    func repetion(task:()->()){
        for i in 0..<self{
            task()
        }
    }
}

4.repetion{println("hello")}

let doubleIndex=findIndex([3.14159,0.1,0.25], 9.3)
let stringIndex=findIndex(["Mike","Malcolm","Andrea"], "Andrea")


//var stackOfStrings=Stack<String>()
//stackOfStrings.push("uno")
//stackOfStrings.push("dos")
//stackOfStrings.push("tres")
//
//var arrayOfStrings=IntStack()
//arrayOfStrings.push(1)
//arrayOfStrings.push(2)
//arrayOfStrings.push(3)

//if allItemsMatch(stackOfStrings, arrayOfStrings){
//    println("true")
//}else{
//    println("false")
//}

//运算符函数
let vector=Vetor2D(x:3.0,y:1.0)
let anotherVector=Vetor2D(x: 2.0, y: 4.0)
let combinedVetor=vector + anotherVector
println(combinedVetor.x)

let positive=Vetor2D(x: 3.0, y: 4.0)
let negative = -positive
println(negative.x,negative.y)

var original=Vetor2D(x: 1.0, y: 2.0)
var vetorToAdd=Vetor2D(x: 3.0, y: 4.0)
original += vetorToAdd






