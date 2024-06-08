<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">

        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/productcss.css" rel="stylesheet"/>
        <title>Cart Checkout</title>
        <style>
            .payment-method {
                background-color: #f8f9fa; /* Light background color */
                border-radius: 10px; /* Rounded corners */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            }

            .h6 {
                color: #333; /* Darker text color for heading */
            }

            .form-check {
                margin-bottom: 1rem; /* Add spacing between radio button options */
            }

            .form-check-input {
                width: 20px; /* Adjust radio button size */
                height: 20px;
                border-radius: 50%; /* Create circular radio buttons */
            }

            .form-check-input:checked {
                background-color: blue; /* Green color for selected radio button */
                border: 1px solid blue; /* Green border for selected radio button */
            }

            .form-check-label {
                cursor: pointer; /* Indicate that the label is clickable */
                font-weight: 500; /* Slightly bolder font weight for labels */
            }
            .btn-custom {
                background-color: #007bff; /* Custom blue color */
                border: none; /* Remove border */
                color: white; /* White text */
                padding: 5px 10px; /* Adjust padding */
                font-size: 14px; /* Font size */
                border-radius: 5px; /* Rounded corners */
                transition: background-color 0.3s ease; /* Transition effect */
            }

            .btn-custom:hover {
                background-color: #0056b3; /* Darker blue on hover */
            }

        </style>
    </head>

    <body>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP/header.jsp" %>

        <div class="untree_co-section">
            <div class="container">
                <div class="row bg-light p-2 mb-5">
                    <div class="col-md-12">
                        <a href="homepage">Home</a> <span> > </span>
                        <a href="product">Shop</a> <span>  > </span>
                        <a href="cart.jsp">Shopping Cart</a> <span> > </span>
                        <a href="#">Cart Checkout</a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5 mb-5 mb-md-0">
                        <h2 class="h3 mb-3 text-black">Delivery address information</h2>
                        <div class="p-3 p-lg-5 border bg-white">
                            <div class="form-group row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#addressModal">Change Address</button>
                                    </div>
                                    <label for="fullname" class="text-black">Full Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="fullname" name="fullName" placeholder="Receiver Name" value="${customerInfo.full_name}" readonly>
                                </div>
                                <div class="col-md-12 mt-5">
                                    <label for="specific_address" class="text-black">Address <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="specific_address" name="address" placeholder="Street Address" readonly required>
                                    <p id="address-error" style="color: red; display: none;">Please provide detail address</p>
                                </div>

                                <div class="col-md-12 mt-5">
                                    <label for="c_phone" class="text-black">Phone Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="c_phone" name="phoneNumber" placeholder="Phone Number" value="${customerInfo.phone_number}" readonly>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="order_notes" class="text-black mt-5">Order Notes</label>
                                <textarea name="order_notes" id="order_notes" cols="30" rows="10" class="form-control" placeholder="Write your notes here..."></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="row mb-5">
                            <div class="col-md-12">
                                <h2 class="h3 mb-3 text-black">Your Order</h2>
                                <div class="p-3 p-lg-5 border bg-white">
                                    <table class="table site-block-order-table mb-5">
                                        <thead>
                                        <th class="productId">ID</th>
                                        <th class="productImage">Image</th>
                                        <th class="productTitle">Title</th>
                                        <th class="productPrice">Price</th>
                                        <th class="productSize">Size</th>
                                        <th class="productQuantity">Quantity</th>
                                        <th class="productTotalPrice">Total</th>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cartItem" items="${selectedCartItems}">
                                                <tr>
                                                    <td class="productCSID" hidden>
                                                        <p class="text-black m-0">${cartItem.getProductCSID()}</p>
                                                    </td>
                                                    <td class="productID">
                                                        <p class="text-black m-0">${cartItem.getProduct().getProductID()}</p>
                                                    </td>
                                                    <td class="productImage">
                                                        <img src="${cartItem.getProduct().getThumbnailLink()}" class="image-fluid w-50"/>
                                                    </td>
                                                    <td class="productTitle">
                                                        <p class="fw-bolder m-0" style="color: #CE4B40;">${cartItem.getProduct().getTitle()}</p>
                                                    </td>
                                                    <td class="productPrice">
                                                        <p class="text-black m-0"><fmt:formatNumber value="${cartItem.getProduct().getSalePrice()}" pattern="###,### "/></p>
                                                    </td>
                                                    <td class="productSize">
                                                        <p class="text-black m-0">${cartItem.size}</p>
                                                    </td>
                                                    <td class="productQuantity">
                                                        <p class="text-black m-0 text-center">${cartItem.getQuantity()}</p>
                                                    </td>
                                                    <td class="productTotalPrice">
                                                        <p class="text-black m-0"><fmt:formatNumber value="${cartItem.getQuantity() * cartItem.getProduct().getSalePrice()}" pattern="###,### "/></p>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr>
                                                <td class="text-black font-weight-bold"><strong>Order Total</strong></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="text-black font-weight-bold"><strong><fmt:formatNumber value="${totalPrice}" pattern="###,### "/>VND</strong></td>
                                            </tr>
                                        </tbody>
                                    </table>





                                    <div class="payment-method border p-3 mb-3">
                                        <h3 class="h6 mb-0">Payment Method</h3>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" id="payment-gateway" value="gateway" required>
                                            <label class="form-check-label" for="payment-gateway">Gateway Transfer</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" id="payment-banking" value="banking" required>
                                            <label class="form-check-label" for="payment-banking">Banking Online Transfer</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" id="payment-cod" value="cod" required>
                                            <label class="form-check-label" for="payment-cod">Ship COD</label>
                                        </div>
                                        <div id="cod-error-message" class="text-danger" style="display:none;">Cannot choose this payment because the amount is too large.</div>
                                    </div>


                                    <div class="form-group">
                                        <button class="btn btn-black btn-lg py-3 btn-block" onclick="window.location = 'viewcartdetail'">Change Product</button>
                                        <button class="btn btn-black btn-lg py-3 float-end btn-block" onclick="placeOrder()">Place Order</button>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="row mt-5">
                    <div class="col-md-12">
                        <%@include file="COMP/latestproductlist.jsp" %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for Address Selection -->
        <div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addressModalLabel">Select Delivery Address</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="addressSelection">
                            <c:forEach var="address" items="${customerAddress}">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="selectedAddress" id="address_${address.receiverInforID}" value="${address.receiverInforID}" data-fullname="${address.receiverFullName}" data-phone="${address.phoneNumber}" data-address="${address.address}" data-address-type="${address.addressType}">
                                    <label class="form-check-label" for="address_${address.receiverInforID}">
                                        ${address.receiverFullName}, ${address.phoneNumber}, ${address.address} <c:if test="${address.addressType}">(Default)</c:if>
                                        </label>
                                        <form action="processProduct" method="POST" style="display:inline;">
                                            <input type="hidden" name="customerID" value="${sessionScope.acc.customer_id}">
                                        <input type="hidden" name="addressID" value="${address.receiverInforID}">
                                        <input type="hidden" name="action" value="updateDefault">
                                        <button type="submit" class="btn btn-primary btn-sm mt-2">Set as Default</button>

                                    </form>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newAddressModal">Add New Address</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for Adding New Address -->
        <div class="modal fade" id="newAddressModal" tabindex="-1" aria-labelledby="newAddressModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="newAddressModalLabel">Add New Address</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="processProduct" method="POST" onsubmit="return validateNewAddressForm()">
                        <input type="hidden" name="customerID" value="${sessionScope.acc.customer_id}">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="newFullName" class="text-black">Full Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="newFullName" name="newFullName" required>
                                <div class="invalid-feedback" id="newFullNameError">Full Name is too short.</div>
                            </div>
                            <div class="form-group mt-3">
                                <label for="newPhoneNumber" class="text-black">Phone Number <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="newPhoneNumber" name="newPhoneNumber" required>
                                <div class="invalid-feedback" id="newPhoneNumberError">Phone Number must be between 7 and 11 digits.</div>
                            </div>
                            <div class="form-group mt-3">
                                <label for="newAddress" class="text-black">Details Address <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="newAddress" name="newAddress" required>
                            </div>
                            <div class="form-check mt-3">
                                <input class="form-check-input" type="checkbox" id="makeDefault" name="makeDefault">
                                <label class="form-check-label" for="makeDefault">Make it default</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#addressModal">Return</button>
                            <button type="submit" class="btn btn-primary">Done</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <!-- Add this hidden form for data submission -->
        <form id="paymentForm" method="post">
            <input type="hidden" name="fullName" value="">
            <input type="hidden" name="address" value="">
            <input type="hidden" name="phoneNumber" value="">
            <input type="hidden" name="orderNotes" value="">
            <input type="hidden" name="productData" value="">
        </form>



        <!-- Include Footer -->
        <%@ include file="COMP/footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            var defaultAddress = document.querySelector('input[name="selectedAddress"][data-address-type="true"]');
                            if (defaultAddress) {
                                defaultAddress.checked = true;
                                document.getElementById('fullname').value = defaultAddress.getAttribute('data-fullname');
                                document.getElementById('c_phone').value = defaultAddress.getAttribute('data-phone');
                                document.getElementById('specific_address').value = defaultAddress.getAttribute('data-address');
                            }
                        });

                        document.getElementById('addressSelection').addEventListener('change', function () {
                            var selectedOption = document.querySelector('input[name="selectedAddress"]:checked');
                            if (selectedOption) {
                                document.getElementById('fullname').value = selectedOption.getAttribute('data-fullname');
                                document.getElementById('c_phone').value = selectedOption.getAttribute('data-phone');
                                document.getElementById('specific_address').value = selectedOption.getAttribute('data-address');
                            }
                        });

                        function validateNewAddressForm() {
                            var isValid = true;

                            // Validate Full Name
                            var fullName = document.getElementById('newFullName').value.trim();
                            var fullNameError = document.getElementById('newFullNameError');
                            if (fullName.split(' ').length < 2) {
                                fullNameError.style.display = 'block';
                                isValid = false;
                            } else {
                                fullNameError.style.display = 'none';
                            }

                            // Validate Phone Number
                            var phoneNumber = document.getElementById('newPhoneNumber').value.trim();
                            var phoneNumberError = document.getElementById('newPhoneNumberError');
                            if (!/^\d{7,11}$/.test(phoneNumber)) {
                                phoneNumberError.style.display = 'block';
                                isValid = false;
                            } else {
                                phoneNumberError.style.display = 'none';
                            }

                            return isValid;
                        }


                        function placeOrder() {
                            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
                            if (!paymentMethod) {
                                return alert('Please select a payment method.');
                            }

                            // Gather data
                            const fullName = document.getElementById('fullname').value;
                            const address = document.getElementById('specific_address').value;
                            const phoneNumber = document.getElementById('c_phone').value;
                            const orderNotes = document.getElementById('order_notes').value;

                            // Check if address is provided
                            if (address.trim() === "") {
                                document.getElementById('address-error').style.display = 'block';
                                return;
                            } else {
                                document.getElementById('address-error').style.display = 'none';
                            }

                            console.log(fullName, address, phoneNumber, orderNotes);

                            // Gather product data and calculate total price
                            const cartItems = [];
                            let totalPrice = 0;
                            document.querySelectorAll('table.site-block-order-table tbody tr').forEach(row => {
                                const productCSIDElement = row.querySelector('.productCSID p');
                                const productIDElement = row.querySelector('.productID p');
                                const productTitleElement = row.querySelector('.productTitle p');
                                const productPriceElement = row.querySelector('.productPrice p');
                                const productSizeElement = row.querySelector('.productSize p');
                                const productQuantityElement = row.querySelector('.productQuantity p');
                                const productImageElement = row.querySelector('.productImage img');

                                if (productCSIDElement && productIDElement && productTitleElement && productPriceElement && productSizeElement && productQuantityElement && productImageElement) {
                                    const productCSID = productCSIDElement.innerText;
                                    const productID = productIDElement.innerText;
                                    const productTitle = productTitleElement.innerText;
                                    const productPrice = parseFloat(productPriceElement.innerText.replace(/,/g, '').trim());
                                    const productSize = productSizeElement.innerText;
                                    const productQuantity = parseInt(productQuantityElement.innerText);
                                    const productImage = productImageElement.src;

                                    const productTotalPrice = productPrice * productQuantity;
                                    totalPrice += productTotalPrice;

                                    cartItems.push({productCSID, productID, productTitle, productPrice, productSize, productQuantity, productImage});
                                } else {
                                    console.log("Missing product detail elements in row:", row);
                                }
                            });

                            console.log(cartItems, totalPrice);

                            if (cartItems.length === 0) {
                                return alert('No valid products found in the order.');
                            }

                            if (paymentMethod.value === 'cod' && totalPrice >= 10000000) {
                                const codErrorMessage = document.getElementById('cod-error-message');
                                codErrorMessage.style.display = 'block';
                                document.getElementById('payment-cod').disabled = true;
                                return;
                            }

                            // Set data to hidden form
                            const paymentForm = document.getElementById('paymentForm');
                            paymentForm.querySelector('input[name="fullName"]').value = fullName;
                            paymentForm.querySelector('input[name="address"]').value = address;
                            paymentForm.querySelector('input[name="phoneNumber"]').value = phoneNumber;
                            paymentForm.querySelector('input[name="orderNotes"]').value = orderNotes;
                            paymentForm.querySelector('input[name="productData"]').value = JSON.stringify(cartItems);

                            let actionUrl = '';
                            switch (paymentMethod.value) {
                                case 'gateway':
                                    actionUrl = 'vnpay'; // Replace with your gateway link
                                    break;
                                case 'banking':
                                    actionUrl = 'confirmationbankingtransfer'; // Replace with your bank online transfer link
                                    break;
                                case 'cod':
                                    actionUrl = 'confirmationshipcod'; // Replace with your COD confirmation page link
                                    break;
                                default:
                                    return alert('Invalid payment method selected.');
                            }

                            console.log({
                                fullName,
                                address,
                                phoneNumber,
                                orderNotes,
                                cartItems,
                                actionUrl
                            });

                            paymentForm.action = actionUrl;
                            paymentForm.submit();
                        }





        </script>
    </body>
</html>
