//
//  TodayError.swift
//  Today
//
//  Created by Hamish Warnes on 2022/05/10.
//

import Foundation

enum TodayError: LocalizedError{
    case failedReadingReminders
    case reminderHasNoDueDate
    case accessDenied
    case accessRestricted
    case failedReadingCalendarItem
    case unknown
    
    var errorDescription: String?{
        switch self {
        case .failedReadingReminders:
            return NSLocalizedString("Failed to read reminders", comment: "failed to read reminders description")
        case .reminderHasNoDueDate:
            return NSLocalizedString("Reminder has no due date", comment: "reminder has no due date description")
        case .accessDenied:
            return NSLocalizedString("The app doesn't have permission to read reminders", comment: "access denied error desctiption")
        case .accessRestricted:
            return NSLocalizedString("The app has restricted access", comment: "access restricted error desctiption")
        case .failedReadingCalendarItem:
            return NSLocalizedString("Failed to read calender item", comment: "failed to read calender item description")
        case .unknown:
            return NSLocalizedString("An unknown error occured", comment: "unknown error description")
        }
    }
}
