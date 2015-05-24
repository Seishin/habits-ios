//
//  ApiClient.swift
//  Habits
//
//  Created by Atanas Dimitrov on 5/20/15.
//  Copyright (c) 2015 Seishin. All rights reserved.
//

struct ApiClient {
    
    static func getUsersApi() -> UsersApi {
        return UsersApi.getInstance()
    }

    static func getUserStatsApi() -> UserStatsApi {
        return UserStatsApi.getInstance()
    }
    
    static func getDailyTasksApi() -> DailyTasksApi {
        return DailyTasksApi.getInstance()
    }
    
    static func getHabitsApi() -> HabitsApi {
        return HabitsApi.getInstance()
    }
    
    static func getToDosApi() -> ToDosApi {
        return ToDosApi.getInstance()
    }
}
