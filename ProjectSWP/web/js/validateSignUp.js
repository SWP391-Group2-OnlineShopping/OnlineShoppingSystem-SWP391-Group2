function validateField(id, regex, errorMessage) {
    const field = document.getElementById(id);
    const errorDiv = document.getElementById(id + 'Error');
    if (!regex.test(field.value)) {
        errorDiv.innerText = errorMessage;
        return false;
    } else {
        errorDiv.innerText = '';
        return true;
    }
}

document.getElementById('firstname').addEventListener('blur', function () {
    validateField('firstname', /^[A-Za-zÀ-ỹ\s]+$/, 'First name should contain only alphabets and spaces.');
});

document.getElementById('lastname').addEventListener('blur', function () {
    validateField('lastname', /^[A-Za-zÀ-ỹ\s]+$/, 'Last name should contain only alphabets and spaces.');
});

document.getElementById('email').addEventListener('blur', function () {
    validateField('email', /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, 'Invalid email format.');
});

document.getElementById('phonenumber').addEventListener('blur', function () {
    validateField('phonenumber', /^[0-9]{7,11}$/, 'Phone number must be 7-11 digits long and contain only numbers.');
});

document.getElementById('address').addEventListener('blur', function () {
    validateField('address', /^[A-Za-z0-9,.() ]+$/, 'Address contains invalid characters.');
});

document.getElementById('password').addEventListener('blur', function () {
    validateField('password', /^.{10,15}$/, 'Password must be 10-15 characters long.');
});

document.getElementById('confirmpassword').addEventListener('blur', function () {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmpassword').value;
    const errorDiv = document.getElementById('confirmpasswordError');
    if (password !== confirmPassword) {
        errorDiv.innerText = 'Password and Confirm Password do not match.';
    } else {
        errorDiv.innerText = '';
    }
});

function validateForm() {
    let isValid = true;
    isValid &= validateField('firstname', /^[A-Za-zÀ-ỹ\s]+$/, 'First name should contain only alphabets and spaces.');
    isValid &= validateField('lastname', /^[A-Za-zÀ-ỹ\s]+$/, 'Last name should contain only alphabets and spaces.');
    isValid &= validateField('email', /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, 'Invalid email format.');
    isValid &= validateField('phonenumber', /^[0-9]{7,11}$/, 'Phone number must be 7-11 digits long and contain only numbers.');
    isValid &= validateField('address', /^[A-Za-z0-9,.() ]+$/, 'Address contains invalid characters.');
    isValid &= validateField('password', /^.{10,15}$/, 'Password must be 10-15 characters long.');

    const gender = document.querySelector('input[name="gender"]:checked');
    if (!gender) {
        document.getElementById('genderError').innerText = 'Please select a gender.';
        isValid = false;
    } else {
        document.getElementById('genderError').innerText = '';
    }

    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmpassword').value;
    if (password !== confirmPassword) {
        document.getElementById('confirmpasswordError').innerText = 'Password and Confirm Password do not match.';
        isValid = false;
    } else {
        document.getElementById('confirmpasswordError').innerText = '';
    }

    return !!isValid;
}