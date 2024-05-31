const db = require("../config/database");
const express = require("express");

const getAllDemo = async (req, res) => {
    const sql = "SELECT * FROM account";
    db.query(sql, (err, result) => {
      if (err) {
        return res.status(500).json({ Error: "Error fetching account" });
      }
      return res.status(200).json({ Status: "Success", accounts: result });
    });
  };

  const getByID = async (req, res) => {
    const id = req.params.id; 
    const sql = "SELECT * FROM account where id = ?";
    const values = [id];
    db.query(sql, values, (err, result) => {
        if (err) {
        return res
            .status(500)
            .json({ Error: "Error fetching user ID" });
        }
        return res.status(200).json({ Status: "Success", Account: result });
    });
  };

  const getFullNameByID = async (req, res) => {
    const id = req.params.id; 
    const sql = "SELECT full_name FROM account where id = ?";
    const values = [id];
    db.query(sql, values, (err, result) => {
        if (err) {
        return res
            .status(500)
            .json({ Error: "Error fetching user ID" });
        }
        return res.status(200).json({ Status: "Success", Account: result });
    });
  };

  const getUserByID = async (req, res) => {
    const id = req.params.id; 
    const sql = "SELECT * FROM account where id = ?";
    const values = [id];
    db.query(sql, values, (err, result) => {
        if (err) {
        return res
            .status(500)
            .json({ Error: "Error fetching user ID" });
        }
        return res.status(200).json({ Status: "Success", Account: result });
    });
  };


  module.exports = {
    getAllDemo,
    getByID,
    getFullNameByID,
    getUserByID
  };

