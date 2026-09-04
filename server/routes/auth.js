const express = require('express');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

const { OAuth2Client } = require('google-auth-library');
const client = new OAuth2Client();

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { idToken } = req.body;
        const ticket = await client.verifyIdToken({
            idToken: idToken,
            audience: process.env.WEB_CLIENT_ID
        });
        const payload = ticket.getPayload();

        let user = await User.findOne({ email: payload.email });

        if (!user) {
            user = new User({
                name: payload.name,
                email: payload.email,
                profilePic: payload.picture
            });
            user = await user.save();
        }
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET);
        res.json({ user, token });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.get('/', auth, async (req, res) => {
    try {
        const user = User.findById(req.user);
        res.json({ user, token: req.token })
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

module.exports = authRouter;