//
//  ListNewsPresenter.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//
protocol NewsPresenterProtocol {
    func newsLoaded(news: [News])
    func updateTabSelection(favorite: Bool)
    func updateListNews()
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
        initializeListNews()
    }
    
    func initializeListNews() {
        listNewsInteractor.thereFavoriteNews()
    }
    
    func showNewsDetails(indexPath: Int) {
        let news: News = news[indexPath]
        listNewsRouting?.showDetailsNews(news: news)
    }
}

extension ListNewsPresenter: NewsPresenterProtocol {
    func newsLoaded(news: [News]) {
        self.news = news
        newsViewProtocol?.updateTable()
    }
    
    func updateTabSelection(favorite: Bool) {
        self.showFavorites = favorite
        newsViewProtocol?.updateTabSelection(favorites: showFavorites)
        updateListNews()
    }
    
    func updateListNews() {
        listNewsInteractor.applyFilter(favorite: showFavorites)
    }
}
