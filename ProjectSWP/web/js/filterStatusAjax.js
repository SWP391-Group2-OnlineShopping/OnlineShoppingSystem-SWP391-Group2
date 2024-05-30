$(document).ready(function () {
    function fetchCustomers() {
        var status = $('#status').val();
        var search = $('#search').val();
        $.ajax({
            url: 'mktcustomerlist',
            type: 'GET',
            data: {status: status, search: search},
            dataType: 'json',
            success: function (data) {
                var tbody = '';
                $.each(data.customers, function (index, customer) {
                    var gender = customer.gender ? 'Male' : 'Female';
                    var statusLabel = '';
                    switch (parseInt(customer.status)) {
                        case 1:
                            statusLabel = '<span class="status-label status-1">Active</span>';
                            break;
                        case 2:
                            statusLabel = '<span class="status-label status-2">Ban</span>';
                            break;
                        case 3:
                            statusLabel = '<span class="status-label status-3">Closed</span>';
                            break;
                        case 4:
                            statusLabel = '<span class="status-label status-4">Suspended</span>';
                            break;
                        case 5:
                            statusLabel = '<span class="status-label status-5">Locked</span>';
                            break;
                        default:
                            statusLabel = '<span class="status-label status-0">Unknown</span>';
                    }

                    tbody += '<tr>' +
                            '<td>' + customer.customer_id + '</td>' +
                            '<td><img src="' + customer.avatar + '" style="height:140px; width:100px "></td>' +
                            '<td>' + customer.full_name + '</td>' +
                            '<td>' + gender + '</td>' +
                            '<td>' + customer.email + '</td>' +
                            '<td>' + customer.address + '</td>' +
                            '<td>' + customer.phone_number + '</td>' +
                            '<td>' + statusLabel + '</td>' +
                            '</tr>';
                });

                $('tbody').html(tbody);
                // Update pagination
                var pagination = '';
                for (var i = 1; i <= data.noOfPages; i++) {
                    pagination += '<li class="page-item ' + (data.currentPage == i ? 'active' : '') + '"><a href="#" class="page-link" data-page="' + i + '">' + i + '</a></li>';
                }
                $('.pagination').html(pagination);
            }
        });
    }

    $('#status').change(function () {
        fetchCustomers();
    });

    $('#search').on('input', function () {
        fetchCustomers();
    });

    $(document).on('click', '.page-link', function (e) {
        e.preventDefault();
        var page = $(this).data('page');
        var status = $('#status').val();
        var search = $('#search').val();
        $.ajax({
            url: 'mktcustomerlist',
            type: 'GET',
            data: {page: page, status: status, search: search},
            dataType: 'json',
            success: function (data) {
                var tbody = '';
                $.each(data.customers, function (index, customer) {
                    var gender = customer.gender ? 'Male' : 'Female';
                    var statusLabel = '';
                    switch (parseInt(customer.status)) {
                        case 1:
                            statusLabel = '<span class="status-label status-1">Active</span>';
                            break;
                        case 2:
                            statusLabel = '<span class="status-label status-2">Ban</span>';
                            break;
                        case 3:
                            statusLabel = '<span class="status-label status-3">Closed</span>';
                            break;
                        case 4:
                            statusLabel = '<span class="status-label status-4">Suspended</span>';
                            break;
                        case 5:
                            statusLabel = '<span class="status-label status-5">Locked</span>';
                            break;
                        default:
                            statusLabel = '<span class="status-label status-0">Unknown</span>';
                    }

                    tbody += '<tr>' +
                            '<td>' + customer.customer_id + '</td>' +
                            '<td><img src="' + customer.avatar + '" style="height:140px; width:100px "></td>' +
                            '<td>' + customer.full_name + '</td>' +
                            '<td>' + gender + '</td>' +
                            '<td>' + customer.email + '</td>' +
                            '<td>' + customer.address + '</td>' +
                            '<td>' + customer.phone_number + '</td>' +
                            '<td>' + statusLabel + '</td>' +
                            '</tr>';
                });

                $('tbody').html(tbody);
                // Update pagination
                var pagination = '';
                for (var i = 1; i <= data.noOfPages; i++) {
                    pagination += '<li class="page-item ' + (data.currentPage == i ? 'active' : '') + '"><a href="#" class="page-link" data-page="' + i + '">' + i + '</a></li>';
                }
                $('.pagination').html(pagination);
            }
        });
    });
});
