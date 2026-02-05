const jwt = require("jsonwebtoken")
const JWT_DOCTOR_PASSWORD = "$oneTime"
const {validateToken} = require("../services/doctorAuth")



function doctorMiddleware(req,res,next){
    const token = req.headers.authorization?.split(" ")[1];
    const decodedPassword = validateToken(token)

    if(!decodedPassword){
       return res.status(403).json({
            error: "You are not signed in"
        })
    
    }
    req.doctorId=decodedPassword.id;
    next();
    

}

module.exports = {
    doctorMiddleware : doctorMiddleware
}