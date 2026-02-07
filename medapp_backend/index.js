require("dotenv").config()
const express=require("express")
const app=express()
const port = process.env.PORT||5000;
const mongoose=require("mongoose")
//imoprt files-------->
const handlePatientRoute = require("./routes/patient.js")
const { doctorRouter } = require("./routes/doctor.js")
const handlePayment=require("./routes/payment.js")

// database connection----------->
mongoose.connect("mongodb+srv://orbital:orbital1058@cluster0.ediaafr.mongodb.net/MedApp").then(()=>{
    console.log("data base connect ho gya")
}).catch((err) => {
    console.error("database error occured", err);
  });

  //middleware-------------->
app.use(express.json())
app.use(express.urlencoded({ extended: false }));
// route for home ----->
app.get("/", (req, res) => {
  res.status(200).send("MedApp Backend is running");
});

//Route---------->
app.use("/patient",handlePatientRoute);
//Route for the doctor ----->
app.use("/doctor", doctorRouter);
// razorpay payment route ----------->
app.use("/payment",handlePayment);






app.listen(port,()=>{
    console.log("server connected")
})

