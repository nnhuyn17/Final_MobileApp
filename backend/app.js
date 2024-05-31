const express = require("express");
const userRoutes = require("./routes/users");
const authRoutes = require("./routes/auth");
const meetingRequestRouter = require("./routes/meetingRequest");
const meetingRouter = require("./routes/meeting");
const addressRouter = require("./routes/address");

const cors = require('cors');

const swaggerJsdoc = require("swagger-jsdoc")
const swaggerUi = require("swagger-ui-express");
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const db = require("./config/database")
const configViewEngine = require("./config/viewEngine")
const app = express();

const port = process.env.PORT || 8888;
 

app.use(cors());
app.use(express.json());

// Config template engine
configViewEngine(app)


// define all our routes
app.use("/", userRoutes);
app.use("/", authRoutes);
app.use("/", meetingRequestRouter);
app.use("/", meetingRouter);
app.use("/", addressRouter);


const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "User Express API",
      version: "0.1.0",
      description:
        "This is a simple User API application made with Express and documented with Swagger",
    },
    servers: [
      {
        url: "http://localhost:8081/",
      },
    ],
  },
  apis: ["./routes/*.js"],
};
const specs = swaggerJsdoc(options);
app.use(
  "/api-docs",
  swaggerUi.serve,
  swaggerUi.setup(specs)
);

app.listen(port, '0.0.0.0', () => {
  console.log(`Server is running on port ${port}`);
});

db.query('SELECT 1 + 1', (error, results, fields) => {
  if (error) {
    console.error('Error connecting to MySQL:', error.message);
    return;
  }
  console.log('Connected to MySQL!');
});

