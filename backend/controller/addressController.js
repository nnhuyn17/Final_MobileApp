const db = require("../config/database");


const adrressDemo = async (req, res) => {
    const sql = "SELECT * FROM address";
    db.query(sql, (err, result) => {
      if (err) {
        return res.status(500).json({ Error: "Error fetching address" });
      }
      return res.status(200).json({ Status: "Success", address: result });
    });
  };


  const createAddress = async (req, res) => { 
    const sql =
      "INSERT INTO address  (address) VALUES (?)";
    const values = [req.body.address];
  
    db.query(sql, values, (err, result) => {
      if (err) {
        console.error("Error posting:", err);
        return res.status(500).json({ Error: "Internal server error" });
      }
      return res.status(201).json({ Status: "Success" });
    });
  };

  const deleteAddressbyID = async (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM address WHERE id = ?";
    const values = [id];
  
    try {
      const [result] = await db.promise().query(sql, values);
      // Check if the row was deleted
      if (result.affectedRows === 0) {
        return res.status(404).json({ Error: "Address not found" });
      }
  
      return res.status(200).json({ Status: "Success" });
    } catch (err) {
      console.error("Error deleting:", err);
      return res.status(500).json({ Error: "Internal server error" });
    }
  };

  const UpdateAddressByID = async (req, res) => {
    const id = req.params.id; 
    const address = req.body.address;
  
    const sql = "UPDATE address SET address = ? WHERE id = ?";
    const values = [address, id];
    db.query(sql, values, (err, result) => {
      if (err) {
        console.error("Error update:", err);
        return res.status(500).json({ Error: "Internal server error" });
      }
  
      return res.status(200).json({ Status: "Address updated successfully" });
    });
  };

  module.exports = {
    adrressDemo,
    createAddress,
    deleteAddressbyID,
    UpdateAddressByID
  };