//
//  NasaViewController.swift
//  Test
//
//  Created by 홍정민 on 11/7/24.
//

import UIKit
import SnapKit
import Toast

final class NasaViewController: UIViewController {
    private let nasaImageView1 = UIImageView()
    private let nasaImageView2 = UIImageView()
    private let nasaImageView3 = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureUI()
        fetchMultipleImage()
//        fetchImageByGCD()
//        fetchImageByConcurrency()
    }
    
    private func configureHierarchy() {
        view.addSubview(nasaImageView1)
        view.addSubview(nasaImageView2)
        view.addSubview(nasaImageView3)
    }
    
    private func configureLayout() {
        nasaImageView1.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        nasaImageView2.snp.makeConstraints { make in
            make.top.equalTo(nasaImageView1.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        nasaImageView3.snp.makeConstraints { make in
            make.top.equalTo(nasaImageView2.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
    }
    
    private func configureUI() {
        nasaImageView1.backgroundColor = .red
        nasaImageView2.backgroundColor = .green
        nasaImageView3.backgroundColor = .blue
    }
}

extension NasaViewController {
    private func fetchImageByGCD() {
        print("11111", Thread.isMainThread)

        APIManager.shared.callNetworkByGCD(Nasa.photo) { [weak self] image, error in
            guard let self = self else { return }
            
            print("22222", Thread.isMainThread)
            if let error {
                self.view.makeToast("오류가 발생하였습니다")
                return
            }
            
            if let image {
                self.nasaImageView1.image = image
            } else {
                self.view.makeToast("오류가 발생하였습니다")
            }

        }
        print("33333", Thread.isMainThread)

    }
    
    private func fetchImageByConcurrency() {
        print("11111", Thread.isMainThread)
        Task {
            do {
                print("22222", Thread.isMainThread)
                let image = try await APIManager.shared.callNetworkByConcurrency(Nasa.photo)
                print("33333", Thread.isMainThread)
                nasaImageView2.image = image
            } catch {
                self.view.makeToast("오류가 발생하였습니다")
            }
        }
        print("44444", Thread.isMainThread)

    }
    
    private func fetchMultipleImage() {
        let url1 = Nasa.one.photoURL
        let url2 = Nasa.two.photoURL
        let url3 = Nasa.three.photoURL

        Task {
            async let image1 = APIManager.shared.callNetworkByConcurrency(url1)
            async let image2 = APIManager.shared.callNetworkByConcurrency(url2)
            async let image3 = APIManager.shared.callNetworkByConcurrency(url3)
            let images = try await [image1, image2, image3]
            nasaImageView1.image = images[0]
            nasaImageView2.image = images[1]
            nasaImageView3.image = images[2]
        }
        
    }
}


extension NasaViewController {
    enum Nasa: String, CaseIterable {
        
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
        
        var photoURL: URL {
            return URL(string: Nasa.baseURL + self.rawValue)!
        }
        
        static var photo: URL {
            return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
}
