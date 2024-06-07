<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Create new order</title>
        <!-- Bootstrap core CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .header {
                margin-bottom: 30px;
                padding: 20px 0;
                border-bottom: 1px solid #e5e5e5;
                background-color: #CE4B40;
                color: #ffffff;
                text-align: center;
            }

            .form-group label {
                font-weight: bold;
            }
            .form-check-label {
                margin-left: 10px;
            }
            h3, h4, h5 {
                margin-top: 20px;
                margin-bottom: 20px;
                color: #343a40;
            }
            .btn-primary {
                background-color: #CE4B40;
                border-color: #CE4B40;
            }
            .btn-primary:hover {
                background-color: #a03a30;
                border-color: #a03a30;
            }
            footer {
                margin-top: 40px;
                padding-top: 10px;
                border-top: 1px solid #e5e5e5;
                text-align: center;
                color: #6c757d;
            }
            .card {
                border-color: #CE4B40;
            }
            .card-title {
                color: #CE4B40;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div>
                <img src="images/Black-Sneaker.png" class="img-fluid mt-3" style = "max-width: 28rem; left: 2rem; top: 0rem ; position: absolute" alt="Decorative Image">
                <img src="images/Running-Shoes.png" class="img-fluid mt-3" style = "max-width: 25rem; right: 2rem; bottom: 2rem ; position: absolute" alt="Decorative Image">
            </div>
            <div class="header clearfix">
                <h3 style="color: white; font-weight: bold ">DiLuri </h3>
                <h5 style="color: white">Choose Payment</h5>
            </div>
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title">Create new order</h3>
                    <form action="vnpayajax" id="frmCreateOrder" method="post">
                        <div class="form-group">
                            <label for="amount">Amount of money</label>
                            <input class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" max="100000000" min="1" name="amount" type="number" value="${totalPrice}" readonly/>
                        </div>
                        <h4>Select a payment method</h4>
                        <div class="form-group">
                            <h5>Method 1: Navigate to VNPAY Portal to select payment method</h5>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="bankCode1" name="bankCode" value="" checked>
                                <label class="form-check-label" for="bankCode1">Cổng thanh toán VNPAYQR</label>
                            </div>
                            <h5>Method 2: Separate the method at the connection unit's site</h5>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="bankCode2" name="bankCode" value="VNPAYQR">
                                <label class="form-check-label" for="bankCode2">Pay with applications that support VNPAY QR</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="bankCode3" name="bankCode" value="VNBANK">
                                <label class="form-check-label" for="bankCode3">Payment via ATM card/Domestic account</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="bankCode4" name="bankCode" value="INTCARD">
                                <label class="form-check-label" for="bankCode4">Payment via international card</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <h5>Select payment interface language:</h5>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="language1" name="language" value="vn" checked>
                                <label class="form-check-label" for="language1">Vietnamese</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="language2" name="language" value="en">
                                <label class="form-check-label" for="language2">English</label>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Pay Now</button>
                    </form>
                        <br>
                        <a href="viewcartdetail"><button class="btn btn-primary btn-block">Back to Cart</button></a>
                </div>
            </div>
            <footer class="footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript">
            $("#frmCreateOrder").submit(function () {
                var postData = $("#frmCreateOrder").serialize();
                var submitUrl = $("#frmCreateOrder").attr("action");
                $.ajax({
                    type: "POST",
                    url: submitUrl,
                    data: postData,
                    dataType: 'JSON',
                    success: function (x) {
                        if (x.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({width: 768, height: 600, url: x.data});
                            } else {
                                location.href = x.data;
                            }
                            return false;
                        } else {
                            alert(x.Message);
                        }
                    }
                });
                return false;
            });
        </script>
    </body>
</html>
