require("dotenv").config()//------what this  does -------
const express=require("express")
const app=express()
const port = process.env.PORT||5000;
const mongoose=require("mongoose")
const cors = require('cors');///------what this does ----
//imoprt files-------->
const handlePatientRoute = require("./routes/patient.js")
const { doctorRouter } = require("./routes/doctor.js")
const handlePayment=require("./routes/payment.js")
const handlehome=require("./routes/home.js")

// database connection----------->
mongoose.connect("mongodb+srv://orbital:orbital1058@cluster0.ediaafr.mongodb.net/MedApp").then(()=>{
    console.log("data base connect ho gya")
}).catch((err) => {
    console.error("database error occured", err);
  });

//middleware-------------->
app.use(cors());
app.use(express.json())
app.use(express.urlencoded({ extended: false }));
// route for home ----->
app.use("/home",handlehome);

//Route---------->
app.use("/patient",handlePatientRoute);
//Route for the doctor ----->
app.use("/doctor", doctorRouter);
// razorpay payment route ----------->
app.use("/payment",handlePayment);



app.listen(port,()=>{
    console.log("server connected")
})

