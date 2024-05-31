const db = require("../config/database");

const meetingDemo = async (req, res) => {
  const sql = "SELECT * FROM meeting_requests";
  db.query(sql, (err, result) => {
    if (err) {
      return res.status(500).json({ Error: "Error fetching account" });
    }
    return res.status(200).json({ Status: "Success", accounts: result });
  });
};

const createMeeting = async (req, res) => { 
  const sql =
    "INSERT INTO meeting_requests (user_id, date, time_range, content, status) VALUES (?, ?, ?, ?, ?)";
  const values = [req.body.user_id, req.body.date, req.body.time_range, req.body.content, req.body.status || 'pending'];

  db.query(sql, values, (err, result) => {
    if (err) {
      console.error("Error posting:", err);
      return res.status(500).json({ Error: "Internal server error" });
    }
    return res.status(201).json({ Status: "Success" });
  });
}

const deleteMeetingbyID = async (req, res) => {
  const id = req.params.id;
  const sql = "DELETE FROM meeting_requests WHERE id = ? AND status = 'pending'";
  const values = [id];

  try {
    const [result] = await db.promise().query(sql, values);
    // Check if the row was deleted
    if (result.affectedRows === 0) {
      return res.status(404).json({ Error: "Meeting not found or status is not 'pending'" });
    }

    return res.status(200).json({ Status: "Success" });
  } catch (err) {
    console.error("Error deleting:", err);
    return res.status(500).json({ Error: "Internal server error" });
  }
};


const getDatafromUserAndMeeting = async (req, res) => {
  const sql =
    "SELECT * FROM account INNER JOIN meeting_requests ON account.id = meeting_requests.user_id";
  
  db.query(sql, (err, result) => {
    if (err) {
      console.error("Error retrieving data:", err);
      return res.status(500).json({ Error: "Internal server error" });
    }

    return res.status(200).json({ Status: "Success", Data: result });
  });
};

const UpdateMeetingByID = async (req, res) => {
  const id = req.params.id; 
  const status = req.body.status;

  const sql = "UPDATE meeting_requests SET status = ? WHERE id = ?";
  const values = [status, id];
  db.query(sql, values, (err, result) => {
    if (err) {
      console.error("Error deleting:", err);
      return res.status(500).json({ Error: "Internal server error" });
    }

    return res.status(200).json({ Status: "Meeting request updated successfully" });
  });
};

const getByDate = async (req, res) => {
  const date = req.params.date; 
  const sql = "SELECT * FROM meeting_requests where date = ?";
  const values = [date];
  db.query(sql, values, (err, result) => {
      if (err) {
      return res
          .status(500)
          .json({ Error: "Error fetching by date" });
      }
      return res.status(200).json({ Status: "Success", Data: result });
  });
};

const getAllBookingByUserID = async (req, res) => {
  const user_id = req.params.user_id; 
  const sql = "SELECT * FROM meeting_requests where user_id = ?";
  const values = [user_id];

  db.query(sql , values ,  (err, result) => {
    if (err) {
      return res.status(500).json({ Error: "Error fetching booking req" });
    }
    return res.status(200).json({ Status: "Success", Data: result });
  });
};


const getDatafromUserAndMeetingFillter = async (req, res) => {
  const status = req.params.status; 
  const sql =
    "SELECT * FROM account INNER JOIN meeting_requests ON account.id = meeting_requests.user_id where status = ?";
    const values = [status];

    db.query(sql, values, (err, result) => {
      if (err) {
      return res
          .status(500)
          .json({ Error: "Error fetching by status" });
      }
      return res.status(200).json({ Status: "Success", Data: result });
  });
};

module.exports = {
  meetingDemo,
  createMeeting,
  deleteMeetingbyID,
  getDatafromUserAndMeeting,
  UpdateMeetingByID,
  getByDate,
  getAllBookingByUserID,
  getDatafromUserAndMeetingFillter
};