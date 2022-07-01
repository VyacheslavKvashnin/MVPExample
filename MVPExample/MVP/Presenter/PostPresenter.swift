//
//  Presenter.swift
//  MVPExample
//
//  Created by Вячеслав Квашнин on 01.07.2022.
//

import Foundation
import UIKit

protocol PostPresenterDelegate: AnyObject {
    func presentPosts(posts: [Post])
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = PostPresenterDelegate & UIViewController

class PostPresenter {
    
    weak var delegate: PresenterDelegate?
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode([Post].self, from: data)
                self?.delegate?.presentPosts(posts: result)
            } catch {
                print("Error ", error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
}
