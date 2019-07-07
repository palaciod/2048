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
        var tracker_index = 0
        x_tracker.sort(by: <)
        x_tracker.reverse()
        while tracker_index < x_tracker.count {
            let key:Point = x_tracker[tracker_index]
            let content = board[key]!.currentTitle
            board[key]!.setTitle("", for: .normal)
                print(tracker_index)
            let x:Int = key.getX()
                switch x {
                case 0:
                    key.setX(new_x: key.getX() + 3 )
                    break;
                case 1:
                    key.setX(new_x: key.getX() + 2 )
                    break;
                case 2:
                    key.setX(new_x: key.getX() + 1 )
                    break;
                case 3:
                    key.setX(new_x: key.getX() )
                    break;
                default:
                    break
            }
            board[key]!.setTitle(content, for: .normal)
            tracker_index += 1
        }
    }
    
    private func add_button_content(content: String, index: Int){
        
    }
    public func print_tracker(){
        var x = 0
        x_tracker.sort(by: >)
        while(x<x_tracker.count){
            print(x_tracker[x].toString())
            x+=1
        }
    }
}
