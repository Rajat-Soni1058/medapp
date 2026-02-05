
const express = require("express");
const bcrypt = require("bcryptjs");
const Patient = require("../model/patientModel");
const {createPatientToken,checkValidPatient} = require("../services/patientAuth.js")
const {DoctorModel}=require("../model/doctorModel.js")
const Consultation=require("../model/consultationModel")
const multer  = require('multer')
const router=express.Router();
const mongoose = require("mongoose");
// Multer diskStorage----->
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    return cb(null,"./uploads/patient")///destination ,patient ka form kaha ja raha hai 
  },
  filename: function (req, file, cb) {
    return cb(null,`${Date.now()}-${file.originalname}`);// name of the file
  }
})
const upload=multer({storage:storage})

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
// route for the user to see unresolved form ----------->
router.route("/unresolved").get(checkValidPatient,async(req,res)=>{
    
    const patient_id=req.patient.id;
    const unResolveDocs=await Consultation.find({patient_id,status:"pending"}).populate("doctor_id","name speciality").sort({createdAt:-1});
    return res.json({unResolveDocs});
})
// route for the user to see resolved form-------->
router.route("/resolved").get(checkValidPatient,async(req,res)=>{
    const patient_id=req.patient.id;
    const ResolveDocs=await Consultation.find({patient_id,status:"responded"}).populate("doctor_id","name speciality").sort({updatedAt:-1});
    return res.json({ResolveDocs})

})
// route to view the form -------->
router.route("/showform/:id").get(checkValidPatient,async(req,res)=>{
    const consultId=req.params.id;
    const fullform=await Consultation.findById({_id:consultId});
    return res.json({full:fullform});

})
//doctorlist on basis of doctortype----->
router.route("/:doctype").get(checkValidPatient,async(req,res)=>{
    const speciality =req.params.doctype;
    try{
  const list=await DoctorModel.find({ speciality });
  return res.json({Doclist:list});
    }
    catch(err){
        return res.json({err:err});  
  }
})
//formsubmit by patient---------->
router.route("/form/:doc_id").post(checkValidPatient,upload.single("patientForm"),async(req,res)=>{
 const {full_name,age,gender,contactNo,Problem,life_style,type}=req.body;
 const doctor_id= req.params.doc_id;
 if(!doctor_id){
    return res.json({error:"doctoe id not given"})
 }
 const patient_id=req.patient.id;

 const patientFileUrl = req.file
        ? `uploads/patient/${req.file.filename}`
        : undefined;
 const con=await Consultation.create({
    full_name,
    age,
    gender,
    contactNo,
    type,
Problem,
life_style,
patient_id,
doctor_id,
patientFileUrl,
 })
 return res.status(200).json({msg:con})
})



module.exports=router;