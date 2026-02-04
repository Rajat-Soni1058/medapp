const { Router } = require("express");
const doctorRouter = Router();  
const { DoctorModel } = require("../model/doctorModel");
const bcrypt = require('bcrypt');
const { z } = require("zod");
const { doctorMiddleware } = require("../middlewares/doctor");
const {createToken} = require("../services/doctorAuth")


doctorRouter.post("/signup", async function(req, res){
    const requireBody = z.object({
  email: z
    .string()
    .min(3, "Email must be at least 3 characters")
    .max(100, "Email too long")
    .email("Invalid email format"),

  password: z
    .string()
    .min(8, "Password must be at least 8 characters long")
    .regex(/[A-Z]/, "Password must contain at least one uppercase letter")
    .regex(/[0-9]/, "Password must contain at least one number")
    .regex(/[^A-Za-z0-9]/, "Password must contain at least one special character"),

  name: z
    .string()
    .min(3, "Name must be at least 3 characters")
    .max(100, "Name too long")
    .regex(/^[A-Za-z ]+$/, "Name can only contain letters and spaces"),

   phone: z
    .string()
    .regex(/^[6-9]\d{9}$/, "Invalid Indian phone number (must be 10 digits starting 6–9)"),

  licenceId: z
    .string()
    .min(5, "Licence ID should be at least 5 characters")
    .max(50, "Licence ID too long"),

  availTime: z
    .string()
    .min(3, "Availability time is required")
    .max(50, "Too long for time field"),

  fees: z
    .number()
    .positive("Fees must be a positive number"),
    
    speciality : z
    .string()
});

    const parsedDataWithSuccess = requireBody.safeParse(req.body)

    if(!parsedDataWithSuccess.success){
        res.json({
            msg : "Incorrect Format",
            error : parsedDataWithSuccess.error
        })
        return
    }
    const { email, password, name, phone, licenceId, availTime, fees, speciality } = req.body;

    try {
  const hashedPassword = await bcrypt.hash(password, 5);

  await DoctorModel.create({
    email,
    password: hashedPassword,
    name,
    phone,
    licenceId,
    availTime,
    fees,
    speciality
  });

} catch (e) {

  if (e.code === 11000) {
    if (e.keyPattern?.email) {
      return res.status(400).json({ msg: "Email already in use" });
    }
    if (e.keyPattern?.licenceId) {
      return res.status(400).json({ msg: "Licence ID already registered" });
    }
  }

  if (e.name === "ValidationError") {
    return res.status(400).json({
      msg: "Schema validation failed",
      error: e.message
    });
  }

  console.log("Signup error:", e);
  return res.status(500).json({ msg: "Internal server error" });
}

return res.status(201).json({
  msg: "You are signed up successfully"
});

})
 


doctorRouter.post("/signin", async function(req,res){

    const {email , password} = req.body
    const doctor = await DoctorModel.findOne({
        email : email
    })

    if(!doctor){
        res.json({
            msg : "Doctor does not exist in our db"
        })
        return
    }

    const passwordMatched = await bcrypt.compare(password, doctor.password)

    if(passwordMatched){
        const token = createToken(doctor)

        res.json({
            token : token
        })
    }
    else{
        res.status(403).json({
            msg : "Incorrect Credentials"
        })
    }


})

doctorRouter.post("/dashboard", doctorMiddleware, async function(req,res){
    ////////////
})





module.exports = {
    doctorRouter : doctorRouter
}