//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print(str)

class Dog {
    var name = ""
    private var whatADogSays = "woof" // dumb, but demoes "self"
    func bark() {
        print(self.whatADogSays)
    }
    func speak() {
        self.bark()
    }
}

let fido = Dog()
fido.name = "Fido"

print(fido.name)
fido.bark()
fido.speak()

let dog1 = Dog()
//dog1.whatADogSays = "meow"
dog1.bark()

func sum(_ x:Int, _ y:Int) -> Int { // _ prevents internal param
    let result = x + y              // name from being automatically
    return result                   // used as external nam
}                                   // sometimes method name makes
                                    // external name redundant
print(sum(4, 6))

func echoString(_ s:String, times n:Int) -> String {
    var result = ""
    for _ in 1...n{ result += s }
    return result
}

func echo(string s:String, times n:Int) -> String {
    var result = ""
    for _ in 1...n{ result += s }
    return result
}
print(echoString("test", times:4))
print(echo(string:"test", times:4))

//overloading - includes types PLUS external parameter names
// differing external params is two separate functions
// not technically overloading
func say (_ what:String) {
}
func say (_ what:Int) {
}

func say(test what:String) { //not the same methodswif
    
}

//overloading - return value makes a difference in Swift
// below can co-exist, but context must make clear which is used
// let result = say() won't work
func say() -> String {
    return "one"
}
func say() -> Int {
    return 1
}

let result:String = say()
let otherResult = say() + "two" //legal due to context requiring string

//Default values
class Dog1 {
    func say(_ s:String, times:Int = 2) {
        for _ in 1...times {
            print(s)
        }
    }
}

let dog = Dog1()
dog.say("Woof")

//Variadic parameter
func sayStrings(_ arrayOfStrings:String ...) {
    for s in arrayOfStrings { print(s)}
}

sayStrings("hey", "there", "Bill")

//Labels can allow params after variadic, print() is variadic, max of one variadic param
print("Manny", "Moe", separator:", ", terminator:",")


//Ignored params, if internal name is '_', then param can't be addressed
func say(_ s:String, times:Int, loudly _:Bool)->Void {} //loudly must be supplied, but can't be used

//params are implicitly final ("let")
// but, that can be overridden
func removeCharacter(_ c:Character, from s:String) -> Int {
    var s = s
    var howMany = 0
    while let ix = s.index(of:c) {
        s.remove(at:ix)
        howMany += 1
        print(s)
    }
    return howMany
}

let s = "hello"
let result2 = removeCharacter("l", from: s)
print() // add new line that wasn't used as terminator of last print()
print(result2, s)

//Changing param to 'inout' (has to be a var) allows mutation
func removeCharacter2(_ c:Character, from s:inout String) -> Int {
    var howMany = 0
    while let ix = s.index(of:c) {
        s.remove(at:ix)
        howMany += 1
        print(s)
    }
    return howMany
}
var s2 = "hello"
let result3 = removeCharacter2("l", from: &s2)
print(result3, s2)

//inout is used to call functions like this that take pointers from Objective-C frameworks
// which uses mutable params because it can't return multiple values
//func getRed(_ red: UnsafeMutablePointer<CGFloat>, green: UnsafeMutablePointer<CGFloat>

let c = UIColor.purple
var r: CGFloat = 0
var g: CGFloat = 0
var b: CGFloat = 0
var a: CGFloat = 0

if (c.getRed(&r, green:  &g, blue: &b, alpha: &a)) {
    print(r, g, b, a)
}

//UnsafeMutablePointer is Objective-C not Swift, so not exactly like 'inout'
// can be modified as below example using 'pointee' property
//func popoverPresentationController(
//    _ popoverPresentationController: UIPopoverPresentationController,
//    willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>,
//    in view: AutoreleasingUnsafeMutablePointer<UIView>) {
//    view.pointee = self.button2
//    rect.pointee = self.button2.bounds
//}


// However, properties of class instances passed in can be modified (above, String is a struct, not a class
// note we don't change instance of Moose passed in
class Moose {
    var name = ""
}

func changeName(of m:Moose, to newName:String) {
    m.name = newName
}

let moose:Moose = Moose()
changeName(of: moose, to: "Bill")
print(moose.name)

//functions can even be defined in functions, for funcs only called by outer, but still obeying DRY
//func checkPair(_ p1:Piece, and p2:Piece) -> Path? {
//    // ...
//    func addPathIfValid(_ midpt1:Point, _ midpt2:Point) {
//        // ...
//    }
//    for y in -1..._yct {
//        addPathIfValid((pt1.x,y),(pt2.x,y))
//    }
//    for x in -1..._xct {
//        addPathIfValid((x,pt1.y),(x,pt2.y))
//    }
//    // ...
//}


//recursion
func countDownFrom(_ ix:Int) {
    print(ix)
    if ix > 0 { // stopper
        countDownFrom(ix-1) // recurse!
    }
}
countDownFrom(5) // 5, 4, 3, 2, 1, 0

//Functions are first class citizens, type is function signature
// ->() is equivalent to -> Void
func doThis(_ f:() -> ()) {
    f()
}
func whatToDo() {
    print("I did it")
}
doThis(whatToDo)

// You can alias a the type of a function
typealias VoidVoidFunc = () -> ()
func doThis2(_ f:VoidVoidFunc) {
    f()
}
doThis2(whatToDo)

// Also, don't have to declare function first to give it a name, can just pass anonymous body
// if it won't be re-used. This is an anonymous function or closure. First version, no params
// second shows if params, can omit return type if compiler knows it, in can be omitted if
// no params, as in first one
doThis({print("I did it")})

func doThis3(_ str:String, _ f:(_ str:String)->()) {
    f(str)
}
//doThis3("Hi there!", {(str2:String) -> () in print(str2)}) also works, but return type known
doThis3("Hi there!", {(str2:String) in print(str2)})

doThis3("Ho there!", {
    str3 in print(str3)
    
}) // can also leave off param type and parens if param type 	known

// Can use "magic" $0 for first param instead of in
doThis3("Hey there!", {
    print($0)
})

//If the function param is the last param, it can go outside parens
doThis3("Yo there!") { print($0)} // this is trailing syntax (and I think it's a mistake)

// return keyword can be omitted for passed in func is one line that just returns
func greeting() -> String {return "Hi Guy!"}
func performAndPrint(_ f:()->String) {
    let s = f()
    print(s)
}
performAndPrint {
    greeting() // meaning: return greeting()
}

//If you use the trailing function syntax, and if the function you are calling takes no parameters other than the function you are passing to it, you can omit the empty parentheses from the call. This is the only situation in which you can omit the parentheses from a function call! To illustrate, I’ll declare and call a different function:
func doThis4(_ f:() -> ()) {
    f()
}
doThis4 { // no parentheses!
    print("Howdy")
}

// Can be very compact, long way:
let arr = [2, 4, 6, 8]
func doubleMe(i:Int) -> Int { return i * 2}
let arr2 = arr.map(doubleMe)

// Compact Swift way:
let arr3 = [2, 4, 6, 8]
let arr4 = arr3.map {$0*4}

arr4.map {print($0)}

func doThis5(_ s:String)->() {
    print(s)
}

// DEFINE AND CALL
// Can even define and call anonymous all at once
// This should send String to doThis5
// In more complicated cases, can save defining
// separate variables first, just to pass to one
// function
doThis5({return "You did it!"}())

// CLOSURES
// Function bark can
// access it even though external to function
class Dog2 {
    var whatThisDogSays = "woof"
    func bark() {
        print(self.whatThisDogSays)
    }
}

func doThis6(_ f : () -> ()) {
    f()
}
let d = Dog2()
let barkFunction = d.bark
d.whatThisDogSays = "arf"
doThis6(barkFunction) // arf

// note whatThisDogSays does not exist inside doThis6()
// it has no dog instance. f() is accessing property not
// otherwise in its scope. d.bark() can still see it
// even though there is no more dog and no more property
// instance variables of d are captured by function
// Closures can make code more general
