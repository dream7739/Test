//
//  ContinuationViewController.swift
//  Test
//
//  Created by 홍정민 on 11/11/24.
//

import UIKit
import SnapKit

final class ContinuationViewController: UIViewController {
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        run()
        runThrow()
        runResult()
    }
    
    private func configureHierarchy() {
        view.addSubview(imageView)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
    
}

extension ContinuationViewController {
    func request(completion: (String) -> Void) {
        completion("Hello")
    }
    
    // withCheckedContinuation
    func requestAsync() async -> String {
        return await withCheckedContinuation { continuation in
            request {
                continuation.resume(returning: $0)
            }
        }
    }
    
    // withCheckedThrowingContinuation
    func requestAsyncThrow() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            request { _ in
                continuation.resume(
                    throwing: NSError(
                        domain: "sample",
                        code: 1
                    )
                )
            }
        }
    }
    
    // withCheckedContinuation + ResultType
    func requestAsyncResult() async -> Result<String, NSError> {
        return await withCheckedContinuation { continuation in
            request {
                continuation.resume(returning: .success($0))
            }
        }
    }
    
    func run() {
        Task {
            let result = await requestAsync()
            print(result)
        }
    }
    
    func runThrow() {
        Task {
            do {
                let result = try await requestAsyncThrow()
                print(result)
            } catch {
                print(error)
            }
        }
    }
    
    func runResult() {
        Task {
            let result = await requestAsyncResult()
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
