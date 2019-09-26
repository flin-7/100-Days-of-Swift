import UIKit

// Variables and Constants

// Type of Data

var name: String
name = "Tim McGraw"
name = "Romeo"

var age: Int
age = 25

var latitude: Double
latitude = 36.166667

var longitude: Double
longitude = -1234567896.783333

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat = false

// Operators

var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var name2 = "Romeo"
var both = name + " and " + name2

var c = a + b
c > 3
c >= 3
c > 4
c < 4

name == "Romeo"
name != "ROMEO"

!stayOutTooLate

// String interpolation

name = "Tim McGrew"
"Your name is \(name)"
age = 25
latitude = 36.166667

"Your name is \(name), your age is \(age), and your latitude is \(latitude)."

"Your age is \(age) years old. In another \(age) years you will be \(25 * 2)."

// Arrays

var evenNumbers = [2, 4, 6, 8]
var songs1 = ["Shake it off", "You Belong with Me", "Back to December"]

songs1[0]
songs1[1]
songs1[2]

type(of: songs1)

var songs2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both2 = songs1 + songs2

// Dictionaries

var person = [
    "first": "Taylor",
    "middle": "Alison",
    "last": "Swift",
    "month": "December",
    "website": "taylorswift.com"
]
person["middle"]
person["month"]

// Conditional statements

var action: String
var person1 = "hater"

if person1 == "hater" {
    action = "hate"
} else if person1 == "player" {
    action = "play"
} else {
    action = "cruise"
}

stayOutTooLate = true
nothingInBrain = true

if stayOutTooLate && nothingInBrain {
    action = "cruise"
}

if !stayOutTooLate && !nothingInBrain {
    action = "cruise"
}

// Loops

for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var str = "Fakers gonna"

for _ in 1...5 {
    str += " fake"
}

print(str)

for song in songs1 {
    print("My favorite song is \(song)")
}

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0..<people.count {
    print("\(people[i]) gonna \(actions[i])")
}

for i in 0..<people.count {
    var str = "\(people[i]) gonna"
    
    for _ in 1...5 {
        str += " \(actions[i])"
    }
    print(str)
}

var counter = 0

while true {
    print("Counter is now \(counter)")
    counter += 1
    
    if counter == 556 {
        break
    }
}

for song in songs1 {
    if song == "You Belong with Me" {
        continue
    }
    
    print("My favorite song is \(song)")
}

// Switch case

let liveAlbums = 2

switch liveAlbums {
case 0...1:
    print("You're just starting out")
case 2...3:
    print("You just released iTunes Live From SoHo")
case 4...5:
    print("You just released Speak Now World Tour")
default:
    print("Have you done something new?")
}

