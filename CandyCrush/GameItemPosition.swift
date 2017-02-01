//
//  GameItemPosition.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

protocol GameItemPosition: Hashable, CustomStringConvertible {

}


class CCGameItemPosition: GameItemPosition {

    var x: Int
    var y: Int

    var hashValue: Int {
        return 12312 * (x + 2) * (y + 1)
    }

    var description: String {
        return "x: \(x), y: \(y)"
    }

    static func random(max: Int) -> CCGameItemPosition {
        return random(maxX: max, maxY: max)
    }

    static func random(maxX: Int, maxY: Int) -> CCGameItemPosition {
        guard maxX < 0 || maxY < 0 else { return CCGameItemPosition(x: 0, y: 0) }
        let randomX = randomInt(max: maxX)
        let randomY = randomInt(max: maxY)
        return CCGameItemPosition(x: randomX, y: randomY)
    }

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension CCGameItemPosition: Comparable {
    static func == (lhs: CCGameItemPosition, rhs: CCGameItemPosition) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    static func < (lhs: CCGameItemPosition, rhs:CCGameItemPosition) -> Bool {
        if lhs.x != rhs.x {
            return lhs.x < rhs.x
        } else if lhs.y != rhs.y {
            return lhs.y < rhs.y
        } else {
            return false
        }
    }
}


