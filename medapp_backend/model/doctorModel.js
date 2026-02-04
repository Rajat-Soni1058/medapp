const mongoose = require("mongoose")
const Schema = mongoose.Schema;   
const ObjectId = mongoose.Types.ObjectId


const DoctorSchema = new Schema({
    email : { type: String, unique: true, required: true },
    password : { type: String, required: true },
    name : { type: String, required: true },
    phone : { type: String, required: true},
    licenceId : { type: String, required: true, unique: true },
    availTime : { type: String, required: true },
    fees : { type: Number, required: true },
    speciality : {type : String, required : true},
    role : { type : String, default : "doctor"}

},{timestamps:true});



const DoctorModel = mongoose.model('doctors', DoctorSchema)


module.exports = {
    DoctorModel
}