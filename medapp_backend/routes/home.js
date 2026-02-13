const express=require("express")
const router = express.Router();
const {DoctorModel}=require("../model/doctorModel.js")
const Patient=require("../model/patientModel.js");
const {checkValidPatient}=require("../services/patientAuth.js")
const {ai} =require("../configuration/gemini.js");


// route for the google gemini chatbot -------->
router.route("/gemini").post(async(req,res)=>{
    try{
        const { prompt } = req.body;

         if (!prompt) {// agar prompt hi nhi diya 
      return res.status(400).json({
        error: "Prompt is required",
      });
    }
    // instruction to  customize --------->
const Health_bot_instruct=`You are a professional medical assistant AI.
You ONLY answer health and medical related questions.
If the user asks anything unrelated to health, politely refuse.
Do not prescribe medication.
Do not provide final diagnosis.
Always encourage consulting a doctor.
Always add disclaimer: "This does not replace professional medical advice.Give answer in 10 line max"`

    // responce ------------>
    const response = await ai.models.generateContent({
      model: "gemini-2.5-flash",
      contents: [
        {
          role: "user",
          parts: [{ text: prompt }],
        },
      ],
      config: {
        systemInstruction: Health_bot_instruct,
        temperature: 0.4,
      },
    });

    res.json({
      reply: response.text,
    });


    }
    catch(err){
        return res.status(500).json({error:`unable to answer right now1${err}`});
    }

})

//route to tell how many doctors and patients have login yet--------->
router.route("/").get(checkValidPatient,async(req,res)=>{
    const totalPatient =await Patient.estimatedDocumentCount();
    const totalDoctor=await DoctorModel.estimatedDocumentCount();
    return res.json({totalPatient,totalDoctor});
})

module.exports=router;