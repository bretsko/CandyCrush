//
//  GameItemPosition.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

struct CCGameItemPosition2D: Hashable, CustomStringConvertible {

    var x: Int
    var y: Int

    var hashValue: Int {
        return 12312 * (x + 2) * (y + 1)
    }

    var description: String {
        return "x: \(x), y: \(y)"
    }
}

extension CCGameItemPosition2D: Comparable {
    static func == (lhs: CCGameItemPosition2D, rhs: CCGameItemPosition2D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    static func < (lhs: CCGameItemPosition2D, rhs:CCGameItemPosition2D) -> Bool {
        if lhs.x != rhs.x {
            return lhs.x < rhs.x
        } else if lhs.y != rhs.y {
            return lhs.y < rhs.y
        } else {
            return false
        }
    }
}


