//
//  TodayDestinationRouter.swift
//  HanziPlus
//

import SwiftUI

enum TodayDestinationRouter {

    @ViewBuilder
    static func view(for destination: TodayDestination) -> some View {
        switch destination {
        case .study(let fileName, let sectionID):
            if let set = SampleStudySets.studySet(fileName: fileName) {
                if let sectionID,
                   let section = StudySetCatalog.section(fileName: fileName, id: sectionID) {
                    StudyView(studySet: set, studySection: section)
                } else if set.hasSections {
                    SectionedStudySetView(studySet: set)
                } else {
                    StudyView(studySet: set)
                }
            } else {
                ContentUnavailableView(String(localized: "today.router.study_unavailable"), systemImage: "book.closed")
            }

        case .smartReview(let fileName):
            if let set = SampleStudySets.studySet(fileName: fileName) {
                SmartReviewView(studySet: set)
            } else {
                SmartReviewView(studySet: SampleStudySets.hsk1)
            }

        case .dailyLesson:
            DailyLessonFlowView()

        case .travelHub, .travelEssentials:
            // Prefer tab deep-links from TodayView.open(_:). Fallback for safety.
            ContentUnavailableView(
                String(localized: "today.router.travel_title"),
                systemImage: "airplane",
                description: Text("today.router.travel_desc")
            )

        case .journey, .learnTab, .gamesTab:
            ContentUnavailableView(String(localized: "common.opening"), systemImage: "arrow.right.circle")
        }
    }
}
