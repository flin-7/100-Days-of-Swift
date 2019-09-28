import UIKit

// Properties

struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        
        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "short skirts"


// Static properties and methods

struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"
    
    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)


// Access control

class TaylorFan2 {
    fileprivate var name: String?
}


// Polymorphism and typecasting

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots."
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots."
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots."
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studio")
var fearless = StudioAlbum(name: "Fearless", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")
var allAlbums: [Album] = [taylorSwift, fearless]

for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
//    print(album.getPerformance())
    
//    if let studioAlbum = album as? StudioAlbum {
//        print(studioAlbum.studio)
//    } else if let liveAlbum = album as? LiveAlbum {
//        print(liveAlbum.location)
//    }
    
//    let studioAlbum = album as! StudioAlbum
//    print(studioAlbum.studio)
    print(album.getPerformance())
//    print(album.studio)
    print(album.location)
}

let number = 5
let text = String(number)
print(text)


// Closures

let vw = UIView()

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}

