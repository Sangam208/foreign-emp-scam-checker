const mongoose = require('mongoose');

const agencySchema = mongoose.Schema({
    company_name: {
        type: String,
        required: true
    },
    license_no: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    phone_fax: {
        type: String,
        required: true
    },
    email_website: {
        type: String,
        required: true
    },
    contact_person: {
        type: String,
        required: true
    },
    status: {
        type: String,
        required: true
    },
});

const Agency = mongoose.model('Agency', agencySchema);

module.exports = Agency;