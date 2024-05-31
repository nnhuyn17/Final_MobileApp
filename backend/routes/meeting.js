const express = require("express")
const meetingRouter = express.Router();
const meetingController = require('../controller/mettingController');

meetingRouter.get("/getAllMeetingApprove" , meetingController.meetingApprove);
meetingRouter.post("/createMeetingApprove" , meetingController.createmeetingApprove);
meetingRouter.get("/getAllMeetingApprovebyID/:meeting_id" , meetingController.getAllCreateMeetingApproveByMeetingID);


module.exports = meetingRouter;
