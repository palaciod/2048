//
//  Model.swift
//  2048
//
//  Created by Daniel Palacio on 7/1/19.
//  Copyright © 2019 Daniel Palacio. All rights reserved.
//

import Foundation
import UIKit
private var board:Dictionary<Point,UIButton>!
private var x_tracker:Array<Point>!
class Model {
    init() {
        board = [Point: UIButton]()
        x_tracker = []
    }
    public func size() -> Int {
        return board.count
    }
    public func size_of_tracker() -> Int{
        return x_tracker.count
    }
    public func randomPoint() -> Point {
        let random_x = Int.random(in: 0..<4)
        let random_y = Int.random(in: 0..<4)
        return Point(x_coordinate: random_x, y_coordinate: random_y)
    }
    public func add(point: Point, current_button: UIButton){
        board[point] = current_button
    }
    public func add_to_x_tracker(occupiedPoint: Point){
        x_tracker.append(occupiedPoint)
    }
    
    public func getX(Point: Array<Int>) -> Int{
        return Point.first!
    }
    public func getY(Point: Array<Int>) -> Int{
        return Point.last!
    }
    public func getButton(Point: Point) -> UIButton {
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
        print("Something")
    }
    public func is_button_empty(currentPoint: Point) -> Bool{
        if(getButton(Point: currentPoint).currentTitle!.isEmpty){
            return true
        }
        return false
    }
    public func move_right(){
        let smallPoint = Point(x_coordinate: 0, y_coordinate: 0)
        let largePoint = Point(x_coordinate: 3, y_coordinate: 3)
        print(smallPoint<largePoint)
        
    }
    public func print_tracker(){
        var x = 0
        while(x<x_tracker.count){
            print(x_tracker[x].toString())
            x+=1
        }
    }
    
    public func merge_sort_tracker(unsortedTracker: Array<Point>) -> Array<Point> {
        
        return []
    }
    
    
    
}
