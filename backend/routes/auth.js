const AuthController = require('../controller/authenticationController');
const express = require("express");
const router = express.Router();

router.post("/login", AuthController.login);
router.post("/signUp", AuthController.signUp);

/** 
 * @swagger
 * /login:
 *   post:
 *     summary: Authenticate user.
 *     requestBody:
 *       description: User credentials for authentication.
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               username:
 *                 type: string
 *                 description: The username for authentication.
 *                 example: john_doe
 *               password:
 *                 type: string
 *                 format: password
 *                 description: The password for authentication.
 *                 example: securePassword123
 *     tags: [Authentication]
 *     responses:
 *       200:
 *         description: Authentication successful.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 token:
 *                   type: string
 *                   description: JWT token for authenticated user.
 *                   example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMjM0NTY3ODkwLCJpYXQiOjE1MTYyMzkwMjJ9.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
 *       401:
 *         description: Unauthorized. Invalid credentials.
 *
 * 
 * /signUp:
 *     post:
 *       summary: Create a new user account
 *       tags: [Authentication]
 *       requestBody:
 *         required: true
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/UserSignUpRequest'
 *             example:
 *               email: user@example.com
 *               password: strongpassword
 *               full_name: John Doe
 *               date_of_birth: 1990-01-01
 *               position: Software Engineer
 *               company: XYZ Corp
 *               gender: male
 *               phonenumber: 1234567890
 *       responses:
 *         200:
 *           description: Successfully created account
 *           content:
 *             application/json:
 *               schema:
 *                 $ref: '#/components/schemas/SignUpResponse'
 *         400:
 *           description: Bad Request
 *           content:
 *             application/json:
 *               schema:
 *                 $ref: '#/definitions/Error'
 *         401:
 *           description: Email already exists
 *           content:
 *             application/json:
 *               schema:
 *                 $ref: '#/definitions/Error'
 *         500:
 *           description: Internal Server Error
 *           content:
 *             application/json:
 *               schema:
 *                 $ref: '#/definitions/Error'
 * 
 */




module.exports = router;