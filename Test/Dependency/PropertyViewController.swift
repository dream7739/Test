//
//  PropertyViewController.swift
//  Test
//
//  Created by 홍정민 on 11/12/24.
//

import UIKit

final class PropertyViewController: UIViewController {
    @UpperCase("dog") var dog
    @UpperCase("cat") var cat
    @RandomDog var randomDog
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("개는 \(dog) 고양이는 \(cat)")
        print("강아지 이름은 \(randomDog.name)")
        
        var dogPark = DogPark()
        dogPark.dog = 포메라니안(name: "홍포메", age: 12)
        print("공원에 있는 강아지는 \(dogPark.dog)")
        print("강아지는 늙었나요? \(dogPark.$dog)") //Projected Value
    }
}

// 행동에 대해 정의할 수 있는 특정 타입을 만들기
@propertyWrapper
struct UpperCase {
    private var name: String = ""
    
    var wrappedValue: String {
        get {
            self.name
        }
        set {
            self.name = newValue.uppercased()
        }
    }
    
    init(_ wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}


@propertyWrapper
struct RandomDog {
    private var randomDog: Dog
    private(set) var projectedValue: Bool
    
    var dogList: [Dog] = [
        푸들(name: "푸들", age: 3),
        포메라니안(name: "포메라니안", age: 10),
        삽살개(name: "삽살개", age: 12)
    ]
    
    var wrappedValue: Dog {
        get {
            return randomDog
        }
        set {
            randomDog = newValue
            
            if randomDog.age >= 10 {
                projectedValue = true
            } else {
                projectedValue = false
            }
        }
    }
    
    init() {
        self.projectedValue = false
        self.randomDog = dogList.randomElement()!
    }
    
}

struct DogPark {
    @RandomDog var dog: Dog
}

protocol Animal {
    var name: String { get }
    var age: Int { get }
    func introduce()
}

protocol Dog: Animal { }

struct 푸들: Dog {
    var name: String
    var age: Int
    
    func introduce() {
        print(name)
    }
}

struct 포메라니안: Dog {
    var name: String
    var age: Int
    
    func introduce() {
        print(name)
    }
}

struct 삽살개: Dog {
    var name: String
    var age: Int
    
    func introduce() {
        print(name)
    }
}
