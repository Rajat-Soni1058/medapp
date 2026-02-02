require("dotenv").config()
const express=require("express")
const app=express()
const port = 5000||process.env.PORT;
const mongoose=require("mongoose")
//imoprt files-------->
const handlePatientRoute = require("./routes/patient.js")

// database connection----------->
mongoose.connect("mongodb+srv://orbital:orbital1058@cluster0.ediaafr.mongodb.net/MedApp").then(()=>{
    console.log("data base connect ho gya")
}).catch((err) => {
    console.error("database error occured", err);
  });

  //middleware-------------->
app.use(express.json())
app.use(express.urlencoded({ extended: false }));

//Route---------->
app.use("/patient",handlePatientRoute);







app.listen(port,()=>{
    console.log("server connected")
})

