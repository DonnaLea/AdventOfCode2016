//: Advent of Code - Day 1 - No Time For A Taxi Cab (Part 1)
// https://adventofcode.com/2016/day/1

import UIKit
import XCTest

enum Direction {
  case North
  case East
  case South
  case West
}

enum Turn: Character {
  case Right = "R"
  case Left = "L"
}

func evaluateDirections(input: String) -> Int {
  let directions = input.components(separatedBy: ", ")
  var horizontalBlocks = 0
  var verticalBlocks = 0
  var currentDirection: Direction = .North
  var visited = [String : Int]()

  for direction in directions {
    let turn = Turn(rawValue: direction.first!)
    let distanceString = direction.substring(from: direction.index(after: direction.startIndex))
    let distance = Int(String(distanceString))!

    switch currentDirection {
    case .North:
      if turn == .Right {
        currentDirection = .East
      } else {
        currentDirection = .West
      }

    case .South:
      if turn == .Right {
        currentDirection = .West
      } else {
        currentDirection = .East
      }

    case .East:
      if turn == .Right {
        currentDirection = .South
      } else {
        currentDirection = .North
      }

    case .West:
      if turn == .Right {
        currentDirection = .North
      } else {
        currentDirection = .South
      }
    }

    for _ in 1...distance {
      switch currentDirection {
      case .North:
          verticalBlocks += 1
      case .South:
        verticalBlocks -= 1
      case .East:
        horizontalBlocks += 1
      case .West:
        horizontalBlocks -= 1
      }
      if recordLocation(horizontal: horizontalBlocks, vertical: verticalBlocks, locations: &visited) {
        let key = generateKey(horizontal: horizontalBlocks, vertical: verticalBlocks)
        return visited[key]!
      }
    }

  }

  let key = generateKey(horizontal: horizontalBlocks, vertical: verticalBlocks)
  return visited[key]!
}

func generateKey(horizontal: Int, vertical: Int) -> String {
  return "h\(horizontal)v\(vertical)"
}

func recordLocation(horizontal: Int, vertical: Int, locations: inout [String : Int]) -> Bool {
  let key = generateKey(horizontal: horizontal, vertical: vertical)
  let value = abs(horizontal) + abs(vertical)
  if let value = locations[key] {
    // Already visited this intersection.
    print("Already visited: \(key))")
    return true
  }

  locations[key] = value
  return false
}

let blocks = evaluateDirections(input: "R1, R3, L2, L5, L2, L1, R3, L4, R2, L2, L4, R2, L1, R1, L2, R3, L1, L4, R2, L5, R3, R4, L1, R2, L1, R3, L4, R5, L4, L5, R5, L3, R2, L3, L3, R1, R3, L4, R2, R5, L4, R1, L1, L1, R5, L2, R1, L2, R188, L5, L3, R5, R1, L2, L4, R3, R5, L3, R3, R45, L4, R4, R72, R2, R3, L1, R1, L1, L1, R192, L1, L1, L1, L4, R1, L2, L5, L3, R5, L3, R3, L4, L3, R1, R4, L2, R2, R3, L5, R3, L1, R1, R4, L2, L3, R1, R3, L4, L3, L4, L2, L2, R1, R3, L5, L1, R4, R2, L4, L1, R3, R3, R1, L5, L2, R4, R4, R2, R1, R5, R5, L4, L1, R5, R3, R4, R5, R3, L1, L2, L4, R1, R4, R5, L2, L3, R4, L4, R2, L2, L4, L2, R5, R1, R4, R3, R5, L4, L4, L5, L5, R3, R4, L1, L3, R2, L2, R1, L3, L5, R5, R5, R3, L4, L2, R4, R5, R1, R4, L3")
print(blocks)

class DirectionsTests : XCTestCase {

  func testInput1() {
    let blocks = evaluateDirections(input: "R8, R4, R4, R8")
    XCTAssertEqual(blocks, 4)
  }
}

DirectionsTests.defaultTestSuite.run()
