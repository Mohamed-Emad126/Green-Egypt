import User from "../models/userModel";
import Report from "../models/reportModel";
import Guide from "../models/guideModel";
import Event from "../models/eventModel";
import Nursery from "../models/nurseryModel";


export default class SearchService {

    async homeSearch(key : string) {
        const [articles, events, nurseries] = await Promise.all([
            Guide.find(
                {
                    "$or":[
                        {articletitle: {$regex: key, $options: 'i'}}, 
                        {content: {$regex: key, $options: 'i'}}
                    ]
                }
            ),
            Event.find(
                {
                    "$or":[
                        {eventName: {$regex: key, $options: 'i'}}, 
                        {description: {$regex: key, $options: 'i'}}
                    ]
                }
            ),
            Nursery.find(
                {
                    "$or":[
                        {nurseryname: {$regex: key, $options: 'i'}}, 
                        {location: {$regex: key, $options: 'i'}}
                    ]
                }
            ),
        ]);

        const articlesResult = articles || "No articles found";
        const eventsResult = events || "No events found";
        const nurseriesResult = nurseries || "No nurseries found";

        if(articlesResult.length === 0 && eventsResult.length === 0 && nurseriesResult.length === 0) {
            return 404;
        }

        return [articlesResult, eventsResult, nurseriesResult];
    }


    async communitySearch(key : string) {
        const [users, reports] = await Promise.all([
            User.find({username: {$regex: key, $options: 'i'}}, {password: 0, passwordChangedAt: 0, isActive: 0}),
            Report.find({description: {$regex: key, $options: 'i'}})
        ]);

        const usersResult = users || "No users found for this search";
        const reportsResult = reports || "No reports found for this search";

        if(usersResult.length === 0 && reportsResult.length === 0) {
            return 404;
        }

        return [usersResult, reportsResult];
    }

}