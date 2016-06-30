//
//  Rank.swift
//  Fischer
//
//  Copyright 2016 Nikolai Vazquez
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

/// A chess board rank.
///
/// `Rank`s refer to the eight rows of a chess board, beginning with 1 at the bottom and ending with 8 at the top.
public enum Rank: Int, Comparable, CustomStringConvertible {

    /// A direction in rank.
    public enum Direction {

        /// Up direction.
        case Up

        /// Down direction.
        case Down

    }

    /// Rank 1.
    case One = 1

    /// Rank 2.
    case Two = 2

    /// Rank 3.
    case Three = 3

    /// Rank 4.
    case Four = 4

    /// Rank 5.
    case Five = 5

    /// Rank 6.
    case Six = 6

    /// Rank 7.
    case Seven = 7

    /// Rank 8.
    case Eight = 8

    /// An array of all ranks.
    public static let all: [Rank] = [1, 2, 3, 4, 5, 6, 7, 8]

    /// The row index of `self`.
    public var index: Int {
        return rawValue - 1
    }

    /// A textual representation of `self`.
    public var description: String {
        return String(rawValue)
    }

    /// Create an instance from an integer value.
    public init?(_ value: Int) {
        self.init(rawValue: value)
    }

    /// Create a `Rank` from a zero-based row index.
    public init?(row index: Int) {
        self.init(rawValue: index + 1)
    }

    /// Creates the starting `Rank` for the color.
    public init(startFor color: Color) {
        self = color.isWhite ? .One : .Eight
    }

    /// Creates the ending `Rank` for the color.
    public init(endFor color: Color) {
        self = color.isWhite ? .Eight : .One
    }

    /// Returns a rank from advancing `self` by `value` with respect to `color`.
    public func advanced(by value: Int, for color: Color = .White) -> Rank? {
        return Rank(rawValue: rawValue + (color.isWhite ? value : -value))
    }

    /// The next rank after `self`.
    public func next() -> Rank? {
        return Rank(rawValue: rawValue.successor())
    }

    /// The previous rank to `self`.
    public func previous() -> Rank? {
        return Rank(rawValue: rawValue.predecessor())
    }

    /// The opposite rank of `self`.
    public func opposite() -> Rank {
        return Rank(rawValue: 9 - rawValue)!
    }

    /// The files from `self` to `other`.
    public func to(other: Rank) -> [Rank] {
        if other > self {
            return (rawValue...other.rawValue)
                .flatMap({ Rank(rawValue: $0) })
        } else if other < self {
            return (other.rawValue...rawValue)
                .reverse()
                .flatMap({ Rank(rawValue: $0) })
        } else {
            return [self]
        }
    }

    /// The files between `self` and `other`.
    public func between(other: Rank) -> [Rank] {
        if other > self {
            return (rawValue.successor() ..< other.rawValue)
                .flatMap({ Rank(rawValue: $0) })
        } else if other < self {
            return (other.rawValue.successor() ..< rawValue)
                .reverse()
                .flatMap({ Rank(rawValue: $0) })
        } else {
            return []
        }
    }

}

extension Rank: IntegerLiteralConvertible {

    /// Create an instance initialized to `value`.
    public init(integerLiteral value: Int) {
        guard let rank = Rank(rawValue: value) else {
            fatalError("Rank value not within 1 and 8, inclusive")
        }
        self = rank
    }

}

/// Returns `true` if one rank is higher than the other.
public func < (lhs: Rank, rhs: Rank) -> Bool {
    return lhs.rawValue < rhs.rawValue
}
