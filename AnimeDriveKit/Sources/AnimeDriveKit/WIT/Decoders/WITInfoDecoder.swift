import SwiftSoup

extension HTMLDecoder where Value == Info {
    static var infoDecoder: Self {
        .init { document in
            var info: [String: String] = [:]
            let keys = [
                "النوع:": "type",
                "بداية العرض:": "startDate",
                "حالة الأنمي:": "status",
                "عدد الحلقات:": "episodesCount",
                "مدة الحلقة:": "episodeDuration",
                "الموسم:": "season",
                "المصدر:": "source",
            ]
            
            let details = try document.select("div.anime-info").array()
            for detail in details {
                if let key = try detail.select("span").first()?.text().trimmed,
                   let value = try? detail.select("a").first()?.text().trimmed ?? detail.text().trimmed,
                   let mappedKey = keys[key] {
                    info[mappedKey] = value
                }
            }
            
            return Info(
                title: try document.select("h1.anime-details-title").first()?.text().trimmed ?? "",
                story: try document.select("p.anime-story").first()?.text().trimmed ?? "",
                genres: try document.select("ul.anime-genres a").array().map { try $0.text().trimmed },
                type: info["type"] ?? "",
                startDate: info["startDate"] ?? "",
                season: info["season"] ?? "",
                status: info["status"] ?? "",
                episodesCount: info["episodesCount"] ?? "",
                source: info["source"] ?? "",
                episodeDuration: info["episodeDuration"] ?? ""
            )
        }
    }
}
