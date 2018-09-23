//
//  Page.swift
//  Coffee
//
//  Created by Michael Lema on 9/21/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class Page: UIViewController {
    fileprivate let identifier = "cell"

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var headerView: UIView!
    var headerMaskLayer: CAShapeLayer!
    
    let headingView: UIView = {
        let view = UIView()
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var text = String()
    var body = String()
    var count = String()
    var color = UIColor()

    func update(article: Article, count: String, color: UIColor) {
        self.text = article.title
        self.count = count
        self.color = color
        makeSummaryRequest(url: article.url)
        
        if let url = article.urlToImage {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: URL(string: url)!)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                }
            }
        } else {
            self.imageView.image = UIImage(named: "preview")
        }
    }
    
    fileprivate func modifySummaryText(text: String) {
        let text = text + " "
        self.body = text.replacingOccurrences(of: "[BREAK] ", with: "\n")
        if self.body.first == " " {
            self.body = String(self.body.dropFirst())
        }
    }
    
    func makeSummaryRequest(url: String) {
        let group = DispatchGroup()
        group.enter()
        let smmry = Summary()
        smmry.get(url: url) {
            group.leave()
        }
        group.notify(queue: DispatchQueue.main, execute: {
            self.modifySummaryText(text: smmry.content)
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: identifier)
        
        setupTableView()
        updateHeaderView()
        
        setupConstraints()
    }
    fileprivate func setupTableView() {
        //imageView.image = UIImage(named: "preview")
        headingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: Header.shared.height)
        headingView.addSubview(imageView)
        
        
        imageView.anchor(top: headingView.topAnchor, bottom: headingView.bottomAnchor, left: headingView.leftAnchor, right: headingView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        tableView.tableHeaderView = headingView
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        let effectiveHeight = Header.shared.height - Header.shared.cutOff/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y:  -Header.shared.height)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
    }
    
    func updateHeaderView() {
        let effectiveHeight = Header.shared.height - Header.shared.cutOff/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: Header.shared.height)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + Header.shared.cutOff/2
        }
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - Header.shared.cutOff))
        headerMaskLayer?.path = path.cgPath
    }
    
    func setupConstraints() {
        tableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension Page: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension Page: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ArticleCell
        cell.setup(count: count, color: color)
        cell.update(title: text, body: body)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension Page {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}
