//
//  String+Extension.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/29/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

extension String {
    
    func convertToFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        
        //pass in format of date string (reference www.NSDateFormatter.com, locale dropdown)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = dateFormatter.date(from: self) else { return "Date Unknown" }
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: date)
    }
}
