import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.

// Getter - Read access
// Setter - Write access

protocol fullyNamed {
    var fullName: String { get }
}

// Adoption - Step 1
// Comformance - Step 2
struct Person: fullyNamed {
    var fullName: String
}

let johnny = Person(fullName: "Johnny Hicks")
let ben = Person(fullName: "Ben")

print(johnny.fullName)

class StarShip: fullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    // Computed Property (Calculated Property)
    var fullName: String {
        // Ternary Operators
        return (prefix != nil ? prefix! + " ": "") + self.name
    }
}

var ncc1701 = StarShip(name: "Enterprise", prefix: "USS")
ncc1701.fullName

var firefly = StarShip(name: "Serenity")
firefly.fullName

//: Protocols can also require that conforming types implement certain methods.
protocol GenerateRandomNumbers {
    func random() -> Int
}

class OneThroughTen: GenerateRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
    
}

let rand = OneThroughTen()
rand.random()


//: Using built-in Protocols
extension StarShip: Equatable {
    static func == (lhs: StarShip, rhs: StarShip) -> Bool {
        if lhs.fullName == rhs.fullName { return true }
        else { return false }
    }
}

if ncc1701 == firefly {
    print("Same Starship")
}


//: ## Protocols as Types
class Dice {
    let side: Int
    let generator: GenerateRandomNumbers
    
    init(side: Int, generator: GenerateRandomNumbers) {
        self.side = side
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() % side) + 1
    }
}

var d6 = Dice(side: 6, generator: OneThroughTen())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

