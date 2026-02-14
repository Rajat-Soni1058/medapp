
const express = require("express");
const bcrypt = require("bcryptjs");
const Patient = require("../model/patientModel");
const { createPatientToken, checkValidPatient } = require("../services/patientAuth.js")
const { DoctorModel } = require("../model/doctorModel.js")
const Consultation = require("../model/consultationModel")
const multer = require('multer')
const router = express.Router();
const cloudinary = require("../configuration/cloudinary.js")
const streamifier = require("streamifier");// for clodinary

// Multer diskStorage---------------
// const storage = multer.diskStorage({
//   destination: function (req, file, cb) {
//     return cb(null,"./uploads/patient")///destination ,patient ka form kaha ja raha hai 
//   },
//   filename: function (req, file, cb) {
//     return cb(null,`${Date.now()}-${file.originalname}`);// name of the file
//   }
// })
// const upload=multer({storage:storage})
//---------------------------------

const storage = multer.memoryStorage();// ye RAM me store karta hai file ke binary form ko 
const upload = multer({
    storage,
    limits: { fileSize: 10 * 1024 * 1024 } // max size 10MB ho sakta hai 
});

// cloudinary building pipeline connection for uploading the file -->
const uploadToCloudinary = (buffer, folder) => {
    return new Promise((resolve, reject) => {
        const stream = cloudinary.uploader.upload_stream(//Open upload connection to Cloudinary inside this folder-->
            { folder },
            (error, result) => {
                if (result) resolve(result);
                else reject(error);
            }
        );

        streamifier.createReadStream(buffer).pipe(stream);//convert binary file data into readable stream and then send gradually to connected stream --^
    });
};

// signup of patient ---------->
router.route("/signup").post(async (req, res) => {
    const { name, email, password, phoneNo } = req.body;

    if (!name || !email || !password || !phoneNo) {
        return res.status(400).json({ error: "fill all the fields" })
    }
    const user = await Patient.findOne({ email });
    if (user) {
        return res.status(400).json({ error: "user already exist" })
    }
    /// password hashing
    const hashedpassword = await bcrypt.hash(password, 10);
    /// new patient create

    const newPatient = await Patient.create({
        name,
        email,
        password: hashedpassword,
        phoneNo,

    })
    const token = createPatientToken(newPatient);
    return res.status(201).json({ token: token });
})
// patient login -------->
router.route("/login").post(async (req, res) => {
    const { email, password } = req.body;
    const patient = await Patient.findOne({ email });
    if (!patient) {
        return res.json({ error: "enter correct email" })
    }
    const match = await bcrypt.compare(password, patient.password);
    if (!match) {
        return res.json({ error: "invalid password" });
    }
    const token = createPatientToken(patient);
    return res.status(200).json({ token: token });

})
// route for the user to see unresolved form ----------->
router.route("/unresolved").get(checkValidPatient, async (req, res) => {

    const patient_id = req.patient.id;
    const unResolveDocs = await Consultation.find({ patient_id, status: "pending" }).populate("doctor_id", "name speciality").sort({ createdAt: -1 });
    return res.json({ unResolveDocs });
})
// route for the user to see resolved form-------->
router.route("/resolved").get(checkValidPatient, async (req, res) => {
    const patient_id = req.patient.id;
    const ResolveDocs = await Consultation.find({ patient_id, status: "responded" }).populate("doctor_id", "name speciality").sort({ updatedAt: -1 });
    return res.json({ ResolveDocs })

})
// route to view the form -------->
router.route("/showform/:id").get(checkValidPatient, async (req, res) => {
    const consultId = req.params.id;
    const fullform = await Consultation.findById(consultId)
        .populate("doctor_id", "name speciality");

    return res.json({ full: fullform });

})

//formsubmit by patient---------->
router.route("/form/:doc_id").post(checkValidPatient, upload.single("patientForm"), async (req, res) => {
    const { full_name, age, gender, contactNo, Problem, life_style, type } = req.body;
    const doctor_id = req.params.doc_id;
    if (!doctor_id) {
        return res.json({ error: "doctor id not given" })
    }
    const patient_id = req.patient.id;

    //------cloudinary code below ------------//
    let patientFileUrl;
    console.log("File object: teri mkakakkka  dnfkjndkwjfebkjwebjerbwjertbwjrh", req.file);

    if (req.file) {// cloudResult is js object contain many key value 
        const cloudResult = await uploadToCloudinary(req.file.buffer, "patient_uploads");
        patientFileUrl = cloudResult.secure_url;
    }
    //---------------------------------------//
    const con = await Consultation.create({
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
    return res.status(200).json({ consultation: con })
})

// route for calling a doctor ------------>
router.route("/emergency/masked/:consultId")
    .get(checkValidPatient, async (req, res) => {

        const consultId = req.params.consultId;
        const patient_id = req.patient.id;

        const consultation = await Consultation.findOne({
            _id: consultId,
            patient_id: patient_id,
            type: "emergency"
        });

        if (!consultation) {
            return res.json({
                error: "Emergency case not found for this patient"
            });
        }

        const maskedNumber = "08045889186";

        return res.json({
            maskedNumber: maskedNumber,
            msg: "Use this number to call the doctor"
        });
    });






module.exports = router;