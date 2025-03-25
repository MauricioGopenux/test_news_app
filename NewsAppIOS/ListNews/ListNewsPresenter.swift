//
//  ListNewsPresenter.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//
protocol NewsPresenterProtocol {
    func newsLoaded(news: [News])
    func updateListForFilter()
}

final class ListNewsPresenter {
    private var listNewsInteractor: ListNewsInteractor!
    private weak var newsViewProtocol: ListNewsViewProtocol?
    private var listNewsRouting: ListNewsRouting?
    var news: [News] = []
    private var showFavorites = true
    
    func setListNewsInteractor(listNewsInteractor: ListNewsInteractor) {
        self.listNewsInteractor = listNewsInteractor
    }
    
    func setListNewsViewProtocol(newsViewProtocol: ListNewsViewProtocol) {
        self.newsViewProtocol = newsViewProtocol
    }
    
    func setNews(news: [News]) {
        self.news = news
    }
    
    func setListNewsRouter(listNewsRouting: ListNewsRouting) {
        self.listNewsRouting = listNewsRouting
    }
    
    func loadNews() {
        listNewsInteractor.syncNews()
    }
    
    func showNewsDetails(indexPath: Int) {
        let news: News = news[indexPath]
        listNewsRouting?.showDetailMovie(news: news)
    }
    
    func toggleFavoritesFilter(showFavorites: Bool) {
        self.showFavorites = showFavorites
        updateListForFilter()
       }
}

extension ListNewsPresenter: NewsPresenterProtocol {
    func newsLoaded(news: [News]) {
        self.news = news
        newsViewProtocol?.updateTable()
    }
    
    func updateListForFilter() {
        listNewsInteractor.applyFilter(favorite: showFavorites)
    }
}
