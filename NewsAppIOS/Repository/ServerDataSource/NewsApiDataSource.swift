//
//  NewsApiRepository.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//
import Foundation

class NewsApiDataSource {
    func fetchNewsFromAPI() async -> [News] {
        let url = URL(string: "https://newsapi.org/v2/everything?q=apple&from=2025-03-24&to=2025-03-24&sortBy=popularity&apiKey=2b1017c779664d54ad0dece2dbafa61c")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            return newsResponse.articles
        } catch {
            print("Error al obtener o guardar noticias: \(error)")
            return []
        }
    }
}
