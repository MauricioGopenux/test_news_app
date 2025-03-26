//
//  ListNewsRouter.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//
protocol ListNewsRouting: AnyObject {
    func showDetailsNews(news: News)
}

class ListNewsRouter: ListNewsRouting {
    private weak var listNewsVC: ListNewsViewController!
    private var newsDetailsRouter: NewsDetailsRouter!
    
    func setListNewsViewController(listNewsVC: ListNewsViewController) {
        self.listNewsVC = listNewsVC
    }
    
    func setDetailsNewsRouter(newsDetailsRouter: NewsDetailsRouter) {
        self.newsDetailsRouter = newsDetailsRouter
    }
    
    func showDetailsNews(news: News) {
        newsDetailsRouter.showDetailNews(referenceVC: listNewsVC, news: news)
    }
}
