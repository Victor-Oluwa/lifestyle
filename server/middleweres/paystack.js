const jwt = require("jsonwebtoken");
const User = require("../models/user");

const paystackAuth = async (req, res, next) => {
  try {
    const token = req.header(
      "sk_test_fc3c8d64ea752b19f4a3fe5f3578296eefcf26d8"
    );
    if (!token)
      return res.status(401).json({ msg: "No auth token: Access Denied." });

    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorisation denied" });
    // const user = await User.findById(verified.id);
    // if (user.type == "user") {
    //   return res.status(402).json({ msg: "You are not an Admin" });
    // }

    req.user = verified.id;
    req.token = token;
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};
module.exports = paystackAuth;
