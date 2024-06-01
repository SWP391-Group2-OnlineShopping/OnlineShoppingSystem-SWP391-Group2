// filter.js
$(document).ready(function () {
    function fetchCustomers(status, search, page, sortField, sortOrder, gender) {
        $.ajax({
            url: 'mktcustomerlist',
            type: 'GET',
            data: {status: status, search: search, page: page, sortField: sortField, sortOrder: sortOrder, gender: gender},
            dataType: 'json',
            success: function (data) {
                var tbody = '';
                $.each(data.customers, function (index, customer) {
                    var genderText = customer.gender ? 'Male' : 'Female';
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
                            '<td><a href="mktcustomerdetails?id=' + customer.customer_id + '">' + customer.customer_id + '</a></td>' +
                            '<td><a href="mktcustomerdetails?id=' + customer.customer_id + '"><img src="' + customer.avatar + '" style="height:140px; width:100px "></a></td>' +
                            '<td><a href="mktcustomerdetails?id=' + customer.customer_id + '">' + customer.full_name + '</a></td>' +
                            '<td><a href="mktcustomerdetails?id=' + customer.customer_id + '">' + genderText + '</a></td>' +
                            '<td><a href="mktcustomerdetails?id=' + customer.customer_id + '">' + customer.email + '</a></td>' +
                            '<td><a href="mktcustomerdetails?id=' + customer.customer_id + '">' + customer.address + '</a></td>' +
                            '<td><a href="mktcustomerdetails?id=' + customer.customer_id + '">' + customer.phone_number + '</a></td>' +
                            '<td><a href="mktcustomerdetails?id=' + customer.customer_id + '">' + statusLabel + '</a></td>' +
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

    $(document).on('click', '.status-filter', function (e) {
        e.preventDefault();
        var status = $(this).data('status');
        var search = $('#search').val();
        var gender = $('.gender-filter.active').data('gender');
        fetchCustomers(status, search, 1, null, null, gender);
    });

    $(document).on('click', '.sort-filter', function (e) {
        e.preventDefault();
        var sortField = $(this).data('sort');
        var sortOrder = $(this).data('order');
        var status = $('.dropdown-content .active').data('status');
        var search = $('#search').val();
        var gender = $('.gender-filter.active').data('gender');
        fetchCustomers(status, search, 1, sortField, sortOrder, gender);
    });

    $('#search').on('input', function () {
        var status = $('.dropdown-content .active').data('status');
        var search = $('#search').val();
        var gender = $('.gender-filter.active').data('gender');
        fetchCustomers(status, search, 1, null, null, gender);
    });

    $(document).on('click', '.page-link', function (e) {
        e.preventDefault();
        var page = $(this).data('page');
        var status = $('.dropdown-content .active').data('status');
        var search = $('#search').val();
        var gender = $('.gender-filter.active').data('gender');
        var sortField = $('.sort-filter.active').data('sort');
        var sortOrder = $('.sort-filter.active').data('order');
        fetchCustomers(status, search, page, sortField, sortOrder, gender);
    });

    $(document).on('click', '.gender-filter', function (e) {
        e.preventDefault();
        $('.gender-filter').removeClass('active');
        $(this).addClass('active');
        var gender = $(this).data('gender');
        var status = $('.dropdown-content .active').data('status');
        var search = $('#search').val();
        var sortField = $('.sort-filter.active').data('sort');
        var sortOrder = $('.sort-filter.active').data('order');
        fetchCustomers(status, search, 1, sortField, sortOrder, gender);
    });

    // Xử lý nút Clear Filter
    $('#clearFilter').on('click', function () {
        $('#search').val('');
        $('.gender-filter').removeClass('active');
        $('.sort-filter').removeClass('active');
        fetchCustomers('', '', 1, 'CustomerID', 'ASC', '');
    });
});
