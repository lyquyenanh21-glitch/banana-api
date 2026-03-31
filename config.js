const express = require("express");
const app = express();

app.use(express.json());

let keys = {}; 
// format: { key: timestamp }

const KEY_PREFIX = "anhlyhud_";
const KEY_LIFETIME = 12 * 60 * 60 * 1000; // 12h

// tạo key
app.get("/create", (req, res) => {
    const key = KEY_PREFIX + Math.random().toString(36).substring(2, 10);
    const now = Date.now();

    keys[key] = now;

    res.json({
        key: key,
        expire: now + KEY_LIFETIME
    });
});

// verify key
app.post("/verify", (req, res) => {
    const { key } = req.body;

    if (!keys[key]) {
        return res.json({ valid: false, reason: "Key not found" });
    }

    const createdTime = keys[key];
    const now = Date.now();

    if (now - createdTime > KEY_LIFETIME) {
        delete keys[key];
        return res.json({ valid: false, reason: "Key expired" });
    }

    res.json({ valid: true });
});

app.listen(3000, () => console.log("Key system running"));
