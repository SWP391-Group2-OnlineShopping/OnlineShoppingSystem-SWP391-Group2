$(document).ready(function () {
    // Initialize DataTables with custom sorting for checkboxes
    $.fn.dataTable.ext.order['dom-checkbox'] = function (settings, col) {
        return this.api().column(col, { order: 'index' }).nodes().map(function (td, i) {
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
        ]
    });

    // Initialize Select2 for role, gender, and status filters
    function initializeSelect2(columnIndex, placeholderText, values) {
        table.columns(columnIndex).every(function () {
            var column = this;
            var select = $('<select multiple="multiple" class="form-control"><option value=""></option></select>')
                .appendTo($(column.header()).empty())
                .on('change', function () {
                    var vals = $(this).val();
                    var searchStr = '';
                    if (vals) {
                        searchStr = vals.join('|');
                    }
                    column.search(searchStr, true, false).draw();
                });

            values.forEach(function (value) {
                select.append('<option value="' + value + '">' + value + '</option>');
            });

            $(select).select2({
                placeholder: placeholderText,
                allowClear: false,
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
        console.log('Sending:', { staffID: staffId, status: status });
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
    const isValidPhone = value => /^\d+$/.test(value);

    // Real-time validations
    validateField('#fullName', '#fullNameError', isNotEmpty);
    validateField('#email', '#emailError', isValidEmail);
    validateField('#mobile', '#mobileError', isValidPhone);

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

        console.log('Form validation state for staff:', isValid);
        if (isValid) {
            var formData = $(this).serialize();
            console.log('Submitting form data for staff:', formData);

            $.ajax({
                url: 'AddStaff',
                method: 'POST',
                data: formData,
                success: function (response) {
                    console.log('Staff Response:', response);
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
            data: { staffId: staffId },
            dataType: 'json',
            success: function (staff) {
                $('#editStaffId').val(staff.staffID);
                $('#editFullName').val(staff.fullName);
                $('#editGender').val(staff.gender ? 'Male' : 'Female');
                $('#editEmail').val(staff.email);
                $('#editMobile').val(staff.mobile);
                $('#editRole').val(staff.role);
                $('#editStatus').prop('checked', staff.status === 'Active');

                $('#editStaffModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch staff details:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
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

        console.log('Form validation state for staff:', isValid);
        if (isValid) {
            var formData = $(this).serialize();
            console.log('Submitting form data for staff:', formData);

            $.ajax({
                url: 'updateStaff',
                method: 'POST',
                data: formData,
                success: function (response) {
                    console.log('Staff Response:', response);
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
                error: function (jqXHR, textStatus, errorThrown) {
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

    // Delete staff
    $(document).on('click', '.deleteBtn', function () {
        var staffId = $(this).closest('tr').find('td:first').text();
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'deleteStaff',
                    type: 'POST',
                    data: {
                        staffID: staffId
                    },
                    success: function (response) {
                        if (response.deleted) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Your staff has been deleted',
                                showConfirmButton: false,
                                timer: 1500,
                                position: 'center'
                            }).then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Something went wrong!',
                                position: 'center'
                            });
                        }
                    },
                    error: function (error) {
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
    });
});
