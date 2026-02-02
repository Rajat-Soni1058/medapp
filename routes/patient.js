
const express = require("express");
const bcrypt = require("bcryptjs");
const Patient = require("../model/patientModel");
const {createPatientToken} = require("../services/patientAuth.js")
const router=express.Router();
// signup of patient ---------->
router.route("/signup").post(async(req,res)=>{
    const {name,email,password,phoneNo}=req.body;

    if(!name||!email||!password||!phoneNo){
        return res.status(400).json({error:"fill all the fields"})
    }
    const user=await Patient.findOne({ email });
    if(user){
        return res.status(400).json({error:"user already exist"})
    }
    /// password hashing
    const hashedpassword=await bcrypt.hash(password,10);
    /// new patient create
    const  newPatient=await Patient.create({
        name,
        email,
        password:hashedpassword,
        phoneNo,

    })
    const token=createPatientToken(newPatient);
   return  res.status(201).json({token:token});
})
// patient login -------->
router.route("/login").post(async(req,res)=>{
    const {email,password}=req.body;
    const patient= await Patient.findOne({email});
    if(!patient){
        return res.json({error:"enter correct email"})
    }
    const match= await bcrypt.compare(password,patient.password);
    if(!match){
        return res.json({error:"invalid password"});
    }
     const token=createPatientToken(patient);
   return  res.status(200).json({token:token});

})



module.exports=router;