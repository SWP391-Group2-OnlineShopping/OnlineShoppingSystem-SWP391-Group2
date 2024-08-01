/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
//show add modal
document.getElementById('addVoucherBtn').addEventListener('click', function () {
    $('#voucherAddModal').modal('show');
});

//Add Voucher
document.getElementById('voucherAddForm').addEventListener('submit', function (event) {
    event.preventDefault(); // Ngăn không cho form gửi đi nếu validation thất bại

    var isValid = true;
    var formElements = this.elements;

    // Duyệt qua các trường input
    for (var i = 0; i < formElements.length; i++) {
        var field = formElements[i];

        if (field.type !== 'submit' && field.type !== 'hidden') {
            var value = field.value.trim(); // Loại bỏ khoảng trắng đầu dòng

            if (!value) {
                isValid = false;
                alert('Please fill in the ' + field.name + ' field.');
                break;
            }

            // Kiểm tra modalPercent có giá trị hợp lệ hay không
            if (field.name === 'percent') {
                var percentValue = parseFloat(value);
                if (isNaN(percentValue) || percentValue < 0 || percentValue > 100) {
                    isValid = false;
                    alert('Percent must be a number between 0 and 100.');
                    break;
                }
            }

            // Kiểm tra modalRequirement có giá trị hợp lệ hay không
            if (field.name === 'requirement') {
                var requirementValue = parseFloat(value);
                if (isNaN(requirementValue) || requirementValue < 0) {
                    isValid = false;
                    alert('Voucher requirement must be a number greater than or equal to 0.');
                    break;
                }
            }
        }
    }

    if (isValid) {
        // Thu thập dữ liệu từ form
        var formData = $(this).serialize();

        $.ajax({
            type: 'POST',
            url: 'AddVoucher',
            data: formData,
            success: function (response) {
                // Handle success
                alert('Voucher added successfully!');
                $('#voucherAddModal').modal('hide');
                console.log("Form Data: ", formData);
                loadResult('MKTVoucherList');

                //delete form data
                $('#voucherAddForm')[0].reset();
            },
            error: function (xhr, status, error) {
                // Handle error
                alert('An error occurred: ' + error);
            }
        });
    }
});

//show edit modal
function showEditModal(voucherID) {
    // send Ajax request to get data of a voucher
    $.ajax({
        url: 'MKTVoucherDetail',
        type: 'GET',
        data: {voucherID: voucherID},
        success: function (voucher) {

            // Assign value to form
            $('#editVoucherID').val(voucher.voucherID);
            $('#editName').val(voucher.name);
            $('#editPercent').val(voucher.percent);
            $('#editRequirement').val(voucher.requirement);
            $('#editDescription').val(voucher.description);
            $('#editStatus').val(voucher.status ? "true" : "false");
            console.log('Voucher Status:', voucher.status);
            
            // Show Date
            var dateParts = voucher.expiredDate;
            var date = new Date(dateParts);

            var year = date.getFullYear();
            var month = (date.getMonth() + 1).toString().padStart(2, '0'); 
            var day = date.getDate().toString().padStart(2, '0');
            
            var formattedDate = `${year}-${month}-${day}`;
            $('#editExpiredDate').val(formattedDate);

            // Show Modal
            $('#voucherEditModal').modal('show');
        },
        error: function (xhr, status, error) {
            alert('An error occurred while fetching voucher details: ' + error);
        }
    });
}


$(document).on('click', '#EditVoucherBTN', function () {
    var voucherID = $(this).data('id');
    console.log(voucherID);
    showEditModal(voucherID);
});

//edit voucher detail
document.getElementById('voucherEditForm').addEventListener('submit', function (event) {
    event.preventDefault(); // Ngăn không cho form gửi đi nếu validation thất bại

    var isValid = true;
    var formElements = this.elements;

    // Duyệt qua các trường input
    for (var i = 0; i < formElements.length; i++) {
        var field = formElements[i];

        if (field.type !== 'submit' && field.type !== 'hidden') {
            var value = field.value.trim(); // Loại bỏ khoảng trắng đầu dòng

            if (!value) {
                isValid = false;
                alert('Please fill in the ' + field.name + ' field.');
                break;
            }

            // Kiểm tra modalPercent có giá trị hợp lệ hay không
            if (field.name === 'percent') {
                var percentValue = parseFloat(value);
                if (isNaN(percentValue) || percentValue < 0 || percentValue > 100) {
                    isValid = false;
                    alert('Percent must be a number between 0 and 100.');
                    break;
                }
            }

            // Kiểm tra modalRequirement có giá trị hợp lệ hay không
            if (field.name === 'requirement') {
                var requirementValue = parseFloat(value);
                if (isNaN(requirementValue) || requirementValue < 0) {
                    isValid = false;
                    alert('Voucher requirement must be a number greater than or equal to 0.');
                    break;
                }
            }
        }
    }

    if (isValid) {
        // Thu thập dữ liệu từ form
        var formData = $(this).serialize();

        $.ajax({
            url: 'EditVoucher',
            type: 'POST',
            data: formData,
            success: function (response) {
                // Handle success
                alert('Voucher update successfully!');
                $('#voucherEditModal').modal('hide');
                console.log("Form Data: ", formData);
                loadResult('MKTVoucherList');

            },
            error: function (xhr, status, error) {
                // Handle error
                console.log(error);
                alert('An error occurred: ' + error);
            }
        });
    }
});

//Delete voucher
$(document).on('click', '.deleteBtn', function () {
    var voucherId = $(this).data('id');

    if (confirm('Are you sure you want to delete this voucher?')) {
        $.ajax({
            url: 'DeleteVoucher',
            type: 'POST',
            data: {voucherID: voucherId},
            success: function (response) {
                // Xử lý thành công
                alert('Voucher deleted successfully!');
                loadResult('MKTVoucherList');
            },
            error: function (xhr, status, error) {
                console.log("Error Status: ", status);
                console.log("Error: ", error);
                alert('An error occurred: ' + error);
            }
        });
    }
});


//sort data
$(document).ready(function () {
    $('.sort-btn').on('click', function () {
        var sortField = $(this).data('sort');
        var sortOrder = $(this).data('order');
        var newOrder = sortOrder === 'asc' ? 'desc' : 'asc';
        $(this).data('order', newOrder);

        sortTable(sortField, newOrder);
    });

    function getColumnIndex(field) {
        switch (field) {
            case 'voucherID':
                return 0;
            case 'name':
                return 1;
            case 'percent':
                return 2;
            case 'requirement':
                return 3;
            case 'description':
                return 4;
            case 'status':
                return 5;
            case 'createdDate':
                return 6;
            case 'usedDate':
                return 7;
            case 'expiredDate':
                return 8;
            default:
                return 0;
        }
    }

    function sortTable(field, order) {
        var rows = $('#voucherList tr').get();
        rows.sort(function (a, b) {
            var A, B;

            if (field === 'status') {
                A = $(a).find('input.statusSwitch').is(':checked') ? 1 : 0;
                B = $(b).find('input.statusSwitch').is(':checked') ? 1 : 0;
            } else {
                A = $(a).children('td').eq(getColumnIndex(field)).text().toUpperCase();
                B = $(b).children('td').eq(getColumnIndex(field)).text().toUpperCase();
            }

            if (field === 'voucherID' || field === 'percent') {
                A = parseFloat(A);
                B = parseFloat(B);
            }

            if (field.includes('Date')) {
                A = new Date(A);
                B = new Date(B);
            }

            if (order === 'asc') {
                return (A < B) ? -1 : (A > B) ? 1 : 0;
            } else {
                return (A > B) ? -1 : (A < B) ? 1 : 0;
            }
        });

        $.each(rows, function (index, row) {
            $('#voucherList').append(row);
        });
    }
    function filterResults() {
        var searchValue = $('#filterInput').val().toLowerCase();
        var statusValue = $('#statusFilter').val();
        var visibleRows = 0;

        $('#voucherList tr').filter(function () {
            var textMatch = $(this).text().toLowerCase().indexOf(searchValue) > -1;
            var statusMatch = (statusValue === 'all') ||
                    (statusValue === 'shown' && $(this).find('.statusSwitch').is(':checked')) ||
                    (statusValue === 'hidden' && !$(this).find('.statusSwitch').is(':checked'));
            var shouldDisplay = textMatch && statusMatch;
            $(this).toggle(shouldDisplay);

            if (shouldDisplay)
                visibleRows++;
        });

        $('#resultCount').text('Number of results: ' + visibleRows);
    }


    // Initial count
    filterResults();

    // Filter functionality
    $('#filterInput').on('keyup', filterResults);
    $('#statusFilter').on('change', filterResults);

    // Status switch button click
    $('.statusSwitch').change(function () {
        var voucherID = $(this).data('id');
        var status = $(this).is(':checked') ? 'true' : 'false'; // Send status as "true" or "false"
        $.ajax({
            url: 'UpdateVoucherStatus',
            method: 'POST',
            data: {voucherID: voucherID, status: status},
            success: function (response) {
                filterResults(); // Re-filter results after status change
                console.log(status);
            },
            error: function () {
                alert('Error updating status');
            }
        });
    });
});

function loadResult(url) {
    console.log('Loading orders via AJAX:', url);
    $.ajax({
        url: url,
        method: 'GET',
        dataType: 'html',
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        },
        success: function (response) {
            var newRows = $(response).find('#voucherList tr');
            $('#voucherList').html(newRows);

            // Apply filtering logic
            var searchValue = $('#filterInput').val().toLowerCase();
            var statusValue = $('#statusFilter').val();
            var visibleRows = 0;

            $('#voucherList tr').filter(function () {
                var textMatch = $(this).text().toLowerCase().indexOf(searchValue) > -1;
                var statusMatch = (statusValue === 'all') ||
                        (statusValue === 'shown' && $(this).find('.statusSwitch').is(':checked')) ||
                        (statusValue === 'hidden' && !$(this).find('.statusSwitch').is(':checked'));
                var shouldDisplay = textMatch && statusMatch;
                $(this).toggle(shouldDisplay);

                if (shouldDisplay) {
                    visibleRows++;
                }
            });

            $('#resultCount').text('Number of results: ' + visibleRows);
            console.log('Result loaded and filtered successfully. Number of results:', visibleRows);
        },
        error: function (xhr, status, error) {
            console.error('Error loading orders: ', status, error);
        }
    });
}