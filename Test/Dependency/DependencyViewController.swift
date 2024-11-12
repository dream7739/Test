//
//  DependencyViewController.swift
//  Test
//
//  Created by 홍정민 on 11/12/24.
//

import UIKit

final class DependencyViewController: UIViewController {
    //Property Wrapper
    @Dependency var restaurant: Restaurant

    override func viewDidLoad() {
        super.viewDidLoad()
        dependencyTest()
    }
     
    private func dependencyTest() {
        restaurant.showMenu()
    }
}


// DI를 하지 않는 경우
// Lunch와 Dinner 클래스를 소유함으로써 Restaurant는 의존성을 갖게 됨

// 생성자를 통한 DI
// Lunch와 Dinner의 내부 구현이 변경된다 하더라도, Restaurant 생성에 문제가 생기지 않음
// 의존성의 주입이 일어남

// 프로토콜을 통한 DIP
// 구체화된 클래스에 의존하는 것이 아닌 변화하기 어려운 인터페이스나 프로토콜에 의존
// 의존성의 역전이 일어남
// 프로토콜이 제어의 주체가 되기 때문에, 해당 프로토콜을 준수하는 모든 클래스를 제어, 분석하기 쉬워짐
protocol Menu: AnyObject {
    var name: String { get }
}

class Restaurant {
    let lunch: Menu //타입으로서의 프로토콜
    let dinner: Menu
    
    init(lunch: Menu, dinner: Menu) {
        self.lunch = lunch
        self.dinner = dinner
    }
    
    func showMenu() {
        print("점심메뉴는 \(lunch.name)이고 저녁메뉴는 \(dinner.name)입니다")
    }
}

// 타입을 임의로 변경하면, 프로토콜을 준수하지 않고 있다는 오류를 발생
class Lunch: Menu {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Dinner: Menu {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Breakfast: Menu {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}



