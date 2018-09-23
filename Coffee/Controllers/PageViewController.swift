//
//  PageViewController.swift
//  Coffee
//
//  Created by Michael Lema on 9/21/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController {
    let allColors: [UIColor] = [UIColor.App.blue,
                                UIColor.App.green,
                                UIColor.App.orange,
                                UIColor.App.brightGreen,
                                UIColor.App.pink,
                                UIColor.App.yellow,
                                UIColor.App.lightBlue,
                                UIColor.App.purple,
                                UIColor.App.lightGreen,
                                UIColor.App.darkOrange]
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "BackArrow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    fileprivate lazy var pages: [UIViewController] = {
        var pagesArray = [UIViewController]()
        for index in 1...10 {
            pagesArray.append(Page())
        }
        return pagesArray
    }()
    
    func setupPages(article: [Article]) {
        for (index, page) in pages.enumerated() {
            if let page = page as? Page {
                page.update(article: article[index], count: "\(index + 1)", color: allColors[index])
            }
        }
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing : 8])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        self.view.addSubview(dismissButton)
        
        dismissButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        
        if #available(iOS 11, *) {
            dismissButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        } else {
            dismissButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 5).isActive = true
        }
        dismissButton.anchor(top: nil, bottom: nil, left: view.leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: 40, height: 40)
    }
    
    @objc func dismissController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setViewController(index: Int) {
        let vc = pages[index]
        setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func moveToNextController() {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //let viewControllerIndex = pageViewController.viewControllers![0]
    }
}

