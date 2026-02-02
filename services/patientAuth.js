const JWT=require("jsonwebtoken")
const secret="optimusprime";
//creating token for patient----------->
function createPatientToken(patient){
    const payload={
        id:patient._id,
        email:patient.email,
        role:patient.role,
    };
    const token =JWT.sign(payload,secret);
    return token;

}
//token validity checking ---------->
function validPatientToken(token){
    const payload=JWT.verify(token,secret);
    return payload;
}
module.exports={
    createPatientToken,validPatientToken
}

// function checkValidPatient(req,res,next){



// }