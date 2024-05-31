const db = require("../config/database");

const meetingApprove = async (req, res) => {
    const sql = "SELECT * FROM meeting";
    db.query(sql, (err, result) => {
        if (err) {
            return res.status(500).json({ Error: "Error fetching account" });
        }
        return res.status(200).json({ Status: "Success", meetingApprove: result });
    });
};


const createmeetingApprove = async (req, res) => {
    const sql = 'INSERT INTO meeting (meeting_id, address, type, note) VALUES (?, ?, ?, ?)';
    db.query(sql, [req.body.meeting_id, req.body.address, req.body.type, req.body.note], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Database insertion failed' });
        }
        res.status(201).json({ id: results.insertId });
    });
}

const getAllCreateMeetingApproveByMeetingID = async (req, res) => {
    const meeting_id = req.params.meeting_id; 
    const sql = "SELECT * FROM meeting WHERE meeting_id = ?";
    const values = [meeting_id];
  
    db.query(sql, values, (err, result) => {
        if (err) {
            return res.status(500).json({ Error: "Error fetching booking request" });
        }
        return res.status(200).json({ Status: "Success", Data: result });
    });
};




module.exports = {
    meetingApprove,
    createmeetingApprove,
    getAllCreateMeetingApproveByMeetingID
};