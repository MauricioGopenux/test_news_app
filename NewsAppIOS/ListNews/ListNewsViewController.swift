//
//  ListNewsViewController.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//

import UIKit

protocol ListNewsViewProtocol: AnyObject {
    func updateTable()
}

class ListNewsViewController: UIViewController {
    private var listNewsPresenter: ListNewsPresenter!
    
    @IBOutlet weak var tabBarListNews: UITabBar!
    @IBOutlet weak var listNewsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listNewsTableView.register(UINib(nibName: "ListNewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        listNewsTableView.dataSource = self
        listNewsTableView.delegate = self
        tabBarListNews.delegate = self
        listNewsPresenter.loadNews()
    }
    
    func setListNewsPresenter(listNewsPresenter: ListNewsPresenter) {
        self.listNewsPresenter = listNewsPresenter
    }
}

extension ListNewsViewController: ListNewsViewProtocol {
    func updateTable() {
        DispatchQueue.main.async {
            self.listNewsTableView.reloadData()
        }
    }
}

extension ListNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listNewsPresenter.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listNewsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! ListNewsCell

        let news: News = listNewsPresenter.news[indexPath.item]
        cell.config(news: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listNewsPresenter.showNewsDetails(indexPath: indexPath.row)
    }
}

extension ListNewsViewController: UITabBarDelegate {
    func tabBar(_ tabBarListNews: UITabBar, didSelect item: UITabBarItem) {
           if item.tag == 0 {
               listNewsPresenter.toggleFavoritesFilter(showFavorites: true)
           } else if item.tag == 1 {
               listNewsPresenter.toggleFavoritesFilter(showFavorites: false)
           }
       }
}
