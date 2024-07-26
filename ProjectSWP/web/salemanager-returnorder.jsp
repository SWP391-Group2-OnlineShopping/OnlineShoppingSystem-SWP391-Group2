<!doctype html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.*" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <link href="assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/libs/css/style.css">
        <link rel="stylesheet" href="assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
        <link rel="stylesheet" href="assets/vendor/vector-map/jqvmap.css">
        <link rel="stylesheet" href="assets/vendor/jvectormap/jquery-jvectormap-2.0.2.css">
        <link rel="stylesheet" href="assets/vendor/fonts/flag-icon-css/flag-icon.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <title>Order List Manager</title>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Circular Std', sans-serif;
            }
            h4 {
                display: flex;
                align-items: center;
                justify-content: right;
            }
            input, select {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                outline: none;
                transition: border-color 0.3s;
            }
            input:focus, select:focus {
                border-color: #80bdff;
            }
            a {
                color: #007bff;
                text-decoration: none;
                transition: color 0.3s;
            }
            a:hover {
                color: #0056b3;
            }
            .status-badge {
                padding: 0.5em 1em;
                border-radius: 0.25em;
                font-size: 0.9em;
                color: white;
                text-align: center;
            }
            .status-badge.pending {
                background-color: #ffc107; /* yellow */
            }
            .status-badge.confirmed {
                background-color: #007bff; /* blue */
            }
            .status-badge.shipped {
                background-color: #fd7e14; /* orange */
            }
            .status-badge.delivered {
                background-color: #0056b3; /* dark blue */
            }
            .status-badge.success {
                background-color: #28a745; /* green */
            }
            .status-badge.cancelled, .status-badge.unpaid {
                background-color: #dc3545; /* red */
            }
            .status-badge.returned {
                background-color: #fffd55; /* yellow-green */
                color: black; /* Adjust text color for readability */
            }
            .table a {
                color: #007bff;
                text-decoration: none;
            }
            .table td, .table th {
                white-space: nowrap;
            }
            .filter-container {
                background-color: #fff;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            .table-responsive {
                border-radius: 5px;
                background-color: #fff;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }
            .pagination-container {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }
            .pagination-link {
                padding: 10px 15px;
                margin: 0 5px;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                color: #007bff;
                text-decoration: none;
                transition: background-color 0.3s, color 0.3s;
            }
            .pagination-link:hover {
                background-color: #007bff;
                color: white;
            }
            .pagination-link.active {
                background-color: #007bff;
                color: white;
                cursor: default;
            }
            .change-btn {
                text-decoration: underline;
                color: #6c757d;
                margin-left: 10px;
            }

            .sale-select {
                margin-top: 10px;
            }
            .btn-outline-primary {
                border: 2px solid #6c757d;
                color: #6c757d;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background-color: #6c757d;
                color: #fff;
                border-color: #6c757d;
            }
            .fullscreen-modal {
                display: none;
                position: fixed;
                z-index: 1050;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.8);
            }
            .fullscreen-modal img {
                display: block;
                margin: auto;
                margin-top: 150px;
                max-width: 100%;
                max-height: 100%;
            }
            .fullscreen-modal .close {
                position: absolute;
                top: 10px;
                right: 20px;
                color: white;
                font-size: 30px;
                cursor: pointer;
            }

        </style>
    </head>
    <body>

        <!-- include sidebar -->
        <%@ include file="COMP/sale-sidebar.jsp" %>

        <!-- ============================================================== -->
        <!-- wrapper  -->
        <!-- ============================================================== -->
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <!-- ============================================================== -->
                <!-- pageheader  -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Sale Manager Order List</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Return Order</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- pageheader  -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Order List -->
                <!-- ============================================================== -->
                <div class="container-fluid">
                    <h1 class="mb-4">Order List</h1>

                    <div class="filter-container">
                        <div class="row mb-2">
                            <div class="col-md-12">
                                <h5>Search:</h5>
                                <input type="text" class="form-control" id="searchQuery" placeholder="Search by ID or customer's name..." onkeyup="applyFiltersSearch()">
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-3 col-sm-6 mb-2">
                                <h5>Order by Sales:</h5>
                                <select id="salesSort" class="form-control" onchange="applyFilters()">
                                    <option value="0">All</option>
                                    <c:forEach items="${sales}" var="s">
                                        <option value="${s.staffID}">${s.fullName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                           
                            <div class="col-md-3 col-sm-6 mb-2">
                                <h5>From:</h5>
                                <input type="date" class="form-control" id="dateFrom" onchange="applyFilters()">
                            </div>
                            <div class="col-md-3 col-sm-6 mb-2">
                                <h5>To:</h5>
                                <input type="date" class="form-control" id="dateTo" onchange="applyFilters()">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 text-right">
                                <button class="btn btn-outline-primary btn-lg" onclick="clearFilters()">
                                    <i class="fas fa-undo-alt"></i> Clear Filter
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive mt-4">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Items</th>
                                    <th>Receiver Name</th>
                                    <th>Order Date</th>
                                    <th>Total Cost</th>
                                    <th>Status</th>
                                    <th>Staff</th>
                                    <th>Actions</th>
                                </tr>
                                
                            </thead>
                                <tbody>
                                <c:forEach var="o" items="${orders}" varStatus="status">
                                    <tr>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.orderID}</a></td>
                                        <td>
                                            <a href="salemanagerorderdetail?orderID=${o.orderID}" style="display: inline-block;">
                                                ${o.firstProduct}<br><b style="margin-top: 5px; display: inline-block;"><u>${o.numberOfItems - 1} more...</u></b>
                                            </a>
                                        </td>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.numberOfItems}</a></td>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.customerName}</a></td>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.orderDate}</a></td>
                                        <td><fmt:formatNumber value="${o.totalCost}" pattern="###,###"/> VND</td>
                                        <td>
                                            <a href="salemanagerorderdetail?orderID=${o.orderID}">
                                                <span class="status-badge
                                                      <c:choose>
                                               
                                                          <c:when test="${o.orderStatus == 'Want Return'}">pending</c:when>
                                                          <c:when test="${o.orderStatus == 'Waiting Return'}">pending</c:when>
                                                          <c:when test="${o.orderStatus == 'Denied Return'}">cancelled</c:when>
                                                      </c:choose>
                                                      ">
                                                    ${o.orderStatus}
                                                </span>
                                            </a>
                                        </td>
                                        <td>
                                            <a href="">${o.staff}</a>
                                        </td>
                                        <td>
                                          

                                            <c:if test="${o.orderStatus == 'Want Return'}">
                                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#returnModal" onclick="viewReason(${o.orderID})">
                                                    View Reason
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                    </div>

                
                </div>

                <!-- Modal -->
                <div class="modal fade" id="returnModal" tabindex="-1" aria-labelledby="returnModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="returnModalLabel">Return Request Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p><strong>Order ID:</strong> <span id="orderID"></span></p>
                                <p><strong>Reason:</strong> <span id="reason"></span></p>
                                <p><strong>Phone Number:</strong> <span id="phoneNumber"></span></p>
                                <p><strong>Bank Account:</strong> <span id="bankAccount"></span></p>
                                <p><strong>Date:</strong> <span id="date"></span></p>

                                <p><strong>Evidence Image or Video:</strong></p>
                                <div id="images">
                                    <video controls width="240" height="180" class="video-preview" style="margin-top: 10px; margin-bottom:-70px;  display: none;">
                                        <source src="" type="video/mp4">Trình duyệt của bạn không hỗ trợ thẻ video.
                                    </video>

                                    <img src="" alt="Hình ảnh bằng chứng" class="img-thumbnail image-preview" style="max-width: 150px; max-height: 150px; margin: 5px; display: none;" onclick="showFullscreen(this)">

                                </div>
                                <p id="no-media" style="display: none;">Không có hình ảnh hoặc video nào.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal toàn màn hình -->
                <div id="fullscreenModal" class="fullscreen-modal" onclick="closeFullscreen()">
                    <span class="close">&times;</span>
                    <img id="fullscreenImage" src="" alt="Hình ảnh toàn màn hình">
                </div>




                <!-- ============================================================== -->
                <!-- End Order List -->
                <!-- ============================================================== -->
            </div>
            <!-- include footer -->
            <%@ include file="COMP/manager-footer.jsp" %>
        </div>
        <!-- ============================================================== -->
        <!-- end main wrapper  -->
        <!-- ============================================================== -->
        <!-- Optional JavaScript -->
        <!-- jquery 3.3.1 js-->
        <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
        <!-- bootstrap bundle js-->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
        <!-- slimscroll js-->
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <!-- main js-->
        <script src="assets/libs/js/main-js.js"></script>
        <!-- Bootstrap JS từ CDN -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        var today = new Date();
                        var sevenDaysAgo = new Date();
                        sevenDaysAgo.setDate(today.getDate() - 7);

                        var formatDate = function (date) {
                            var day = ("0" + date.getDate()).slice(-2);
                            var month = ("0" + (date.getMonth() + 1)).slice(-2);
                            return date.getFullYear() + "-" + month + "-" + day;
                        };

                        document.getElementById('dateFrom').value = formatDate(sevenDaysAgo);
                        document.getElementById('dateTo').value = formatDate(today);
                    });

                    function showFullscreen(imgElement) {
                        var modal = document.getElementById("fullscreenModal");
                        var fullscreenImage = document.getElementById("fullscreenImage");
                        fullscreenImage.src = imgElement.src;
                        modal.style.display = "block";
                    }

                    function closeFullscreen() {
                        var modal = document.getElementById("fullscreenModal");
                        modal.style.display = "none";
                    }

                 

                    function viewReason(orderId) {
                        console.log("Order ID: ", orderId); // Debug log

                        $.ajax({
                            url: 'viewreasonreturn',
                            method: 'GET',
                            data: {order_id: orderId},
                            success: function (response) {
                                console.log("Phản hồi: ", response); // Debug log

                                const data = response;
                                console.log("Dữ liệu phân tích: ", data); // Debug log

                                $('#requestID').text(data.requestID || ''); // Kiểm tra dữ liệu null hoặc undefined
                                $('#orderID').text(data.orderID || '');
                                $('#customerID').text(data.customerID || '');
                                $('#reason').text(data.reason || '');
                                $('#phoneNumber').text(data.phoneNumber || '');
                                $('#bankAccount').text(data.bankAccount || '');
                                $('#date').text(data.date || '');

                                const imagesDiv = $('#images');
                                const videoPreview = imagesDiv.find('.video-preview');
                                const videoSource = videoPreview.find('source');
                                const imagePreview = imagesDiv.find('.image-preview');
                                const noMedia = $('#no-media');

                                videoPreview.hide();
                                imagePreview.hide();
                                noMedia.hide();

                                if (data.imageLinks && data.imageLinks.length > 0) {
                                    let hasMedia = false;
                                    data.imageLinks.forEach(function (link) {
                                        console.log("Link: ", link); // Debug log để kiểm tra giá trị của link

                                        const fileExtension = link.split('.').pop().toLowerCase();
                                        if (['mp4', 'avi', 'mov', 'wmv', 'flv'].includes(fileExtension)) {
                                            videoSource.attr('src', link);
                                            videoPreview[0].load(); // Refresh the video element
                                            videoPreview.show();
                                            hasMedia = true;
                                        } else {
                                            imagePreview.attr('src', link);
                                            imagePreview.show();
                                            hasMedia = true;
                                        }
                                    });
                                    if (!hasMedia) {
                                        noMedia.show();
                                    }
                                } else {
                                    noMedia.show();
                                }

                                $('#returnModal').modal('show');
                            },
                            error: function (xhr, status, error) {
                                console.error('Lỗi khi lấy lý do trả hàng: ', status, error);
                                console.error('Phản hồi: ', xhr.responseText);
                            }
                        });
                    }


                    function loadOrders(url) {
                        $.ajax({
                            url: url,
                            method: 'GET',
                            dataType: 'html',
                            headers: {
                                'X-Requested-With': 'XMLHttpRequest'
                            },
                            success: function (response) {
                                var newTableContent = $(response).find('.table-responsive').html();
                                $('.table-responsive').html(newTableContent);
                            },
                            error: function (xhr, status, error) {
                                console.error('Lỗi khi tải đơn hàng: ', status, error);
                            }
                        });
                    }

                    function clearFilters() {
                        document.getElementById('salesSort').value = '0';

                        var today = new Date();
                        var sevenDaysAgo = new Date();
                        sevenDaysAgo.setDate(today.getDate() - 7);

                        var formatDate = function (date) {
                            var day = ("0" + date.getDate()).slice(-2);
                            var month = ("0" + (date.getMonth() + 1)).slice(-2);
                            return date.getFullYear() + "-" + month + "-" + day;
                        };

                        document.getElementById('dateFrom').value = formatDate(sevenDaysAgo);
                        document.getElementById('dateTo').value = formatDate(today);

                        applyFilters();
                    }

                    function applyFilters() {
                        var salesSort = document.getElementById('salesSort').value;
                        var dateFrom = document.getElementById('dateFrom').value;
                        var dateTo = document.getElementById('dateTo').value;

                        var searchParams = new URLSearchParams(window.location.search);
                        searchParams.set('salesSort', salesSort);
                        searchParams.set('dateFrom', dateFrom);
                        searchParams.set('dateTo', dateTo);

                        var url = 'salemanagerreturnorder?' + searchParams.toString();
                        loadOrders(url);
                    }

                    function applyFiltersSearch() {
                        var salesSort = document.getElementById('salesSort').value;
                        var dateFrom = document.getElementById('dateFrom').value;
                        var dateTo = document.getElementById('dateTo').value;
                        var searchQuery = document.getElementById('searchQuery').value;

                        var searchParams = new URLSearchParams(window.location.search);
                        searchParams.set('salesSort', salesSort);
                        searchParams.set('dateFrom', dateFrom);
                        searchParams.set('dateTo', dateTo);
                        searchParams.set('searchQuery', searchQuery);

                        var url = 'salemanagerreturnorder?' + searchParams.toString();
                        loadOrders(url);
                    }
        </script>
    </body>
</html>
