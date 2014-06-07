//
//  NSCalendar+CalendarAdditions.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

extension NSCalendar {
    class func gregorianCalendar() -> NSCalendar {
        return NSCalendar(calendarIdentifier: NSGregorianCalendar)
    }
    
    func dateWithYear(year: Int, month: Int, day: Int) -> NSDate {
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        return dateFromComponents(components)
    }
    
    func dateForTomorrowRelativeToToday(today: NSDate) -> NSDate {
        let tomorrowComponents = NSDateComponents()
        tomorrowComponents.day = 1
        return dateByAddingComponents(tomorrowComponents, toDate: today, options: nil)
    }
    
    func dateForEndOfWeekWithDate(date: NSDate) -> NSDate {
        let daysRemainingThisWeek = daysRemainingInWeekWithDate(date)
        let remainingDaysComponent = NSDateComponents()
        remainingDaysComponent.day = daysRemainingThisWeek
        return dateByAddingComponents(remainingDaysComponent, toDate: date, options: nil)
    }
    
    func dateForBeginningOfDay(date: NSDate) -> NSDate {
        let newComponent = components((NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay), fromDate: date)
        let newDate = dateFromComponents(newComponent)
        return newDate
    }
    
    func dateForEndOfDay(date: NSDate) -> NSDate {
        let components = NSDateComponents()
        components.day = 1
        let toDate = dateForBeginningOfDay(date)
        let nextDay = dateByAddingComponents(components, toDate: toDate, options: nil)
        let endDay = nextDay.dateByAddingTimeInterval(-1)
        return nextDay
    }
    
    func daysRemainingInWeekWithDate(date: NSDate) -> Int {
        let weekdayComponent = components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: date)
        let daysRange = rangeOfUnit(NSCalendarUnit.WeekdayCalendarUnit, inUnit: NSCalendarUnit.WeekCalendarUnit, forDate: date)
        let daysPerWeek = daysRange.length
        let daysRemaining = daysPerWeek - weekdayComponent.weekday
        return daysRemaining
    }
    
    func dateForEndOfFollowingWeekWithDate(date: NSDate) -> NSDate {
        let endOfWeek = dateForEndOfWeekWithDate(date)
        let nextWeekComponent = NSDateComponents()
        nextWeekComponent.setWeek(1)
        let followingWeekDate = dateByAddingComponents(nextWeekComponent, toDate: endOfWeek, options: nil)
        return followingWeekDate
    }
    
    func isDate(date: NSDate, beforeYearMonthDay: NSDate) -> Bool {
        let comparison = compareYearMonthDay(date, toYearMonthDay: beforeYearMonthDay)
        let result = comparison == NSComparisonResult.OrderedAscending
        return result
    }
    
    func isDate(date: NSDate, equalToYearMonthDay: NSDate) -> Bool {
        let comparison = compareYearMonthDay(date, toYearMonthDay: equalToYearMonthDay)
        let result = comparison == NSComparisonResult.OrderedSame
        return result
    }
    
    func isDate(date: NSDate, duringSameWeekAsDate: NSDate) -> Bool {
        let dateComponents = components(NSCalendarUnit.WeekCalendarUnit, fromDate: date)
        let duringSameWeekComponents = components(NSCalendarUnit.WeekCalendarUnit, fromDate: duringSameWeekAsDate)
        let result = dateComponents.week() == duringSameWeekComponents.week()
        return result
    }
    
    func isDate(date: NSDate, duringWeekAfterDate: NSDate) -> Bool {
        let nextWeek = dateForEndOfFollowingWeekWithDate(duringWeekAfterDate)
        let dateComponents = components(NSCalendarUnit.WeekCalendarUnit, fromDate: date)
        let nextWeekComponents = components(NSCalendarUnit.WeekCalendarUnit, fromDate: nextWeek)
        let result = dateComponents.week() == nextWeekComponents.week()
        return result
    }
    
    func compareYearMonthDay(date: NSDate, toYearMonthDay: NSDate) -> NSComparisonResult {
        let dateComponents = yearMonthDayComponentsFromDate(date)
        let yearMonthDayComponents = yearMonthDayComponentsFromDate(toYearMonthDay)
        
        var result = compareInteger(dateComponents.year, right: yearMonthDayComponents.year)
        
        if result == NSComparisonResult.OrderedSame {
            result = compareInteger(dateComponents.month, right: yearMonthDayComponents.month)
            
            if result == NSComparisonResult.OrderedSame {
                result = compareInteger(dateComponents.day, right: yearMonthDayComponents.day)
            }
        }
        
        return result
    }
    
    func yearMonthDayComponentsFromDate(date: NSDate) -> NSDateComponents {
        let newComponents = components((NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay), fromDate: date)
        return newComponents
    }
    
    func compareInteger(left: Int, right: Int) -> NSComparisonResult {
        var result = NSComparisonResult.OrderedDescending
        
        if left == right {
            result = NSComparisonResult.OrderedSame
        } else if left < right {
            result = NSComparisonResult.OrderedAscending
        } else {
            result = NSComparisonResult.OrderedDescending
        }
        
        return result
    }
    
    func nearTermRelationForDate(date: NSDate, relativeToToday: NSDate) -> NearTermDateRelation {
        var relation = NearTermDateRelation.OutOfRange
        
        let dateForTomorrow = dateForTomorrowRelativeToToday(relativeToToday)
        
        let isDateBeforeYearMonthDay = isDate(date, beforeYearMonthDay: relativeToToday)
        let isDateEqualToYearMonthDay = isDate(date, equalToYearMonthDay: relativeToToday)
        let isDateEqualToYearMonthDayRelativeToTomorrow = isDate(date, equalToYearMonthDay: dateForTomorrow)
        let isDateDuringSameWeekAsDate = isDate(date, duringSameWeekAsDate: relativeToToday)
        let isDateDuringSameWeekAfterDate = isDate(date, duringWeekAfterDate: relativeToToday)
        
        if isDateBeforeYearMonthDay {
            relation = NearTermDateRelation.OutOfRange
        } else if isDateEqualToYearMonthDay {
            relation = NearTermDateRelation.Today
        } else if isDateEqualToYearMonthDayRelativeToTomorrow {
            let isRelativeDateDuringSameWeek = isDate(relativeToToday, duringSameWeekAsDate: date)

            if isRelativeDateDuringSameWeek {
                relation = NearTermDateRelation.Tomorrow
            } else {
                relation = NearTermDateRelation.NextWeek
            }
        } else if isDateDuringSameWeekAsDate {
            relation = NearTermDateRelation.LaterThisWeek
        } else if isDateDuringSameWeekAfterDate {
            relation = NearTermDateRelation.NextWeek
        }
        
        return relation
    }
}