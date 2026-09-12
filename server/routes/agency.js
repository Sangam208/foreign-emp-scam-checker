const express = require('express');
const auth = require('../middlewares/auth');
const Agency = require('../models/agency');

const agencyRouter = express.Router();

agencyRouter.get('/agencies', auth, async (req, res) => {
    try {
        let agencies = await Agency.find({}).sort({ company_name: 1 }).lean();
        res.json(agencies);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = agencyRouter;