const URLSERVER = "https://fhcs-backend.online";

const APIUSERAUTHORIZE = URLSERVER + '/api/v1/Accounts/SocialAuthentication';

const APISENDINGCODEFORGOTPASSWORD =
    URLSERVER + '/api/v1.0/Accounts/SendingCodeForgotPassword';
const APIVERIFYCODEFORGOTPASSWORD =
    URLSERVER + '/api/v1/Accounts/VerifyingCodeForgotPassword';
const APICHANGINGFORGOTPASSWORD =
    URLSERVER + '/api/v1/Accounts/ChangingNewPasswordForgot';
const APICHANGINGNEWPASSWORD =
    URLSERVER + '/api/v1/Accounts/ResetingPasswordAccountUsername';
const APIUSERAUTHORIZEUSERPASS =
    URLSERVER + '/api/v1.0/Accounts/UsernameAuthentication';
const APIGETUSERPROFILE = URLSERVER + '/api/v1/Accounts/Profile';
const APIREFRESHTOKEN = URLSERVER + '/api/v1/Accounts/Refreshing/Token';
const APISEARCHMEDICINE = URLSERVER + '/api/v1/Medicines/Searching';
const APIMEDICINESUBGROUPS = URLSERVER + '/api/v1/MedicineSubgroups';
const APIMEDICINEUNITS = URLSERVER + '/api/v1/MedicineUnits';
const APIMEDICINECLASSIFICATION = URLSERVER + '/api/v1/MedicineClassifications';
const APIFETCHMEDICINECLASSIFICATION =
    URLSERVER + '/api/v1/MedicineClassifications/Searching';
const APIFETCHMEDICINEUNIT = URLSERVER + '/api/v1/MedicineUnits/Searching';
const APIFETCHMEDICINESUBGROUP =
    URLSERVER + '/api/v1/MedicineSubgroups/Searching';
const APIMEDICINE = URLSERVER + '/api/v1/Medicines';
const APIUPDATEPROFILE = URLSERVER + '/api/v1/Accounts/UpdatingProfile';
const APISEARCHIMPORTBATCHMEDICINE =
    URLSERVER + '/api/v1/ImportBatches/Searching';
const APIIMPORTBATCHMEDICINE = URLSERVER + '/api/v1/ImportBatches';
const APIMEDICINEINIMPORTBATCH = URLSERVER + '/api/v1/ImportMedicines';
const APISEARCHMEDICINEINIMPORTBATCH =
    URLSERVER + '/api/v1/ImportMedicines/Searching';
const APIDEPARTMENTSEARCH = URLSERVER + '/api/v1/Departments/Searching';
const APIDEPARTMENT = URLSERVER + '/api/v1/Departments';
const APISEARCHMEDICINEINVENTORYDETAIL =
    URLSERVER + '/api/v1/MedicineInInventoryDetails/Searching';
const APISEARCHMEDICINEINVENTORYDETAILGROUPBYS =
    URLSERVER + '/api/v1/MedicineInInventoryDetails/SearchingGroupByMedicine';
const APIMEDICINEINVENTORYDETAIL =
    URLSERVER + '/api/v1/MedicineInInventoryDetails';
const APIELIMINATEMEDICINE = URLSERVER + '/api/v1/EliminateMedicines';
const APIPATIENTSEARCH = URLSERVER + '/api/v1/Patients/Searching';
const APIPATIENT = URLSERVER + '/api/v1/Patients';
const APIPATIENTBYINTERNALCODE = URLSERVER + '/api/v1/Patients/InternalCode';
const APISEARCHTREATMENTINFORMATION =
    URLSERVER + '/api/v1/Treatments/Searching';
const APITREATMENTINFORMATION = URLSERVER + '/api/v1/Treatments';
const APICONFIRMTREATMENTINFORMATION =
    URLSERVER + '/api/v1/Treatments/ConfirmTreatment';
const APIDIAGNOSTICSEARCH = URLSERVER + '/api/v1/Diagnostics/Searching';
const APIDIAGNOSTIC = URLSERVER + '/api/v1/Diagnostics';
const APIALLERGY = URLSERVER + '/api/v1/Allergies';
const APIALLERGYSEARCH = URLSERVER + '/api/v1/Allergies/Searching';
const APICONTRAINDICATIONSEARCH =
    URLSERVER + '/api/v1/Contraindications/Searching';
const APICONTRAINDICATION = URLSERVER + '/api/v1/Contraindications';
const APINOTIFICATIONSEARCH =
    URLSERVER + '/api/v1.0/NotificationApplications/Searching/Notification';
const APINOTIFICATIONHISTORYACTIONSEARCH = URLSERVER +
    '/api/v1.0/NotificationApplications/Searching/HistoryAction/Account';
const APINOTIFICATIONCLICK =
    URLSERVER + '/api/v1.0/NotificationApplications/Clicking/Notification';
const APIGETAPP = URLSERVER + '/api/v1.0/Medias/MobileApp';
