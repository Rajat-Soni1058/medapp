const express=require("express")
const router = express.Router();
const {DoctorModel}=require("../model/doctorModel.js")
const Patient=require("../model/patientModel.js");
const {checkValidPatient}=require("../services/patientAuth.js")


//route to tell how many doctors and patients have login yet--------->
router.route("/").get(checkValidPatient,async(req,res)=>{
    const totalPatient =await Patient.estimatedDocumentCount();
    const totalDoctor=await DoctorModel.estimatedDocumentCount();
    return res.json({totalPatient,totalDoctor});
})

module.exports=router;