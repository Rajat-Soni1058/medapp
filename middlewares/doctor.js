const jwt = require("jsonwebtoken")
const JWT_DOCTOR_PASSWORD = "$oneTime"
const {validateToken} = require("../services/doctorAuth")



function doctorMiddleware(req,res,next){
    const token = req.headers.token
    const decodedPassword = validateToken(token)

    if(decodedPassword){
        res.json({
            msg : "This is your Dashboard"
        })
    }
    else{
        res.status(403).json({
            msg : "You are not signed in"
        })

    }

}

module.exports = {
    doctorMiddleware : doctorMiddleware
}