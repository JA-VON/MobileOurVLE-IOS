//
//  MoodleRestFunctions.swift
//  OurVLE
//
//  Created by Javon Davis on 7/23/15.
//  Copyright (c) 2015 Javon Davis. All rights reserved.
//

import Foundation

public class MoodleRestFunctions {
    static let URL = "http://ourvle.mona.uwi.edu/"
    static let SERVICE_MOODLE_MOBILE = "moodle_mobile_app"
    static let RESPONSE_FORMAT = "json"
    static let LOGIN = "login/token.php"
    static let REST_API = "webservice/rest/server.php"
    
    // Function names for getting contents
    static let FUNCTION_GET_ALL_COURSES = "moodle_course_get_courses"
    static let FUNCTION_GET_ENROLLED_COURSES = "moodle_enrol_get_users_courses"
    static let FUNCTION_GET_COURSE_CONTENTS = "core_course_get_contents"
    static let FUNCTION_GET_SITE_INFO = "moodle_webservice_get_siteinfo"
}
