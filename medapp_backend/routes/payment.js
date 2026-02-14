const express = require("express");
const  router=express.Router();
const crypto = require("crypto")
const {razorpay }= require("../configuration/razorpay.js");

// route for order create------>
router.route("/").post(async (req,res)=>{
   try {
    const {fees}=req.body;
   const order= await razorpay.order.create({
    amount:fees*100,
    currency: "INR",
   })
  return res.status(200).json({sucess:true,order});
}
catch(error){
     res.status(500).json({ error: error.message });
}

})

// route for payment verification -------->
router.route("/verify").post(async (req,res)=>{
const {rzO_ID,rzP_ID,rzSign}=req.body;
const body = rzO_ID+"|"+ rzP_ID;
const expectedSignature = crypto
      .createHmac("sha256", process.env.RAZORPAY_KEY_SECRET)//---it take secret not public key ---
      .update(body)
      .digest("hex");

      if (expectedSignature === rzSign) {
      return res.json({
        success: true,
        message: "Payment verified"
      });

    }
    else {
        return res.status(400).json({
        success: false,
        message: "Payment failed"
      });
    }

})
module.exports=router;