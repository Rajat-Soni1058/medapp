const admin = require ('firebase-admin');
const serviceAccount= require('../consultone-7e371-a4fb2afbc8d6.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});
module.exports=admin;