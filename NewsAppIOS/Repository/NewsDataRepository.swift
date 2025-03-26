//
//  NewsDataRepository.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//
protocol NewsRepository {
    func syncNews() async -> [News]
    func getNews() -> [News]
    func saveNewsList(newsList: [News])
    func updateNews(news: News)
    func deleteNews(news: News)
}

class NewsDataRepository: NewsRepository {
    private let newsDiskDataSource: NewsDiskDataSource
    private let newsApiDataSource: NewsApiDataSource
    
    init(newsDiskDataSource: NewsDiskDataSource, newsApiDataSource: NewsApiDataSource) {
        self.newsDiskDataSource = newsDiskDataSource
        self.newsApiDataSource = newsApiDataSource
    }
    
    func syncNews() async -> [News]{
        await newsApiDataSource.fetchNewsFromAPI()
    }
    
    func getNews() -> [News] {
        newsDiskDataSource.getNews()
    }
    
    func saveNewsList(newsList: [News]) {
        newsDiskDataSource.saveNewsList(newsList: newsList)
    }
    
    func updateNews(news: News) {
        newsDiskDataSource.updateNews(news: news)
    }
    
    func deleteNews(news: News) {
        newsDiskDataSource.deleteNews(news: news)
    }
}
