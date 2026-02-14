const admin = require('firebase-admin');

let serviceAccount;

// Check if running on Render (environment variable exists)
if (process.env.GOOGLE_APPLICATION_CREDENTIALS_JSON) {
    // Parse JSON from environment variable
    serviceAccount = JSON.parse(process.env.GOOGLE_APPLICATION_CREDENTIALS_JSON);
} else {
    // Local development - use file
    serviceAccount = require('../consultone-7e371-a4fb2afbc8d6.json');
}

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

module.exports = admin;