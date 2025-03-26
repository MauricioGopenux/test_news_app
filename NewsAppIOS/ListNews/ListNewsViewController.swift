//
//  ListNewsViewController.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//

import UIKit

protocol ListNewsViewProtocol: AnyObject {
    func updateTable()
    func updateTabSelection(favorites: Bool)
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
        configureNavigationBar()
        listNewsPresenter.loadNews()
    }
    
    func setListNewsPresenter(listNewsPresenter: ListNewsPresenter) {
        self.listNewsPresenter = listNewsPresenter
    }

    private func configureNavigationBar() {
        navigationItem.title = "Gopenux News"
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = .black
    }
}

extension ListNewsViewController: ListNewsViewProtocol {
    func updateTable() {
            self.listNewsTableView.reloadData()
    }
    
    func updateTabSelection(favorites: Bool) {
            if favorites {
                self.tabBarListNews.selectedItem = self.tabBarListNews.items?.first
            } else {
                self.tabBarListNews.selectedItem = self.tabBarListNews.items?.last
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
               listNewsPresenter.updateTabSelection(favorite: true)
           } else if item.tag == 1 {
               listNewsPresenter.updateTabSelection(favorite: false)
           }
       }
}
