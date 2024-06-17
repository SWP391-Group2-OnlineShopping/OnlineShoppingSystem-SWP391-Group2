$(document).ready(function () {
    // Initialize DataTables with custom sorting for checkboxes
    $.fn.dataTable.ext.order['dom-checkbox'] = function (settings, col) {
        return this.api().column(col, {order: 'index'}).nodes().map(function (td, i) {
            return $('input', td).prop('checked') ? 1 : 0;
        });
    };

    var table = $('#staffTable').DataTable({
        "autoWidth": false,
        "columnDefs": [
            {"orderable": true, "targets": [0, 1, 2, 3, 4, 5, 6]}, // Enable sorting on ID, Full Name, Gender, Email, Mobile, Role, Status
            {"orderable": false, "targets": [7]}, // Disable sorting on Actions
            {"orderDataType": "dom-checkbox", "targets": [6]} // Custom sort for Status
        ],
        "order": [[0, "asc"]], // Default sort by ID
        "columns": [
            null, null, null, null, null, null, {"orderDataType": "dom-checkbox"}, null
        ],
        "ordering": true,
        "orderMulti": false // Disable multi-column sorting
    });

    // Initialize Select2 for role, gender, and status filters
    function initializeSelect2(columnIndex, placeholderText, values) {
        table.columns(columnIndex).every(function () {
            var column = this;
            var select = $('<select class="form-control"><option value="">All</option></select>')
                    .appendTo($(column.header()).empty())
                    .on('change', function () {
                        var val = $.fn.dataTable.util.escapeRegex(
                                $(this).val()
                                );
                        column.search(val ? '^' + val + '$' : '', true, false).draw();
                    });

            values.forEach(function (value) {
                select.append('<option value="' + value + '">' + value + '</option>');
            });

            $(select).select2({
                placeholder: placeholderText,
                allowClear: true,
                width: 'resolve',
                dropdownAutoWidth: true
            }).on('select2:unselecting', function (e) {
                $(this).data('unselecting', true);
            }).on('select2:open', function (e) {
                if ($(this).data('unselecting')) {
                    $(this).select2('close');
                    $(this).removeData('unselecting');
                }
            });
        });
    }

    // Initialize filters for Role, Gender, and Status
    initializeSelect2(2, 'Gender', ['Male', 'Female']);
    initializeSelect2(5, 'Role', ['Admin', 'Sale Manager', 'Sale', 'Marketer']);
    initializeSelect2(6, 'Status', ['Active', 'Ban', 'Closed', 'Suspended', 'Locked']);

    // Handle dynamic checkbox change events
    $(document).on('change', 'input[id^="status-"]', function () {
        var checkbox = $(this);
        var staffId = checkbox.attr('id').split('-')[1];
        var status = checkbox.is(':checked') ? 'Active' : 'Inactive';
        console.log('Sending:', {staffID: staffId, status: status});
        $.ajax({
            url: 'updateStaffStatus',
            type: 'POST',
            data: {
                staffID: staffId,
                status: status
            },
            success: function (response) {
                console.log('Response:', response);
                if (!response.updated) {
                    checkbox.prop('checked', status === 'Inactive');
                }
            },
            error: function (error) {
                console.log('Error:', error);
                checkbox.prop('checked', status === 'Inactive');
            }
        });
    });

    // Search functionality
    $('#searchInput').on('keyup', function () {
        table.search(this.value).draw();
    });

    // Show the modal when the button is clicked
    // Show the modal when the button is clicked
$('#addStaffBtn').click(function () {
    $('#addStaffModal').modal('show');
});

// Validate input fields in real-time
function validateField(field, errorField, validationFn) {
    $(field).on('input change', function () {
        if (!validationFn($(this).val())) {
            $(errorField).show();
        } else {
            $(errorField).hide();
        }
    });
}

// Validation functions
const isNotEmpty = value => value.trim() !== '';
const isValidEmail = value => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
const isValidPhone = value => /^\d{7,11}$/.test(value);
const isValidPassword = value => value.length >= 10 && value.length <= 15;
const isValidDate = value => {
    var selectedDate = new Date(value);
    var today = new Date();
    return selectedDate <= today;
};
const isValidAddress = value => /^[a-zA-Z0-9ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s,.'-]{3,}$/.test(value);
const isValidAvatar = fileName => {
    const allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
    return allowedExtensions.test(fileName);
};

// Real-time validations
validateField('#fullName', '#fullNameError', isNotEmpty);
validateField('#email', '#emailError', isValidEmail);
validateField('#mobile', '#mobileError', isValidPhone);
validateField('#password', '#passwordError', isValidPassword);
validateField('#address', '#addressError', isValidAddress);

// Set the maximum date to today for date of birth
$(document).ready(function () {
    var today = new Date().toISOString().split('T')[0];
    $('#dob').attr('max', today);

    // Validate Date of Birth on input and change
    $('#dob').on('input change', function() {
        if (!isValidDate($(this).val())) {
            $('#dobError').show();
        } else {
            $('#dobError').hide();
        }
    });

    // Validate Avatar on change
    $('#avatar').on('change', function() {
        const fileName = $(this).val().split('\\').pop();
        if (!isValidAvatar(fileName)) {
            $('#avatarError').show();
        } else {
            $('#avatarError').hide();
        }
    });
});

// Handle form submission for Add Staff Form
$('#addStaffForm').submit(function (e) {
    e.preventDefault();
    let isValid = true;

    // Check if any error messages are visible
    $('.error').each(function () {
        if ($(this).is(':visible')) {
            isValid = false;
        }
    });

    // Check if date of birth is valid
    var dob = $('#dob').val();
    if (!isValidDate(dob)) {
        $('#dobError').show();
        isValid = false;
    } else {
        $('#dobError').hide();
    }

    // Check if avatar is valid
    const avatarFileName = $('#avatar').val().split('\\').pop();
    if (!isValidAvatar(avatarFileName)) {
        $('#avatarError').show();
        isValid = false;
    } else {
        $('#avatarError').hide();
    }

    if (isValid) {
        var formData = new FormData(this); // Use FormData to handle file upload

        // Log formData before sending
        formData.forEach((value, key) => {
            console.log(key + ": " + value);
        });

          $.ajax({
            url: 'addStaff',
            method: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                console.log("Server response:", response); // Log the response
                if (response.status === 'success') {
                    Swal.fire({
                        icon: 'success',
                        title: 'Staff added successfully',
                        showConfirmButton: false,
                        timer: 1500,
                        position: 'center'
                    }).then(() => {
                        $('#addStaffModal').modal('hide');
                        location.reload();
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error adding staff',
                        text: response.message,
                        position: 'center'
                    });
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("AJAX error status:", textStatus); // Log the text status
                console.log("AJAX error thrown:", errorThrown); // Log the error thrown
                console.log("Response Text:", jqXHR.responseText); // Log the response text
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Something went wrong!',
                    position: 'center'
                });
            }
        });
    }
});

    // Handle form submission for Edit Staff Form
    $('#editStaffForm').submit(function (e) {
        e.preventDefault();
        let isValid = true;

        // Check if any error messages are visible
        $('.error').each(function () {
            if ($(this).is(':visible')) {
                isValid = false;
            }
        });

        if (isValid) {
            var formData = new FormData(this); // Use FormData to handle file upload

            $.ajax({
                url: 'updateStaff',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Staff updated successfully',
                            showConfirmButton: false,
                            timer: 1500,
                            position: 'center'
                        }).then(() => {
                            $('#editStaffModal').modal('hide');
                            location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error updating staff',
                            text: response.message,
                            position: 'center'
                        });
                    }
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Something went wrong!',
                        position: 'center'
                    });
                }
            });
        }
    });

    // Show Add Staff Modal
    $('#addStaffBtn').click(function () {
        $('#addStaffModal').modal('show');
    });

    // Handle edit staff details
    $(document).on('click', '.editBtn', function () {
        const staffId = $(this).data('id');
        $.ajax({
            url: 'getStaffDetails',
            type: 'GET',
            data: {staffId: staffId},
            dataType: 'json',
            success: function (staff) {
                $('#editStaffId').val(staff.staffID);
                $('#editFullName').val(staff.fullName);
                $('#editGender').val(staff.gender ? 'Male' : 'Female');
                $('#editEmail').val(staff.email);
                $('#editMobile').val(staff.mobile);
                $('#editRole').val(staff.role);
                $('#editAddress').val(staff.address);
                $('#editStatus').prop('checked', staff.status === 'Active');

                $('#editStaffModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch staff details:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
    });

    // Handle view staff details
    $(document).on('click', '.viewBtn', function () {
        const staffId = $(this).data('id');
        $.ajax({
            url: 'getStaffDetails',
            type: 'GET',
            data: {staffId: staffId},
            dataType: 'json',
            success: function (staff) {
                $('#viewAvatar').attr('src', staff.avatar); // Assuming avatar is a URL
                $('#viewStaffId').text(staff.staffID);
                $('#viewFullName').text(staff.fullName);
                $('#viewGender').text(staff.gender ? 'Male' : 'Female');
                $('#viewEmail').text(staff.email);
                $('#viewMobile').text(staff.mobile);
                $('#viewRole').text(roleMapping[staff.role] || staff.role); // Use role mapping
                $('#viewAddress').text(staff.address);
                $('#viewStatus').text(statusMapping[staff.status] || staff.status);

                $('#viewStaffModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch staff details:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
    });
});

// Role and status mapping
const roleMapping = {
    1: 'Admin',
    2: 'Sale Manager',
    3: 'Sale',
    4: 'Marketer'
};

const statusMapping = {
    1: 'Active',
    2: 'Ban',
    3: 'Closed',
    4: 'Suspended',
    5: 'Locked'
};