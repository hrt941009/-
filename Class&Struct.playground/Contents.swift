//: Playground - noun: a place where people can play

import UIKit

struct FixedLengthRange{
    var firstValue:Int
    let length:Int
}

var rangeOfThreeitems=FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeitems.firstValue=6

//延迟存储属性
class DataImporter{
    var fileName="data.txt"
}

class DataManager{
    //只有在第一次访问时才被创建
    lazy var importer=DataImporter()
    var data=[String]()
}

let manager=DataManager()
manager.data.append("some data")
manager.data.append("some more data")
println(manager.importer.fileName)

//计算熟悉  get/set方法

struct Point {
    var x=0.0,y=0.0
}

struct Size {
    var width=0.0,height=0.0
}

struct Rect {
    var origin=Point()
    var size=Size()
    var center:Point{
        get{
            let centerX=origin.x+(size.width/2)
            let centerY=origin.y+(size.height/2)
            return Point(x: centerX, y: centerY)
        }
        set(newcenter){
            origin.x=newcenter.x-(size.width/2)
            origin.y=newcenter.y-(size.height/2)
        }
    }
}
var square=Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))

let initalSquareCenter=square.center
square.center=Point(x: 15.0, y: 15.0 )

//只读计算属性声明可以去掉get关键字和花括号
struct Cuboid{
    var width=0.0,height=0.0,depth=0.0
    var volume:Double{
        return width * height * depth
    }

}
let fourByFiveByTwo=Cuboid(width: 4.0, height: 5.0, depth: 2.0)
fourByFiveByTwo.volume


//属性观察器 willSet在设置新的值之前调用 didSet在新的值被设置之后立即调用
class StepCounter{
    var totalSteps:Int=0{
        willSet(newTotalSteps){
            println("new value \(newTotalSteps)")
        }
        didSet{
            if oldValue<totalSteps{
                println("added \(totalSteps-oldValue) steps")
            }
            
        }
        
    }

}
let step=StepCounter()
step.totalSteps=200
step.totalSteps=360

struct AudioChannel {
    static let thresholdLevel=10
    static var maxInputLevelForAllChannels=0
    var currentleveL:Int=0{
        didSet{
            if currentleveL > AudioChannel.thresholdLevel{
            currentleveL=AudioChannel.thresholdLevel
            }
            if currentleveL > AudioChannel.maxInputLevelForAllChannels{
                AudioChannel.maxInputLevelForAllChannels=currentleveL
            }
        }
    }
}


var leftChannel=AudioChannel()
var rightChanel=AudioChannel()

leftChannel.currentleveL=7
println(AudioChannel.maxInputLevelForAllChannels)

rightChanel.currentleveL=11
println(AudioChannel.maxInputLevelForAllChannels)


//方法 
class Counter{
    var count=0
    func increment(){
        count++
    }
    
    func incrementBY(amount:Int){
        count += amount
    }

    func increment(amount:Int,numberofTimes:Int){
        count += amount * numberofTimes
    }
    
    func reset(){
        count=0
    }
}

let counter=Counter()
counter.increment()
counter.incrementBY(6)
counter.increment(5, numberofTimes: 3)
counter.reset()

//在实例方法中修改值类型

struct Point1 {
    var x=0.0,y=0.0
    //变异方法 mutating
    mutating func moveByx(deltax:Double,deltaY:Double){
        x += deltax
        y += deltaY
//        self= Point1(x: x+deltax, y: y+deltaY)
    }
}
var somepoint=Point1(x: 2.0, y: 2.0)
somepoint.moveByx(4.0, deltaY: 4.0)

enum TriStateSwitch{
    case Off,Low,High
    mutating func next(){
        switch self{
        case .Off:
            self=Low
        case .Low:
            self=High
        case .High:
            self=Off
        }
    }
}
var ovenLight=TriStateSwitch.Low
ovenLight.next()
println(ovenLight.hashValue)
ovenLight.next()
println(ovenLight.hashValue)

//类型方法

struct LevelTracker {
    
    static  var highestUnlockedLevel=1
    
    static func unlockLevel(level:Int){
        if level > highestUnlockedLevel{
            highestUnlockedLevel=level
        }
    }
    
    static func levelIsUnlocked(level:Int)->Bool{
        return level <= highestUnlockedLevel
    }
    
    var currentlevel=1
    mutating func advanceTolevel(level:Int)->Bool{
        if LevelTracker.levelIsUnlocked(level){
            currentlevel=level
            return true
        }
        else{
            return false
        }
    }
}


class Player {
    var tracker=LevelTracker()
    let playerName:String
    func completeLevel(level:Int){
        LevelTracker.unlockLevel(level+1)
        tracker.advanceTolevel(level+1)
    }
    init(name:String){
        playerName=name
    }
}

var player=Player(name: "Argyrios")
player.completeLevel(1)

//下标脚本
struct TimesTable{
    let multiplier:Int
    subscript(index:Int)->Int{
        return multiplier * index
    }
}

let threeTimesTable=TimesTable(multiplier: 3)
threeTimesTable[69]

struct Matrix{
    let rows:Int,columns:Int
    var grid:[Double]
    init(rows:Int,columns:Int){
        self.rows=rows
        self.columns=columns
        grid=Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexISValidForRow(row:Int,column:Int)->Bool{
        return row>=0 && row<rows && column>=0 && column<columns
    }
    
    subscript(row:Int,column:Int)->Double{
        get{
            assert(indexISValidForRow(row, column: column), "index out of range")
            return grid[(row * columns) + column]
        }
        set{
             assert(indexISValidForRow(row, column: column), "index out of range")
            grid[(row * columns) + column]=newValue
        }
    }
}

var matrix=Matrix(rows: 3, columns: 3)
matrix[0,1]=1.5
matrix[1,2]=2.0
let someValue=matrix[4,4]
println(someValue)

println(matrix.grid)








