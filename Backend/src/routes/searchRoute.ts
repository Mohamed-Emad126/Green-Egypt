import { Router } from "express";
import SearchController from "../controllers/searchController";
import SearchService from "../services/searchService";

const searchRouter = Router();

const searchService = new SearchService();
const { searchHome, searchCommunity } = new SearchController(searchService);

searchRouter.route('/home/:key').get(searchHome);
searchRouter.route('/community/:key').get(searchCommunity);

export default searchRouter;