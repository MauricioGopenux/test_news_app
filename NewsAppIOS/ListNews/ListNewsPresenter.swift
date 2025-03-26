//
//  ListNewsPresenter.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//
protocol NewsPresenterProtocol: AnyObject {
    func newsLoaded(news: [News])
    func selectTabItem(favorite: Bool)
}

protocol UpdateNewsPresenterProtocol: AnyObject {
    func updateFavoriteListNews()
}

final class ListNewsPresenter {
    private var listNewsInteractor: ListNewsInteractor!
    private weak var newsViewProtocol: ListNewsViewProtocol?
    private var listNewsRouting: ListNewsRouting?
    var news: [News] = []
    
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
        listNewsRouting?.showDetailsNews(news: news)
    }
    
    func updateTabSelection(favorite: Bool) {
        selectTabItem(favorite: favorite)
        listNewsInteractor.updateListNews(favorite: favorite)
    }
}

extension ListNewsPresenter: NewsPresenterProtocol {
    func newsLoaded(news: [News]) {
        self.news = news
        newsViewProtocol?.updateTable()
    }
    
    func selectTabItem(favorite: Bool) {
        newsViewProtocol?.updateTabSelectionVC(favorites: favorite)
    }
}

extension ListNewsPresenter: UpdateNewsPresenterProtocol{
    func updateFavoriteListNews() {
            listNewsInteractor.updateFavoriteNews()
    }
}
