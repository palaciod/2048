//
//  Point.swift
//  2048
//
//  Created by Daniel Palacio on 7/5/19.
//  Copyright © 2019 Daniel Palacio. All rights reserved.
//

import Foundation
class Point: Hashable{
    var x: Int
    var y: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.getX() == rhs.getX() && lhs.getY() == rhs.getY()
    }
    static func < (lhs: Point, rhs: Point) -> Bool {
        if(lhs.getX()<rhs.getX()){
            return true
        }
        if(lhs.getX() == rhs.getX()){
            if(lhs.getY() < rhs.getY()){
                return true
            }
        }
        return false
    }
    
    static func > (lhs: Point, rhs: Point) -> Bool {
        if(lhs.getX()>rhs.getX()){
            return true
        }
        if(lhs.getX() == rhs.getX()){
            if(lhs.getY()>rhs.getY()){
                return true
            }
        }
        return false
    }
    
    init(x_coordinate: Int, y_coordinate: Int) {
        x = x_coordinate
        y = y_coordinate
    }
    public func getX() -> Int {
        return x
    }
    public func getY() -> Int {
        return y
    }
    public func setX(new_x: Int){
        x = new_x
    }
    public func setY(new_y: Int){
        y = new_y
    }
    public func setLocation(new_x: Int,new_y: Int){
        x = new_x
        y = new_y
    }
    public func getLocation() -> Point {
        return self
    }
    
    public func flipXY() -> Point{
        return Point(x_coordinate: y, y_coordinate: x)
    }
    
    public func toString() -> String {
        return "{" + String(getX()) + "," + String(getY()) + "}"
    }
    
    
    
    
}
