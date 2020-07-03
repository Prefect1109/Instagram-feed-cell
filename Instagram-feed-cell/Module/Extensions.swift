//
//  Extensions.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 30.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation

extension Date {
    func timeAgo() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = minute * 60
        let day = 24 * hour
        let week = 7 * day
        let month = 30 * day
        
        let quotient: Int
        let unit: String
        
        if secondsAgo < 5 {
            quotient = 0
            unit = "Just now"
        } else if secondsAgo < minute {
            quotient = secondsAgo
            if quotient > 1 {
                unit = "seconds"
            } else {
                unit = "second"
            }
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            if quotient > 1 {
                unit = "minutes"
            } else {
                unit = "minute"
            }
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            if quotient > 1 {
                unit = "hours"
            } else {
                unit = "hour"
            }
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            if quotient > 1 {
                unit = "days"
            } else {
                unit = "day"
            }
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            if quotient > 1 {
                unit = "weeks"
            } else {
                unit = "week"
            }
        } else {
            quotient = 0
            let formatter = DateFormatter()
            formatter.dateFormat = "ddmmmmyyyy"
            unit = formatter.string(from: self)
        }
        
        let quotientStr = quotient > 0 ? "\(quotient) " : ""
        let postfix = quotientStr.isEmpty ? "" : " ago"
        let result = quotientStr + unit + postfix
        return result
    }
}
