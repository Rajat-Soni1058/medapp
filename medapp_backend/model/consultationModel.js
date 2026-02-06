
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const consultSchema= new mongoose.Schema(
  {
    full_name: {
      type: String,
      required: true,
    },
    age: {
      type: String,
      required: true,
    },
    gender: {
      type: String,
      required: true,
    },
    contactNo: {
      type: String,
      required: true,
    },
    Problem: {
      type: String,
    },
    life_style: {
      type: String,
    },
    patient_id: {
      type: Schema.Types.ObjectId,
      ref: "patient",
    },
    patientFileUrl: {
      type: String,
    },
    doctor_id: {
      type: Schema.Types.ObjectId,
      ref: "doctors",
    },
    doctorFileUrl: {
      type: String,
    },
     type: {                
      type: String,
      enum: ["normal", "emergency"],
    },
    status: {
      type: String,
      enum: ["pending", "responded"],
      default: "pending",
    },
  },
  { timestamps: true }
);

const Consultation = mongoose.model("consultation", consultSchema);

module.exports = Consultation;
