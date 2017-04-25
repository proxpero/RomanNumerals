
struct Roman {

    let rawValue: Int
    let numeral: String

    private static func parse(from integer: Int) -> String {
        let pairs: [(Int, String)] = [
            (1000, "M"),
            (900, "CM"),
            (500, "D"),
            (400, "CD"),
            (100, "C"),
            (90, "XC"),
            (50, "L"),
            (40, "XL"),
            (10, "X"),
            (9, "IX"),
            (5, "V"),
            (4, "IV"),
            (1, "I")
        ]
        func create(from integer: Int) -> String {
            for (n, s) in pairs {
                if integer >= n {
                    return s + create(from: integer - n)
                }
            }
            return ""
        }
        return create(from: integer)
    }

    private static func parse(from string: String) -> Int? {

        guard !string.isEmpty else {
            return nil
        }

        let pairs: [(Int, String)] = [
            (900, "CM"),
            (400, "CD"),
            (90, "XC"),
            (40, "XL"),
            (9, "IX"),
            (4, "IV"),
            (1000, "M"),
            (500, "D"),
            (100, "C"),
            (50, "L"),
            (10, "X"),
            (5, "V"),
            (1, "I")
        ]

        func value(for string: String) -> Int? {
            guard !string.isEmpty else { return 0 }
            for pair in pairs {
                if string.hasPrefix(pair.1) {
                    let next = String(string.characters.dropFirst(pair.1.characters.count))
                    guard let v = value(for: next) else { break }
                    return pair.0 + v
                }
            }
            return nil
        }
        return value(for: string.uppercased())
    }

    init(_ integer: Int) {
        guard integer > 0 else {
            fatalError("Cannot make Roman numeral from non-positive integer.")
        }
        rawValue = integer
        numeral = Roman.parse(from: rawValue)
    }

    init?(roman: String) {
        guard let value = Roman.parse(from: roman) else {
            return nil
        }
        numeral = roman
        rawValue = value
    }

}

extension Roman: Equatable {
    static func ==(lhs: Roman, rhs: Roman) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension Roman: Hashable {
    var hashValue: Int {
        return rawValue.hashValue
    }
}

extension Roman: Comparable {
    static func <(lhs: Roman, rhs: Roman) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Roman: CustomStringConvertible {
    var description: String {
        return numeral
    }
}

extension Roman: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension Roman: ExpressibleByStringLiteral {

    init(unicodeScalarLiteral value: String) {
        guard let roman = Roman(roman: value) else {
            fatalError("Could not parse \(value)")
        }
        self = roman
    }

    init(extendedGraphemeClusterLiteral value: String) {
        guard let roman = Roman(roman: value) else {
            fatalError("Could not parse \(value)")
        }
        self = roman
    }

    init(stringLiteral value: String) {
        guard let roman = Roman(roman: value) else {
            fatalError("Could not parse \(value)")
        }
        self = roman
    }

}


extension Roman {

    static func +(lhs: Roman, rhs: Roman) -> Roman {
        return Roman(lhs.rawValue + rhs.rawValue)
    }

    static func -(lhs: Roman, rhs: Roman) -> Roman {
        return Roman(lhs.rawValue - rhs.rawValue)
    }

    static func *(lhs: Roman, rhs: Roman) -> Roman {
        return Roman(lhs.rawValue * rhs.rawValue)
    }

    static func /(lhs: Roman, rhs: Roman) -> Roman {
        return Roman(lhs.rawValue / rhs.rawValue)
    }

    public static func %(lhs: Roman, rhs: Roman) -> Roman {
        return Roman(lhs.rawValue % rhs.rawValue)
    }

    public func toIntMax() -> IntMax {
        return Int64(rawValue)
    }
    
}


let r1 = Roman(235)
let r2 = Roman(783)
let sum = r1 + r2

r1.numeral
r2.numeral

sum.numeral
(r2-r1).numeral
//(r1*r2).numeral
(r2/r1).numeral

let r3: Roman = 13
let r4: Roman = 3

let r5 = r3 * r4
//let r6 = r4 - r3

let r7: Roman = 2728

let r8: Roman = "XVII"
let r9: Roman = "CDIV"

let r10 = r9 - r8


let x = (1...22).map { Roman.init($0) }

