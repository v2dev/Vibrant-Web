function confirmDelete(isdisabled) {
    if (!isdisabled) {
        var agree = confirm("Are you sure you want to mark this record as deleted ?");
        if (agree)
            return true;
        else
            return false;
    }
    else {
        return false;
    }
}

function ShouldDelete(CheckboxID, isdisabled) {
    if (!isdisabled) {
        var IsDelete;
        IsDelete = true;

        for (i = 0; i < document.forms[0].elements.length; i++) {
            var elm = document.forms[0].elements[i];
            var Objname = elm.name;
            if (elm.type == 'checkbox') {
                var str = Objname.substring((Objname.length - CheckboxID.length));
                if (str == CheckboxID) {
                    IsDelete = false;
                    if (elm.checked == true) {
                        IsDelete = true;
                        var agree = confirm("Are you sure you want to mark this record as deleted ?");
                        if (agree)
                            return true;
                        else
                            return false;
                    }
                }
            }
        }
        if (IsDelete == false) {
            alert("Atleast one record must be selected to Delete");
            return false;
        }
        else {
            var agree = confirm("Are you sure you want to mark this record as deleted ?");
            if (agree)
                return true;
            else
                return false;
        }
    }
    else {
        return false;
    }
}

function checkCatalogs(source, destination) {
    var sourceCatalog, destCatalog;
    sourceCatalog = document.getElementById(source).value;
    destCatalog = document.getElementById(destination).value;

    if (sourceCatalog == destCatalog) {
        alert("The Source and Destination Catalog names are same");
        return false;
    }
}

function checkUnits(fromUom, toUom) {
    var fromunit, tounit;
    fromunit = document.getElementById(fromUom).value;
    tounit = document.getElementById(toUom).value;

    if (fromunit == tounit) {
        alert("The Unit names are same");
        return false;
    }
}

function showHelpText(isdisabled, TransactionID) {
    if (isdisabled) {
        return false;
    }
    else {
        //alert(TransactionID);
        window.open("../help.aspx?TransactionId=" + TransactionID, "Help", "scrollbars=yes,width=480,height=300");
        return false
    }
}

function isRequire(names, captions, isdisabled) {
    /*
     Two parameter
     First Parameter is ^ seperated Objects name like - txtName^txtAddress
     Second Parameter is ^ seperated Captions for messgae  - Name^Contact Infomation
    */

    var nam = names.split("^");
    var cap = captions.split("^");
    var frm = document.forms[0];
    var msg = "";
    var strVal = "";
    var msg1 = ""
    for (intform = 0; intform < nam.length; intform++) {
        //alert("in isRequire");
        if (document.getElementById(nam[intform]).type == "select-one") {
            //alert("in select-one");
            if (document.getElementById(nam[intform]).selectedIndex <= 0) {
                if (msg != "")
                    msg = msg + ","
                msg = msg + cap[intform]
            }
        }
        else if ((document.getElementById(nam[intform]).type == "text") || (document.getElementById(nam[intform]).type == "password")) {
            //alert("in text");
            strVal = document.getElementById(nam[intform]).value;
            strVal = Trim(strVal);
            //alert(strVal=="")
            if (strVal == "") {
                if (msg != "")
                    msg = msg + ","
                msg = msg + cap[intform];
                //alert("msg");
                //alert(msg);
            }
        }
        else if (document.getElementById(nam[intform]).value == "") {
            //alert ("Please enter the value for " + captions);
            if (msg != "")
                msg = msg + ","
            msg = msg + cap[intform];
        }

        msg1 = isMultipleRequire(nam[intform], cap[intform]);

        if (msg1 != "") {
            msg = msg + "," + msg1
        }
        else {
            msg = msg;
        }
    }
    if (msg == "") {
        return true;
    }
    else {
        //alert ("Please enter the value for " + msg);
        alert("Please enter the value for " + msg);
        return false;
    }
}
//return false

function isMultipleRequire(object, caption) {
    var msg2 = ""

    if (document.forms[0].elements[object].length > 0) {
        if ((document.forms[0].elements[object][0].type == "radio")) {
            var i;
            for (i = 0; i < document.forms[0].elements[object].length; i++) {
                if (document.forms[0].elements[object][i].checked == true) {
                    break;
                }
            }

            if (i == document.forms[0].elements[object].length) {
                msg2 = caption
            }
        }
    }
    return msg2
}

/*function isCheckBoxRequire(){
}*/

function Trim(sInString) {
    //alert("inside trim");
    sInString = sInString.replace(/^\s+/g, "");// strip leading
    return sInString.replace(/\s+$/g, "");// strip trailing
}

//The function is used to check whether the value entered by the user is a number or text.If the value is text, then the textfield will be made blank.

function checkNumeric(number, msgString) {
    if (isNaN(number.value - 0)) {
        number.value = "";
        alert("Please enter only numeric value for " + msgString);
        number.focus();
        return false;
    }
    else {
        if (number.value.indexOf('e') >= 0) {
            number.value = "";
            alert("Please enter only numeric value for " + msgString);
            number.focus();
            return false;
        }
        else {
            return true;
        }
    }
}

function checkInt(number, msgString) {
    if (isNaN(number.value - 0)) {
        number.value = "";
        alert("Please enter only numeric value for " + msgString);
        number.focus();
        return false;
    }
    else {
        if (number.value.indexOf('e') >= 0) {
            number.value = "";
            alert("Please enter only numeric value for " + msgString);
            number.focus();
            return false;
        }
        else {
            if (number.value.indexOf('.') >= 0) {
                number.value = "";
                alert("Please enter only numeric value for " + msgString);
                number.focus();
                return false;
            }
            else {
                return true;
            }
        }
        return false;
    }
}

//Added by Swati S.
function isInteger(names, captions) {
    var nam = names.split("^");
    var cap = captions.split("^");

    var bool = true;

    var frm = document.forms[0];
    var msg = "";
    var strVal = "";
    var msg1 = ""

    for (intform = 0; intform < nam.length; intform++) {
        strVal = document.getElementById(nam[intform]).value;
        strVal = Trim(strVal);

        if (checkForSpecialChar("0123456789", document.forms[0].elements[nam[intform]])) {
            alert("The " + cap[intform] + " can contain only numbers");
            bool = false;
            break
        }
    }

    return bool;
}

//check email address
//onBlur="return emailCheck(this,this.value)"
function emailCheck(name, emailStr) {
    if (emailStr != "") {
        var checkTLD = 1;
        var knownDomsPat = /^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
        var emailPat = /^(.+)@(.+)$/;
        var specialChars = "\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
        var validChars = "\[^\\s" + specialChars + "\]";
        var quotedUser = "(\"[^\"]*\")";
        var ipDomainPat = /^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
        var atom = validChars + '+';
        var word = "(" + atom + "|" + quotedUser + ")";
        var userPat = new RegExp("^" + word + "(\\." + word + ")*$");
        var domainPat = new RegExp("^" + atom + "(\\." + atom + ")*$");
        var matchArray = emailStr.match(emailPat);

        if (matchArray == null) {
            alert("Email address seems incorrect");
            //document.getElementByID(name).value="";
            //document.getElementByID(name).focus();
            return false;
        }
    }
    /*var user=matchArray[1];
    var domain=matchArray[2];
    domain=domain.toLowerCase();
    for (i=0; i<user.length; i++) {
        if (user.charCodeAt(i)>127) {
            alert("Ths EmailID contains invalid characters.");
            name.value="";
            name.focus();
            return "";
        }
    }
    for (i=0; i<domain.length; i++) {
        if (domain.charCodeAt(i)>127) {
            alert("Ths domain name contains invalid characters.");
            name.value="";
            name.focus();
            return "";
        }
    }
    if (user.match(userPat)==null) {
        alert("The username doesn't seem to be valid.");
        name.value="";
        name.focus();
        return "";
    }
    var IPArray=domain.match(ipDomainPat);
    if (IPArray!=null) {
        for (var i=1;i<=4;i++) {
        if (IPArray[i]>255) {
        alert("Destination IP address is invalid!");
        name.value="";
        name.focus();
        return "";
        }
        }
    return name.value;
    }
    var atomPat=new RegExp("^" + atom + "$");
    var domArr=domain.split(".");
    var len=domArr.length;
    for (i=0;i<len;i++) {
    if (domArr[i].search(atomPat)==-1) {
    alert("The domain name does not seem to be valid.");
    name.value="";
    name.focus();
    return "";
    }
    }
    if (checkTLD && domArr[domArr.length-1].length!=2 &&
    domArr[domArr.length-1].search(knownDomsPat)==-1) {
    alert("The address must end in a well-known domain or two letter " + "country.");
    //document.getElementById(name).focus();
    name.value="";
    name.focus();
    return "";
    }
    if (len<2) {
    alert("This address is missing a hostname!");
    name.value="";
    name.focus();
    return "";
    }

    return name.value;
    }
else
    return name.value;*/
}

// check min length of string value
function checkString(str, Min, Message) {
    if (str.value.length >= Min)
        return true;
    else
        alert(Message);
    str.value = "";
    //str.focus();
    return false;
}

// confirm Pwd

function ConfirmPassword(Pwd, ConfPwd) {
    if (document.getElementById(Pwd).value == document.getElementById(ConfPwd).value)
        return true;
    else {
        document.getElementById(Pwd).value = "";
        document.getElementById(ConfPwd).value = "";
        alert("Your passwords do not match.");
        document.getElementById(Pwd).focus();
        return false;
    }
}

function goback() {
    history.back();
    return false;
}

//This function restrics the lenght of the text contained in the textbox to 255
//No characters will be accepted once the length crosses 255.
function CheckMultilineTextMaxLength(TxtBx, maxLength) {
    if (TxtBx.value.length > maxLength) {
        TxtBx.value = TxtBx.value.substr(0, maxLength);
    }
}
//To compare two dates
function CompTime(Hours1, Minutes1, Hours2, Minutes2, msg) {
    objHours1 = document.forms[0].elements[Hours1];
    objHours2 = document.forms[0].elements[Hours2];
    objMinutes1 = document.forms[0].elements[Minutes1];
    objMinutes2 = document.forms[0].elements[Minutes2];
    var valHours1 = objHours1[objHours1.selectedIndex].value;
    var valHours2 = objHours2[objHours2.selectedIndex].value;
    var valMinutes1 = objMinutes1[objMinutes1.selectedIndex].value;
    var valMinutes2 = objMinutes2[objMinutes2.selectedIndex].value;
    T1 = new Date(2006, 01, 01, valHours1, valMinutes1, 00);
    T2 = new Date(2006, 01, 01, valHours2, valMinutes2, 00);
    //To compare two times
    if (T1.getTime() >= T2.getTime()) {
        alert(msg);
        return false;
    }
    else {
        return true;
    }
}

//This function will accept two Date parameter.
//Return true is the First Parameter is <= then second

function CompDate(sdate, udate, msg) {
    var aDate = new Date(document.getElementById(udate).value);
    //alert(aDate);
    var bDate = new Date(document.getElementById(sdate).value);
    if (bDate > aDate) {
        alert(msg);
        return false
    }
    else return true;
    /*// The number of milliseconds in one day
        var ONE_DAY = 1000 * 60 * 60 * 24

        // Convert both dates to milliseconds
        var date1_ms = aDate.getTime()
        var date2_ms = bDate.getTime()

         // Calculate the difference in milliseconds
        var difference_ms = Math.abs(date1_ms - date2_ms)

        // Convert back to days and return
        Days = Math.round(difference_ms/ONE_DAY)

    if (Days<15)
    {
    alert(msg);
    return false;
    }
    else
    {
    return true;
    }*/
}

function CompDateweek(sdate, udate, msg) {
    var aDate = new Date(document.getElementById(udate).value);
    var bDate = new Date(document.getElementById(sdate).value);
    // The number of milliseconds in one day
    var ONE_DAY = 1000 * 60 * 60 * 24

    // Convert both dates to milliseconds
    var date1_ms = aDate.getTime()
    var date2_ms = bDate.getTime()

    // Calculate the difference in milliseconds
    var difference_ms = Math.abs(date1_ms - date2_ms)

    // Convert back to days and return
    Days = Math.round(difference_ms / ONE_DAY)
    if (Days < 7) {
        alert(msg);
        return false;
    }
    else {
        return true;
    }
}

function lessThanCurrentDate(adate) {
    a = adate.split('/');

    var sDate = new Date(a[2], a[0] - 1, a[1]);
    var eDate = new Date();

    if (sDate > eDate) {
        return false;
    }
    else {
        return true;
    }
}

// Added by Amit thakkar

function validateNPhoneFax(names, captions) {
    var nam = names.split("^");
    var cap = captions.split("^");

    var bool = true;

    var frm = document.forms[0];
    var msg = "";
    var strVal = "";
    var msg1 = ""

    for (intform = 0; intform < nam.length; intform++) {
        strVal = document.getElementById(nam[intform]).value;
        strVal = Trim(strVal);

        if (checkForSpecialChar("0123456789-() ", document.forms[0].elements[nam[intform]])) {
            alert("The " + cap[intform] + " can contain only numbers,( ), hyphens and spaces!");
            bool = false;
            break
        }

        if (strVal != "") {
            if ((strVal.length > 20) || (strVal.length < 4)) {
                alert("The " + cap[intform] + " should be at least 4 characters long and a maximum of 20 characters!");
                bool = false;
                break;
            }
        }
    }

    return bool;
}

function checkForSpecialChar(sStr, obj) {
    // string containing the permissable characters
    var sPermChars = sStr;

    // string that is to be validated

    var sPassedStr = obj.value;
    var iCtr, iCt;
    var ch;

    for (iCtr = 0; iCtr < sPassedStr.length; iCtr++) {
        ch = sPassedStr.charAt(iCtr);

        // check for the entire length of the string
        for (iCt = 0; iCt < sPermChars.length; iCt++)
            if (ch == sPermChars.charAt(iCt))
                break;

        if (iCt == sPermChars.length)
            break;
    }

    if (iCtr != sPassedStr.length)
        return (true);
    else
        return (false);
} // end of function to check for special characters

function validateEmail(sStr, caption) {
    try {
        componentID = sStr
        var component = document.getElementById(componentID);
        var componentValue;
        if (component != null) componentValue = Trim(component.value);

        if (componentValue.length <= 0) {
            return true;
        }

        var splitted = componentValue.match("^(.+)@(.+)$");

        if (splitted == null) {
            alert("The " + caption + " should be in proper format");
            component.value = "";
            component.focus();
            return false;
        }

        if (splitted[1] != null) {
            var regexp_user = /^\"?[\w-_\.]*\"?$/;
            if (splitted[1].match(regexp_user) == null) {
                alert("The " + caption + " should be in proper format");
                component.value = "";
                component.focus();
                return false;
            }
        }

        if (splitted[2] != null) {
            var regexp_domain = /^[\w-\.]*\.[A-Za-z]{2,4}$/;

            if (splitted[2].match(regexp_domain) == null) {
                var regexp_ip = /^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
                if (splitted[2].match(regexp_ip) == null) {
                    alert("The " + caption + " should be in proper format");
                    component.value = "";
                    component.focus();
                    return false;
                }
            }

            return true;
        }

        return false;
    }
    catch (err) {
        txt = "There was an error on this page.\n\n"
        txt += "Error description: " + err.description + "\n\n"
        txt += "Click OK to continue.\n\n"
        alert(txt)
        return false;
    }
}

function validateContact(names, caption) {
    var bool = true;

    if (checkForSpecialChar("0123456789-() ", document.forms[0].elements[names])) {
        alert("The " + caption + " can contain only numbers,( ), hyphens and spaces!");
        bool = false;
    }
    return bool;
}

function validateName(names, caption) {
    var bool = true;
    if (checkForSpecialChar("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' ", document.forms[0].elements[names])) {
        alert("The " + caption + " can contain only Alpabets and single quote(')");
        bool = false;
    }

    return bool;
}

function validateZipCode(names, caption) {
    var bool = true;
    strVal = document.forms[0].elements[names].value;
    strVal = Trim(strVal);
    if (checkForSpecialChar("0123456789", document.forms[0].elements[names])) {
        alert("The " + caption + " can contain only numbers!");
        bool = false;
    }

    if (strVal.length != 5) {
        alert("The " + caption + " should be 5 characters long");
        bool = false;
    }
    return bool;
}

function validateRooms(names, caption)//added byVruddhi Vasoo
{
    if (checkForSpecialChar("0123456789", document.forms[0].elements[names])) {
        alert("The " + caption + " can contain only numbers!");
        return false;
    }

    return true;
}

function validateCurrency(names, caption)//added byVruddhi Vasoo
{
    if (checkForSpecialChar("0123456789 ,", document.forms[0].elements[names])) {
        alert("The " + caption + " can contain only numbers!");
        return false;
    }

    return true;
}
//added by Vruddhi Vasoo
function popup(url) {
    newwindow = window.open(url, 'name', 'height=1,width=1,top=1000,left=1000');
    if (window.focus) { newwindow.focus() }
    return false;
}

//added by Vruddhi Vasoo
function print() {
    //newwindow=window.open(url,'name','height=100,width=100,top=1000,left=1000');
    window.print();
    window.close();
    return false;
}

//added by Vruddhi Vasoo
function smallpopup(url) {
    newwindow = window.open(url, 'name', 'height=100,width=200,top=150,left=300');
    if (window.focus) { newwindow.focus() }
    return false;
}

function checkNumeric(names, captions) {
    var bool = true;

    var frm = document.forms[0];
    var msg = "";
    var strVal = "";
    var msg1 = ""

    for (intform = 0; intform < names.length; intform++) {
        strVal = document.getElementById(names).value;
        //strVal=Trim(strVal);

        if (checkForSpecialChar("0123456789", document.forms[0].elements[names])) {
            alert("The " + captions + " can contain only numbers");
            document.getElementById(names).value = "";
            document.getElementById(names).focus();
            bool = false;
            break
        }
    }

    return bool;
}

// isRequired by Added to Amit.

function isRequired(names, captions) {
    strVal = document.getElementById(names).value;
    strVal = Trim(strVal);
    //alert(strVal)
    if (strVal == "") {
        alert("Please enter the value for " + captions);
        return false;
    }

    if (document.getElementById(nam[intform]).type == "select-one") {
        if (document.getElementById(nam[intform]).selectedIndex <= 0) {
            if (msg != "")
                msg = msg + ","
            msg = msg + cap[intform]
            return false;
        }
    }
}

//added by Vruddhi Vasoo (14 March 2007)
function validateV2Email(strEmail, caption) {
    var email = document.getElementById(strEmail).value;
    if (document.getElementById(strEmail).value != "") {
        //alert(strEmail);
        //alert(document.getElementById(strEmail).value);
        //alert(email.value);
        var findString = email.indexOf('@v2solutions.com');
        //alert(findString);
        if (findString >= 0) {
            return true;
        }
        else {
            alert(caption + " is not in a proper format. Please enter valid V2 Solutions emailID.");
            document.getElementById(strEmail).value = "";
            document.getElementById(strEmail).focus();
            //email.focus();
            return false;
        }
    }
    else if (document.getElementById(strEmail).value == "") {
        return true;
    }
}
//Added by Vruddhi
/*It adds the counter on any text field and limits the text to be entered to the max limit specified.
'field' is the textField where the limit is to be set.
'countfield' is the text field which displays the no of charaters that can be entered in the field.
'maxlimit' is the maximum no of characters that can be permitted.
*/
function textCounter(field, countfield, maxlimit) {
    if (field.value.length > (maxlimit)) {
        field.value = field.value.substring(0, (maxlimit));
    }
    else {
        //alert(maxlimit + "," + field.value.length);
        countfield.value = (maxlimit) - field.value.length;
    }
}

function CheckAllDataGridCheckBoxes(aspCheckBoxID, checkVal) {
    //alert(checkVal);
    re = new RegExp('$' + aspCheckBoxID + '$');  //generated control name starts with a dollar
    for (i = 0; i < document.forms[0].elements.length; i++) {
        elm = document.forms[0].elements[i];
        //alert(elm.type)
        if (elm.type == 'checkbox') {
            elm.checked = checkVal;
        }
    }
}
function CheckDataGridCheckBox(aspCheckBoxID, checkVal) {
    //alert("Hi!");
    re = new RegExp('$' + aspCheckBoxID + '$');  //generated control name starts with a dollar
    if (checkVal == false) {
        for (i = 0; i < document.forms[0].elements.length; i++) {
            elm = document.forms[0].elements[i];
            if (elm.type == 'checkbox') {
                if (re.test(elm.name)) {
                    elm.checked = false;
                }
            }
        }
    }
}