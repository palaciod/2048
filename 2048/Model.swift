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
    var board_change_status: Bool
    init() {
        board = [Point: UIButton]()
        x_tracker = []
        board_change_status = false
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
    
    public func print_board_changed_status() {
        print(board_change_status)
    }
    public func move_right(){
        var tracker_index = 0
        x_tracker.sort(by: >)
        var reset: Int = 0
        while tracker_index < x_tracker.count {
            let key = x_tracker[tracker_index]
            let key_before_shift = key
            let current_button_content: String? = board[key]?.currentTitle
            board[key]!.setTitle("", for: .normal)
            let x:Int = key.getX()
                switch x {
                case 0:
                    helper_move_right(toPosition: 3, index: tracker_index, local_key: key, &reset)
                    break;
                case 1:
                    helper_move_right(toPosition: 2, index: tracker_index, local_key: key, &reset)
                    break;
                case 2:
                    helper_move_right(toPosition: 1, index: tracker_index, local_key: key, &reset)
                    break;
                case 3:
                    helper_move_right(toPosition: 0, index: tracker_index, local_key: key, &reset)
                    break;
                default:
                    break
            }
            if(tracker_index != 0){
                let prev_key = x_tracker[tracker_index - 1]
                let prev_button: UIButton = board[prev_key]!
                let prev_button_content: String = prev_button.currentTitle!
                // Make sure that both points have the same x values, if not then it'll add points in different x positions
                if current_button_content == prev_button_content && prev_key.getY() == key.getY(){
                    // Now that the content of both buttons have been added, we have to remove the current key from the x_tracker array.
                    let result:String = add_button_content(current_button_string: current_button_content!, buttonsTwo: prev_button)
                    prev_button.setTitle(result, for: .normal)
                    x_tracker.remove(at: tracker_index)
                }else{
                    board[key]!.setTitle(current_button_content, for: .normal)
                    tracker_index += 1
                }
                
                
            }else{
                board[key]!.setTitle(current_button_content, for: .normal)
                tracker_index += 1
            }
            if key == key_before_shift{
                board_change_status = true
            }
        }
    }
    
    public func move_ended(){
        board_change_status = false
    }
    
    private func helper_move_right(toPosition: Int, index: Int, local_key: Point,_ reset_difference: inout Int){
        if index == 0 {
            local_key.setX(new_x: local_key.getX() + toPosition - reset_difference)
            reset_difference += 1
            return
        }
        let previous_key: Point = x_tracker[index - 1]
        if previous_key.getY() - local_key.getY() != 0{
            reset_difference = 0
            local_key.setX(new_x: local_key.getX() + toPosition - reset_difference)
            reset_difference += 1
        }else{
            local_key.setX(new_x: local_key.getX() + toPosition - reset_difference)
            reset_difference += 1
        }
        
    }
    
    public func move_left() {
        var tracker_index = 0
        x_tracker.sort(by: <)
        var reset: Int = 0
        while tracker_index < x_tracker.count {
            let key = x_tracker[tracker_index]
            let key_before_shift = key
            let current_button_content: String? = board[key]?.currentTitle
            board[key]!.setTitle("", for: .normal)
            let x:Int = key.getX()
            switch x {
            case 0:
                helper_move_left(toPosition: 0, index: tracker_index, local_key: key, &reset)
                break;
            case 1:
                helper_move_left(toPosition: 1, index: tracker_index, local_key: key, &reset)
                break;
            case 2:
                helper_move_left(toPosition: 2, index: tracker_index, local_key: key, &reset)
                break;
            case 3:
                helper_move_left(toPosition: 3, index: tracker_index, local_key: key, &reset)
                break;
            default:
                break
            }
            if(tracker_index != 0){
                let prev_key = x_tracker[tracker_index - 1]
                let prev_button: UIButton = board[prev_key]!
                let prev_button_content: String = prev_button.currentTitle!
                // Make sure that both points have the same x values, if not then it'll add points in different x positions
                if current_button_content == prev_button_content && prev_key.getY() == key.getY(){
                    // Now that the content of both buttons have been added, we have to remove the current key from the x_tracker array.
                    let result:String = add_button_content(current_button_string: current_button_content!, buttonsTwo: prev_button)
                    prev_button.setTitle(result, for: .normal)
                    x_tracker.remove(at: tracker_index)
                }else{
                    board[key]!.setTitle(current_button_content, for: .normal)
                    tracker_index += 1
                }
                
                
            }else{
                board[key]!.setTitle(current_button_content, for: .normal)
                tracker_index += 1
            }
            if key == key_before_shift{
                board_change_status = true
            }
//            board[key]!.setTitle(current_button_content, for: .normal)
//            tracker_index += 1
        }
        
    }
    private func helper_move_left(toPosition: Int, index: Int, local_key: Point,_ reset_difference: inout Int){
        if index == 0{
            local_key.setX(new_x: local_key.getX() - toPosition + reset_difference)
            reset_difference += 1
            return
        }
        let previous_key: Point = x_tracker[index - 1]
        if previous_key.getY() - local_key.getY() != 0 {
            reset_difference = 0
            local_key.setX(new_x: local_key.getX() - toPosition + reset_difference)
            reset_difference += 1
        }else{
            local_key.setX(new_x: local_key.getX() - toPosition + reset_difference)
            reset_difference += 1
        }
    }
    
    public func move_up(){
        var tracker_index = 0
        x_tracker.sort(by: <)
        var reset = 0
        while tracker_index < x_tracker.count {
            let key = x_tracker[tracker_index]
            let key_before_shift = key
            let current_button = board[key]
            let current_button_content = current_button?.currentTitle
            board[key]!.setTitle("", for: .normal)
            let y = key.getY()
            switch y {
            case 0:
                helper_move_up(toPosition: 0, index: tracker_index, local_key: key, &reset)
                break
            case 1:
                helper_move_up(toPosition: 1, index: tracker_index, local_key: key, &reset)
                break
            case 2:
                helper_move_up(toPosition: 2, index: tracker_index, local_key: key, &reset)
                break
            case 3:
                helper_move_up(toPosition: 3, index: tracker_index, local_key: key, &reset)
                break
            default:
                break
            }
            if(tracker_index != 0){
                let prev_key = x_tracker[tracker_index - 1]
                let prev_button: UIButton = board[prev_key]!
                let prev_button_content: String = prev_button.currentTitle!
                // Make sure that both points have the same x values, if not then it'll add points in different x positions
                if current_button_content == prev_button_content && prev_key.getX() == key.getX(){
                    // Now that the content of both buttons have been added, we have to remove the current key from the x_tracker array.
                    let result:String = add_button_content(current_button_string: current_button_content!, buttonsTwo: prev_button)
                    prev_button.setTitle(result, for: .normal)
                    x_tracker.remove(at: tracker_index)
                }else{
                    board[key]!.setTitle(current_button_content, for: .normal)
                    tracker_index += 1
                }
                
                
            }else{
                board[key]!.setTitle(current_button_content, for: .normal)
                tracker_index += 1
            }
            if key == key_before_shift{
                board_change_status = true
            }
            
        }
    }
    private func helper_move_up(toPosition: Int, index: Int, local_key: Point,_ reset_difference: inout Int) {
        if index == 0{
            local_key.setY(new_y: local_key.getY() - toPosition + reset_difference)
            reset_difference += 1
            return
        }
        let previous_key: Point = x_tracker[index - 1]
        if previous_key.getX() - local_key.getX() != 0 {
            reset_difference = 0
            local_key.setY(new_y: local_key.getY() - toPosition + reset_difference)
            reset_difference += 1
        }else{
            local_key.setY(new_y: local_key.getY() - toPosition + reset_difference)
            reset_difference += 1
        }
    }
    
    public func move_down() {
        var tracker_index = 0
        x_tracker.sort(by: >)
        var reset = 0
        while tracker_index < x_tracker.count {
            let key = x_tracker[tracker_index]
            let key_before_shift = key
            let current_button = board[key]
            let current_button_content = current_button?.currentTitle
            board[key]!.setTitle("", for: .normal)
            let y = key.getY()
            switch y {
            case 0:
                helper_move_down(toPosition: 3, index: tracker_index, local_key: key, &reset)
                break
            case 1:
                helper_move_down(toPosition: 2, index: tracker_index, local_key: key, &reset)
                break
            case 2:
                helper_move_down(toPosition: 1, index: tracker_index, local_key: key, &reset)
                break
            case 3:
                helper_move_down(toPosition: 0, index: tracker_index, local_key: key, &reset)
                break
            default:
                break
            }
            if(tracker_index != 0){
                let prev_key = x_tracker[tracker_index - 1]
                let prev_button: UIButton = board[prev_key]!
                let prev_button_content: String = prev_button.currentTitle!
                // Make sure that both points have the same x values, if not then it'll add points in different x positions
                if current_button_content == prev_button_content && prev_key.getX() == key.getX(){
                    // Now that the content of both buttons have been added, we have to remove the current key from the x_tracker array.
                    let result:String = add_button_content(current_button_string: current_button_content!, buttonsTwo: prev_button)
                    prev_button.setTitle(result, for: .normal)
                    x_tracker.remove(at: tracker_index)
                }else{
                    board[key]!.setTitle(current_button_content, for: .normal)
                    tracker_index += 1
                }
                
                
            }else{
                board[key]!.setTitle(current_button_content, for: .normal)
                tracker_index += 1
            }
            if key == key_before_shift{
                board_change_status = true
            }
//            print(key.toString() + "---->>> This is my key at: " + String(tracker_index) + "This is my value at the key: " + current_button_content!)
//            board[key]!.setTitle(current_button_content, for: .normal)
//            tracker_index += 1
        }
    }
    
    private func helper_move_down(toPosition: Int, index: Int, local_key: Point,_ reset_difference: inout Int){
        if index == 0{
            local_key.setY(new_y: local_key.getY() + toPosition - reset_difference)
            reset_difference += 1
            return
        }
        let previous_key: Point = x_tracker[index - 1]
        if previous_key.getX() - local_key.getX() != 0 {
            reset_difference = 0
            local_key.setY(new_y: local_key.getY() + toPosition - reset_difference)
            reset_difference += 1
        }else{
            local_key.setY(new_y: local_key.getY() + toPosition - reset_difference)
            reset_difference += 1
        }
    }
    
    private func add_button_content(current_button_string: String, buttonsTwo: UIButton) -> String{
        let firstInt = Int(current_button_string)
        let secondInt = Int(buttonsTwo.currentTitle!)
        let result:String = String(firstInt! + secondInt!)
        return result
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
