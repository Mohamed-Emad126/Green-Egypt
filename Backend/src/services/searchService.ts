import User from "../models/userModel";
import Report from "../models/reportModel";
import Guide from "../models/guideModel";
import Event from "../models/eventModel";
import Nursery from "../models/nurseryModel";


export default class SearchService {

    async homeSearch(key : string) {
        const [events, nurseries] = await Promise.all([
            Event.find(
                {
                    "$or":[
                        {eventName: {$regex: key, $options: 'i'}}, 
                        {description: {$regex: key, $options: 'i'}},
                        {city: {$regex: key, $options: 'i'}}
                    ]
                }
            ).limit(10),
            Nursery.find(
                {
                    "$or":[
                        {nurseryName: {$regex: key, $options: 'i'}}, 
                        {address: {$regex: key, $options: 'i'}}
                    ]
                }
            ).limit(10)
        ]);

        if(events.length === 0 && nurseries.length === 0) {
            return 404;
        }

        return [events, nurseries];
    }


    async communitySearch(key : string) {
        const [users, reports] = await Promise.all([
            User.find({username: {$regex: key, $options: 'i'}}, {password: 0, passwordChangedAt: 0, isActive: 0}),
            Report.find({description: {$regex: key, $options: 'i'}})
        ]);

        if(users.length === 0 && reports.length === 0) {
            return 404;
        }

        return [users, reports];
    }

}