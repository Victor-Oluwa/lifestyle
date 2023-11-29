const envResult = require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const admin = require("./middleweres/admin");
const paustackAuth = require("./middleweres/paystack");
const adminRouter = require("./routes/admin");

if (envResult.error) {
  console.log("An error occured");
  throw envResult.error;
} else {
  console.log("All is well");
}

//IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
const paystackAuth = require("./middleweres/paystack");
const { env } = require("process");

//INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB =
  "mongodb+srv://Gemona:GWMongoDB@lifestyle-ar.6mcm1j2.mongodb.net/?retryWrites=true&w=majority"
// "mongodb+srv://Gemona:X.Individu@cluster0.cz0cqgw.mongodb.net/?retryWrites=true&w=majority";
// "mongodb+srv://pass2000:2000Atlas@cluster0.cz0cqgw.mongodb.net/?retryWrites=true&w=majority";


//MiddleWare
app.use(express.json());
app.use(userRouter);
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

//Connections
mongoose
  .connect(DB, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("Ready");
  })
  .catch((e) => {
    console.log("failed because: " + e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`"Connected at port: ${PORT} period "`);
});

// console.log(`Database password is ${process.env.PSTACK_TOKEN}`);

module.exports = admin;
module.exports = paystackAuth;
