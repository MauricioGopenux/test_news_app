//
//  ListNewsRouter.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//
protocol ListNewsRouting: AnyObject {
    func showDetailMovie(news: News)
}

class ListNewsRouter: ListNewsRouting {
    private weak var listNewsVC: ListNewsViewController!
    private var newsDetailsRouter: NewsDetailsRouter!
    
    func setMoviesViewController(listNewsVC: ListNewsViewController) {
        self.listNewsVC = listNewsVC
    }
    
    func setDetailMovieRouter(newsDetailsRouter: NewsDetailsRouter) {
        self.newsDetailsRouter = newsDetailsRouter
    }
    
    func showDetailMovie(news: News) {
        newsDetailsRouter.showDetailNews(referenceVC: listNewsVC, news: news)
    }
}
