//
//  ViewController.swift
//  2048
//
//  Created by Daniel Palacio on 7/1/19.
//  Copyright © 2019 Daniel Palacio. All rights reserved.
//

import UIKit
private var m = Model()
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        populate_board()
        first_entry()
        //let swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(move_left))
        //swipe_left.direction = .left
        //self.view.addGestureRecognizer(swipe_left)
        print("This is x_tracker: " )
        m.print_tracker()
        print("----------")
        print("This is y_tracker: " )
        m.print_y_tracker()
        
    }
    
    private func populate_row(y: Int) -> UIStackView{
        let stack  = UIStackView(arrangedSubviews: createButtons(y_coordinate: y))
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.axis = .horizontal
        //view.addSubview(stack)
        //print(m.size())
        //m.getButton(Point: [0,0]).setTitle("1", for : .normal)
        return stack
    }
    private func populate_board(){
        let boardStack = UIStackView(arrangedSubviews: [populate_row(y: 0),populate_row(y: 1),populate_row(y: 2),populate_row(y: 3)])
        boardStack.translatesAutoresizingMaskIntoConstraints = false
        boardStack.distribution = .fillEqually
        boardStack.spacing = 10
        boardStack.axis = .vertical
        view.addSubview(boardStack)
        boardStack.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 0).isActive = true
        boardStack.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: 0).isActive = true
        boardStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        boardStack.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        boardStack.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(move_left))
        swipeLeft.direction = .left
        boardStack.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(move_right))
        swipeRight.direction = .right
        boardStack.addGestureRecognizer(swipeRight)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(move_down))
        swipeDown.direction = .down
        boardStack.addGestureRecognizer(swipeDown)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(move_up))
        swipeUp.direction = .up
        boardStack.addGestureRecognizer(swipeUp)
    }
    
    private func createButtons(y_coordinate: Int) -> [UIButton]{
        var x:Int = 0
        //var y:Int = 0 // Must be carried into populate_row function
        var list:Array<UIButton> = []
        while(x<4){
            let local_button = UIButton()
            local_button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            //local_button.setTitle("", for: .normal)
            local_button.translatesAutoresizingMaskIntoConstraints = false
            let local_point = Point(x_coordinate: x,y_coordinate: y_coordinate)
            m.add(point: local_point, current_button: local_button)
            m.add_to_unoccupied_points(unoccupiedPoint: local_point)
            list.append(local_button)
            x += 1
        }
        return list
    }
    @objc private func move_left(){
        print("This is x_tracker: " )
        m.print_tracker()
        print("----------")
        print("This is y_tracker: " )
        m.print_y_tracker()
        m.move_left()
        var new_random_point = m.randomPoint()
        while m.getButton(Point: new_random_point).currentTitle != nil {
            new_random_point = m.randomPoint()
        }
        m.add_to_x_tracker(occupiedPoint: new_random_point)
        m.add_to_y_tracker(occupiedPoint: new_random_point.flipXY())
        m.getButton(Point: new_random_point).setTitle(String(m.generate_even_entry()), for: .normal)
        m.move_ended()
        print("This is x_tracker: " )
        m.print_tracker()
        print("----------")
        print("This is y_tracker: " )
        m.print_y_tracker()
    }
    @objc private func move_right(){
        m.move_right()
        var new_random_point = m.randomPoint()
        print(new_random_point.toString())
        while m.getButton(Point: new_random_point).currentTitle != nil {
            new_random_point = m.randomPoint()
        }
        m.add_to_x_tracker(occupiedPoint: new_random_point)
        m.add_to_y_tracker(occupiedPoint: new_random_point.flipXY())
        m.getButton(Point: new_random_point).setTitle(String(m.generate_even_entry()), for: .normal)
        m.move_ended()
        
    }
    @objc private func move_down(){
        m.move_down()
        var new_random_point = m.randomPoint()
        while m.getButton(Point: new_random_point).currentTitle != nil {
            new_random_point = m.randomPoint()
        }
        m.add_to_x_tracker(occupiedPoint: new_random_point)
        m.add_to_y_tracker(occupiedPoint: new_random_point.flipXY())
        m.getButton(Point: new_random_point).setTitle(String(m.generate_even_entry()), for: .normal)
        m.move_ended()
    }
    @objc private func move_up(){
        m.move_up()
        var new_random_point = m.randomPoint()
        while m.getButton(Point: new_random_point).currentTitle != nil {
            new_random_point = m.randomPoint()
        }
        m.add_to_x_tracker(occupiedPoint: new_random_point)
        m.add_to_y_tracker(occupiedPoint: new_random_point.flipXY())
        m.getButton(Point: new_random_point).setTitle(String(m.generate_even_entry()), for: .normal)
        m.move_ended()
    }
    private func first_entry(){
        let first_random_point = Point(x_coordinate: 1, y_coordinate: 1)
        m.getButton(Point: first_random_point).setTitle(String(2), for: .normal)
        m.add_to_x_tracker(occupiedPoint: first_random_point)
        var second_random_point = Point(x_coordinate: 2, y_coordinate: 1)
        while(first_random_point==second_random_point){
            second_random_point = m.randomPoint()
        }
        m.add_to_x_tracker(occupiedPoint: second_random_point)
        m.add_to_y_tracker(occupiedPoint: second_random_point.flipXY())
        m.add_to_y_tracker(occupiedPoint: first_random_point.flipXY())
        m.getButton(Point: second_random_point).setTitle(String(m.generate_even_entry()), for: .normal)
        m.getButton(Point: second_random_point).setTitle(String(2), for: .normal)
    }


}

