//
//  CalendarTests.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/6/14.
//  Copyright (c) 2014 Conrad Stoll. All rights reserved.
//

import XCTest

class CalendarTests: XCTestCase {
    var calendar: NSCalendar!

    override func setUp() {
        super.setUp()
        
        calendar = NSCalendar.gregorianCalendar()
    }
    
    func testEarlyYearMonthDayIsBeforeLaterYearMonthDay() {
        let earlyDate = calendar.dateWithYear(2004, month: 2, day: 29)
        let laterDate = calendar.dateWithYear(2004, month: 3, day: 1)
        let comparison = calendar.isDate(earlyDate, beforeYearMonthDay: laterDate)
        XCTAssert(comparison, "\(earlyDate) should be before \(laterDate)")
    }
    
    func testYearMonthDayIsNotBeforeSameYearMonthDay() {
        let earlyDate = calendar.dateWithYear(2005, month: 6, day: 1)
        let laterDate = calendar.dateWithYear(2005, month: 6, day: 1)
        let comparison = calendar.isDate(earlyDate, beforeYearMonthDay: laterDate)
        XCTAssertFalse(comparison, "\(earlyDate) should not be before \(laterDate)")
    }
    
    func testLaterYearMonthDayIsNotBeforeEarlyYearMonthDay() {
        let earlyDate = calendar.dateWithYear(2006, month: 4, day: 15)
        let laterDate = calendar.dateWithYear(2006, month: 4, day: 16)
        let comparison = calendar.isDate(laterDate, beforeYearMonthDay: earlyDate)
        XCTAssertFalse(comparison, "\(earlyDate) should not be before \(laterDate)")
    }
    
    func testEqualYearMonthDaysCompareAsEqual() {
        let earlyDate = calendar.dateWithYear(2005, month: 6, day: 1)
        let laterDate = calendar.dateWithYear(2005, month: 6, day: 1)
        let comparison = calendar.isDate(earlyDate, equalToYearMonthDay: laterDate)
        XCTAssert(comparison, "\(earlyDate) should equal \(laterDate)")
    }

    func testDifferentYearMonthDaysCompareAsNotEqual() {
        let earlyDate = calendar.dateWithYear(2005, month: 6, day: 1)
        let laterDate = calendar.dateWithYear(2005, month: 6, day: 2)
        let comparison = calendar.isDate(earlyDate, equalToYearMonthDay: laterDate)
        XCTAssertFalse(comparison, "\(earlyDate) should not equal \(laterDate)")
    }

    func testEndOfNextWeekDuringSameYear() {
        let date = calendar.dateWithYear(2005, month: 8, day: 2)
        let expectedNextWeek = calendar.dateWithYear(2005, month: 8, day: 13)
        let nextWeek = calendar.dateForEndOfFollowingWeekWithDate(date)
        let comparison = calendar.isDate(nextWeek, equalToYearMonthDay: expectedNextWeek)
        XCTAssert(comparison, "Next week should end on \(expectedNextWeek) (not \(nextWeek))")
    }
    
    func testEndOfNextWeekDuringFollowingYear() {
        let date = calendar.dateWithYear(2005, month: 12, day: 27)
        let expectedNextWeek = calendar.dateWithYear(2006, month: 1, day: 7)
        let nextWeek = calendar.dateForEndOfFollowingWeekWithDate(date)
        let comparison = calendar.isDate(nextWeek, equalToYearMonthDay: expectedNextWeek)
        XCTAssert(comparison, "Next week should end on \(expectedNextWeek) (not \(nextWeek))")
    }    
}
