const express = require("express");
const User = require("../models/user");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middleweres/auth");

// Sign Up
authRouter.post("/api/signup", async (req, res) => {

  try {

    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(404).json(`User already exists`);
    }
    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hashedPassword,
    });
    user = await user.save();


    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.status(200).json({ token, ...user._doc });

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
//---------------------------------------------------------------
// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//   Sign In|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    // console.log(res.toString());

    if (!user) {
      return res.status(102).json("User does not exist");
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(101).json("Incorrect Password");
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");

    res.status(200).json({ token, ...user._doc });

  } catch (e) {
    console.log(`Could not signIn. Check your connection: ${e}`);
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.status(404).json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.status(404).json(false);
    const user = await User.findById(verified.id);
    if (!user) return res.status(404).json(false);
    res.status(200).json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.status(200).json({ ...user._doc, token: req.token });
  console.log("This is req_user_info:" + user);
});

module.exports = authRouter;
