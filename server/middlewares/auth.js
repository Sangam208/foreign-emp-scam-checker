const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
    try {
        const token = req.header(process.env.TOKEN_HEADER);
        if (!token)
            return res.status(401).json({ msg: 'Access Denied! No auth token found)' });

        const verified = jwt.verify(token, process.env.JWT_SECRET);
        if (!verified)
            return res.status(401).json({ msg: 'Authorization Denied! Token verification failed)' });

        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
};

module.exports = auth;