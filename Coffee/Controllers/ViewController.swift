//
//  ViewController.swift
//  Coffee
//http://blog.matthewcheok.com/design-teardown-stretchy-headers/
//  Created by Michael Lema on 9/16/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let identifier = "cell"

    var headerView: UIView!
    var headerMaskLayer: CAShapeLayer!

    let headingView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var footerView: FooterView = {
        let footerView =  FooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.5))
        return footerView
    }()
    
    let request = RequestNews()
    let pvc = PageViewController()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 34)
        label.textColor = UIColor(red:0.98, green:1.00, blue:1.00, alpha:1.00)
        return label
    }()
    
    let dateSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor(red:0.98, green:1.00, blue:1.00, alpha:1.00)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNewsRequest()
        setupDateLabels()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: identifier)
        tableView.tableFooterView = footerView
        tableView.backgroundColor = UserDefaults.standard.isDarkMode() ? .black : .white
        
        setupTableView()
        updateHeaderView()
        configureReadStories()
    }
    
    func makeNewsRequest() {
        let group = DispatchGroup()
        group.enter()
        
        request.get() {
            group.leave()
        }
        group.notify(queue: DispatchQueue.main, execute: {
            //synchronously
            if let url = self.request.articles[0].urlToImage {
                let url = URL(string: url)
                let data = try? Data(contentsOf: url!)
                self.imageView.image = UIImage(data: data!)
            } else {
                self.imageView.image = UIImage(named: "preview")
            }
            self.pvc.setupPages(article: self.request.articles)
            self.tableView.reloadData()
        })
    }
    
    fileprivate func setupDateLabels() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        dateLabel.text = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: date).lowercased()
        dateFormatter.dateFormat = "a"
        let ending = dateFormatter.string(from: date) == "AM" ? " morning | US" : " evening | US"
        UserDefaults.standard.setDarkMode(value: dateFormatter.string(from: date) == "AM" ? true : false)
        dateSubLabel.text = day + ending
    }
    
    func configureReadStories() {
        //UserDefaults.standard.setValue(nil, forKey: UserDefaults.UserDefaultKeys.newsRead.rawValue)
        let now = Date()
        let lastSignedIn = UserDefaults.standard.getDate()
        let hoursPassed = Calendar.current.dateComponents([.hour], from: lastSignedIn, to: now).hour ?? 0
        if hoursPassed >= 6 {
            UserDefaults.standard.setValue(nil, forKey: UserDefaults.UserDefaultKeys.newsRead.rawValue)
        }
    }
    
    fileprivate func setupTableView() {
        headingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: Header.shared.height)
        headingView.addSubview(imageView)
        headingView.addSubview(dateLabel)
        headingView.addSubview(dateSubLabel)
        let topPadding = Header.shared.height * 0.12
        imageView.anchor(top: headingView.topAnchor, bottom: headingView.bottomAnchor, left: headingView.leftAnchor, right: headingView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        dateLabel.anchor(top: headingView.topAnchor, bottom: nil, left: headingView.leftAnchor, right:headingView.rightAnchor, paddingTop: topPadding, paddingBottom: 0, paddingLeft: 12, paddingRight: 20, width: 0, height: 30)
        dateSubLabel.anchor(top: dateLabel.bottomAnchor, bottom: nil, left: headingView.leftAnchor, right: nil, paddingTop: 6, paddingBottom: 0, paddingLeft: 12, paddingRight: 20, width: 200, height: 18)
        
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        tableView.reloadData()
        footerView.updateViews()
    }
    
}


//: tableView DataSource
extension ViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NewsCell
        cell.setup(color: UIColor.App.allColors[indexPath.item], index: indexPath)
        if !request.articles.isEmpty {
            let article = request.articles[indexPath.item]
            cell.update(title: article.title, source: article.source.id ?? article.source.name)
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.App.allColors[indexPath.item].withAlphaComponent(0.45)
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}


//: tableView Delegate
extension ViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height - Header.shared.height
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.setNewsAsRead(value: indexPath.item + 1)
        footerView.updateReadCount(index: indexPath, fillColor: UIColor.App.allColors[indexPath.item])
        pvc.setViewController(index: indexPath.item)
        self.navigationController?.pushViewController(pvc, animated: true)
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()
    }
}


//: scrollView
extension ViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
        
//        let  height = scrollView.frame.size.height
//        let contentYoffset = scrollView.contentOffset.y
//        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
//        if distanceFromBottom < height {
//            // We are at the bottom
//        }
    }
}
