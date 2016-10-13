//
//  NSCalendar+CalendarAdditions.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

extension Calendar {
    static func gregorianCalendar() -> Calendar {
        return Calendar(identifier: Calendar.Identifier.gregorian)
    }
    
    func dateWithYear(_ year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        return date(from: components)!
    }
    
    func dateForTomorrowRelativeToToday(_ today: Date) -> Date {
        var tomorrowComponents = DateComponents()
        tomorrowComponents.day = 1
        return date(byAdding: tomorrowComponents, to: today, wrappingComponents: false)!

    }
    
    func dateForEndOfWeekWithDate(_ date: Date) -> Date {
        let daysRemainingThisWeek = daysRemainingInWeekWithDate(date)
        var remainingDaysComponent = DateComponents()
        remainingDaysComponent.day = daysRemainingThisWeek
        return self.date(byAdding: remainingDaysComponent, to: date, wrappingComponents: false)!
    }
    
    func dateForBeginningOfDay(_ date: Date) -> Date {
        let newComponent = dateComponents(([.year, .month, .day]), from: date)
        let newDate = self.date(from: newComponent)
        return newDate!
    }
    
    func dateForEndOfDay(_ date: Date) -> Date {
        var components = DateComponents()
        components.day = 1
        let toDate = dateForBeginningOfDay(date)
        let nextDay = self.date(byAdding: components, to: toDate, wrappingComponents: false)!
//        let endDay = nextDay.dateByAddingTimeInterval(-1)
        return nextDay
    }
    
    func daysRemainingInWeekWithDate(_ date: Date) -> Int {
        let weekdayComponent = dateComponents([.weekday], from: date)
        let daysRange = CountableRange(range(of: .weekday, in: .weekOfYear, for: date)!)
        let daysPerWeek = daysRange.count
        let daysRemaining = daysPerWeek - weekdayComponent.weekday!
        return daysRemaining
    }
    
    func dateForEndOfFollowingWeekWithDate(_ date: Date) -> Date {
        let endOfWeek = dateForEndOfWeekWithDate(date)
        var nextWeekComponent = DateComponents()
        nextWeekComponent.weekOfYear = 1
        let followingWeekDate = self.date(byAdding: nextWeekComponent, to: endOfWeek, wrappingComponents: false)
        return followingWeekDate!
    }
    
    func isDate(_ date: Date, beforeYearMonthDay: Date) -> Bool {
        let comparison = compareYearMonthDay(date, toYearMonthDay: beforeYearMonthDay)
        let result = comparison == ComparisonResult.orderedAscending
        return result
    }
    
    func isDate(_ date: Date, equalToYearMonthDay: Date) -> Bool {
        let comparison = compareYearMonthDay(date, toYearMonthDay: equalToYearMonthDay)
        let result = comparison == ComparisonResult.orderedSame
        return result
    }
    
    func isDate(_ date: Date, duringSameWeekAsDate: Date) -> Bool {
        let dateC = dateComponents([.weekOfYear], from: date)
        let duringSameWeekComponents = dateComponents([.weekOfYear], from: duringSameWeekAsDate)
        let result = dateC.weekOfYear == duringSameWeekComponents.weekOfYear
        return result
    }
    
    func isDate(_ date: Date, duringWeekAfterDate: Date) -> Bool {
        let nextWeek = dateForEndOfFollowingWeekWithDate(duringWeekAfterDate)
        let dateC = dateComponents([.weekOfYear], from: date)
        let nextWeekComponents = dateComponents([.weekOfYear], from: nextWeek)
        let result = dateC.weekOfYear == nextWeekComponents.weekOfYear
        return result
    }
    
    func compareYearMonthDay(_ date: Date, toYearMonthDay: Date) -> ComparisonResult {
        let dateComponents = yearMonthDayComponentsFromDate(date)
        let yearMonthDayComponents = yearMonthDayComponentsFromDate(toYearMonthDay)
        
        var result = compareInteger(dateComponents.year!, right: yearMonthDayComponents.year!)
        
        if result == ComparisonResult.orderedSame {
            result = compareInteger(dateComponents.month!, right: yearMonthDayComponents.month!)
            
            if result == ComparisonResult.orderedSame {
                result = compareInteger(dateComponents.day!, right: yearMonthDayComponents.day!)
            }
        }
        
        return result
    }
    
    func yearMonthDayComponentsFromDate(_ date: Date) -> DateComponents {
        let newComponents = dateComponents(([.year, .month, .day]), from: date)
        return newComponents
    }
    
    func compareInteger(_ left: Int, right: Int) -> ComparisonResult {
        var result = ComparisonResult.orderedDescending
        
        if left == right {
            result = ComparisonResult.orderedSame
        } else if left < right {
            result = ComparisonResult.orderedAscending
        } else {
            result = ComparisonResult.orderedDescending
        }
        
        return result
    }
    
    func nearTermRelationForDate(_ date: Date, relativeToToday: Date) -> NearTermDateRelation {
        var relation = NearTermDateRelation.outOfRange
        
        let dateForTomorrow = dateForTomorrowRelativeToToday(relativeToToday)
        
        let isDateBeforeYearMonthDay = isDate(date, beforeYearMonthDay: relativeToToday)
        let isDateEqualToYearMonthDay = isDate(date, equalToYearMonthDay: relativeToToday)
        let isDateEqualToYearMonthDayRelativeToTomorrow = isDate(date, equalToYearMonthDay: dateForTomorrow)
        let isDateDuringSameWeekAsDate = isDate(date, duringSameWeekAsDate: relativeToToday)
        let isDateDuringSameWeekAfterDate = isDate(date, duringWeekAfterDate: relativeToToday)
        
        if isDateBeforeYearMonthDay {
            relation = NearTermDateRelation.outOfRange
        } else if isDateEqualToYearMonthDay {
            relation = NearTermDateRelation.today
        } else if isDateEqualToYearMonthDayRelativeToTomorrow {
            let isRelativeDateDuringSameWeek = isDate(relativeToToday, duringSameWeekAsDate: date)

            if isRelativeDateDuringSameWeek {
                relation = NearTermDateRelation.tomorrow
            } else {
                relation = NearTermDateRelation.nextWeek
            }
        } else if isDateDuringSameWeekAsDate {
            relation = NearTermDateRelation.laterThisWeek
        } else if isDateDuringSameWeekAfterDate {
            relation = NearTermDateRelation.nextWeek
        }
        
        return relation
    }
}
