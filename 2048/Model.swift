//
//  Model.swift
//  2048
//
//  Created by Daniel Palacio on 7/1/19.
//  Copyright © 2019 Daniel Palacio. All rights reserved.
//

import Foundation
import UIKit
private var board:Dictionary<Array<Int>,UIButton>!
private var x_tracker:Array<Array<Int>>!
class Model {
    init() {
        board = [Array<Int>: UIButton]()
        x_tracker = []
    }
    public func size() -> Int {
        return board.count
    }
    public func randomPoint() -> Array<Int> {
        let random_x = Int.random(in: 0..<4)
        let random_y = Int.random(in: 0..<4)
        return [random_x,random_y]
    }
    public func add(point: Array<Int>, current_button: UIButton){
        board[point] = current_button
    }
    public func add_to_x_tracker(occupiedPoint: Array<Int>){
        x_tracker.append(occupiedPoint)
    }
    
    public func getX(Point: Array<Int>) -> Int{
        return Point.first!
    }
    public func getY(Point: Array<Int>) -> Int{
        return Point.last!
    }
    public func getButton(Point: Array<Int>) -> UIButton {
        return board[Point]!
    }
    public func generate_even_entry() -> Int {
        let random_even = Int.random(in: 0..<5)
        if(random_even%2 != 0 || random_even==0){
            return generate_even_entry()
        }
        return random_even
    }
    // This function is for testing purposes.
    public func print_board_points(){
        print("Sometjing")
    }
    public func is_button_empty(currentPoint: Array<Int>) -> Bool{
        if(getButton(Point: currentPoint).currentTitle!.isEmpty){
            return true
        }
        return false
    }
    public func move_right(){
        
    }
}
