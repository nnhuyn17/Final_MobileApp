const express = require("express")
const meetingRequestRouter = express.Router();
const meetingRequestController = require('../controller/meetingRequestController') 

meetingRequestRouter.get("/meetingDemo" , meetingRequestController.meetingDemo);
meetingRequestRouter.post("/createMeeting" , meetingRequestController.createMeeting);
meetingRequestRouter.delete("/deleteMeeting/:id" , meetingRequestController.deleteMeetingbyID);
meetingRequestRouter.get("/getDatafromUserAndMeeting" , meetingRequestController.getDatafromUserAndMeeting);
meetingRequestRouter.put("/UpdateMeetingByID/:id" , meetingRequestController.UpdateMeetingByID);
meetingRequestRouter.get("/getByDate/:date" , meetingRequestController.getByDate);
meetingRequestRouter.get("/getAllBookingByUserID/:user_id" , meetingRequestController.getAllBookingByUserID);
meetingRequestRouter.get("/getDatafromUserAndMeetingFillter/:status", meetingRequestController.getDatafromUserAndMeetingFillter);
/**
 * @swagger
 * tags: 
 *   name: MeetingRequests
 *   description: API for managing meeting requests
 * components:
 *   schemas:
 *     MeetingRequest:
 *       type: object
 *       properties:
 *         id:
 *           type: integer
 *           description: The auto-generated id of the meeting request
 *         user_id:
 *           type: integer
 *           description: The user ID associated with the meeting request
 *         date:
 *           type: string
 *           format: date
 *           description: The date of the meeting request
 *         time_range:
 *           type: string
 *           description: The time range of the meeting request
 *         content:
 *           type: string
 *           description: The content or description of the meeting request
 *         status:
 *           type: string
 *           description: The status of the meeting request (e.g., pending, approved, rejected)
 * 
 * /meetingDemo:
 *   get:
 *     summary: Lists all meeting requirements
 *     tags: [MeetingRequests]
 *     responses:
 *       200:
 *         description: The list of meeting requirements
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/MeetingRequest'
 * 
 * /createMeeting:
 *   post:
 *     summary: Create a new meeting request
 *     tags: [MeetingRequests]
 *     consumes:
 *       - application/json
 *     produces:
 *       - application/json
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/MeetingRequest'
 *     responses:
 *       201:
 *         description: Meeting request created successfully
 *         schema:
 *           $ref: '#/definitions/Success'
 *       400:
 *         description: Bad Request
 *         schema:
 *           $ref: '#/definitions/Error'
 *       500:
 *         description: Internal Server Error
 *         schema:
 *           $ref: '#/definitions/Error'
 * 
 * /deleteMeetingbyID/{id}:
 *   delete:
 *     summary: Delete a meeting request by ID
 *     tags: [MeetingRequests]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The meeting request ID
 *     responses:
 *       200:
 *         description: Meeting request deleted successfully
 *         schema:
 *           $ref: '#/definitions/Success'
 *       404:
 *          description: Meeting not found or status is not 'pending'
 *          content:
 *          application/json:
 *           schema:
 *             $ref: '#/definitions/Error'
 *       500:
 *         description: Internal Server Error
 *         schema:
 *           $ref: '#/definitions/Error'
 * /UpdateMeetingByID/{id}:
 *   put:
 *     summary: Update the status of a meeting request by ID
 *     tags: [MeetingRequests]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The meeting request ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateMeetingByID'
 *     responses:
 *       200:
 *         description: Meeting request status updated successfully
 *         schema:
 *           $ref: '#/definitions/Success'
 *       500:
 *         description: Internal Server Error
 *         schema:
 *           $ref: '#/definitions/Error'
 * 
 * /getByDate/{date}:
 *   get:
 *     summary: Get meeting requests by date
 *     tags: [MeetingRequests]
 *     parameters:
 *       - in: path
 *         name: date
 *         schema:
 *           type: string
 *         required: true
 *         description: The date to filter meeting requests
 *     responses:
 *       200:
 *         description: List of meeting requests for the specified date
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 Status:
 *                   type: string
 *                   example: 
 *                 Data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/getByDate'
 *       500:
 *         description: Internal Server Error
 *         schema:
 *           $ref: '#/definitions/Error'
 * 
 * /getAllBookingByUserID/{user_id}:
 *   get:
 *     summary: Get all meeting requests for a specific user
 *     tags: [MeetingRequests]
 *     parameters:
 *       - in: path
 *         name: user_id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The user ID to filter meeting requests
 *     responses:
 *       200:
 *         description: List of meeting requests for the specified user
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 Status:
 *                   type: string
 *                 Data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/getAllBookingByUserID'
 *       500:
 *         description: Internal Server Error
 *         schema:
 *           $ref: '#/definitions/Error'
 * 
 * /getDatafromUserAndMeeting:
 *     get:
 *       summary: Retrieve data from user and meeting requests
 *       tags: [MeetingRequests]
 *       responses:
 *         200:
 *           description: Successful response with user and meeting data
 *           content:
 *             application/json:
 *               schema:
 *                 type: object
 *                 properties:
 *                   Status:
 *                     type: string
 *                     description: Status of the response (Success)
 *                   Data:
 *                     type: array
 *                     items:
 *                       $ref: '#/components/schemas/getDatafromUserAndMeeting'
 *         500:
 *           description: Internal Server Error
 *           content:
 *             application/json:
 *               schema:
 *                 $ref: '#/definitions/Error'
 * 
 * /getDatafromUserAndMeetingFillter/{status}:
 *   get:
 *     summary: Get all meeting requests based on status
 *     tags: [MeetingRequests]
 *     parameters:
 *       - in: path
 *         name: status
 *         schema:
 *           type: string
 *         required: true
 *         description: The status to filter meeting requests
 *     responses:
 *       200:
 *         description: List of meeting requests based on status
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 Status:
 *                   type: string
 *                 Data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/getDatafromUserAndMeetingFillter'
 *       500:
 *         description: Internal Server Error
 *         schema:
 *           $ref: '#/definitions/Error'
 * 
 * definitions:
 *   MeetingRequest:
 *     type: object
 *     properties:
 *       id:
 *         type: integer
 *       user_id:
 *         type: integer
 *       date:
 *         type: string
 *         format: date
 *       time_range:
 *         type: string
 *       content:
 *         type: string
 *       status:
 *         type: string
 * 
 *   MeetingRequestInput:
 *     type: object
 *     properties:
 *       user_id:
 *         type: integer
 *       date:
 *         type: string
 *         format: date
 *       time_range:
 *         type: string
 *       content:
 *         type: string
 *       status:
 *         type: string
 * 
 *   MeetingRequestStatusInput:
 *     type: object
 *     properties:
 *       status:
 *         type: string
 * 
 *   Success:
 *     type: object
 *     properties:
 *       Status:
 *         type: string
 * 
 *   Error:
 *     type: object
 *     properties:
 *       Status:
 *         type: string
 *       Error:
 *         type: string
 */





module.exports = meetingRequestRouter;


