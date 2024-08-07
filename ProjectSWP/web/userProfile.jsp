<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">
        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/userProfileStyle.css"/>
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <title>User Profile</title>
        <script type="text/javascript">
            function checkUpdate(event) {
                event.preventDefault(); // Prevent form submission to handle validation

                // Get form elements
                var fullName = document.getElementById("fullname").value;
                var address = document.getElementById("address").value;
                var phone = document.getElementById("phone").value;
                var email = document.getElementById("email").value;

                // Error messages
                var errorMessages = [];

                // Simple validation checks
                if (fullName.trim() === "") {
                    errorMessages.push("Full Name is required.");
                }

                if (address.trim() === "") {
                    errorMessages.push("Address is required.");
                }

                if (phone.trim() === "") {
                    errorMessages.push("Phone number is required.");
                } else if (isNaN(phone) || phone.length < 7 || phone.length > 11) {
                    errorMessages.push("Phone number must be a natural number with 7 to 11 digits.");
                }

                if (email.trim() === "") {
                    errorMessages.push("Email is required.");
                } // Email format is not validated here since it's read-only

                // If there are errors, display them
                if (errorMessages.length > 0) {
                    alert(errorMessages.join("\n"));
                } else {
                    alert("Update Successful");
                    document.getElementById("myForm").submit(); // Proceed with form submission
                }
            }
        </script>
        <style>
            .dropdown-menu {
                color: black !important;
                z-index: 1050; 
            }
        </style>
    </head>
    <body>
        <!-- Include header.jsp -->
        <%@include file="COMP/header.jsp" %>
        <c:if test="${sessionScope.acc != null}">
            <div class="user-profile">
                <div class="container">
                    <div class="row justify-content-between user-profile-container">
                        <div class="col-lg-3 user-profile-nav">
                            <h4>Customer Information</h4>
                            <div class="menu-nav">
                                <a href="changepassword" class="menu-nav-item user-info"><img src="./images/user-solid.svg" alt="" class="nav-item-icon" />Change Password</a>
                                <a href="myorder" class="menu-nav-item buy-history"><img src="./images/bag-shopping-solid.svg" alt="" class="nav-item-icon" />Order History</a>
                                <a href="wishlist?customerID=${sessionScope.acc.customer_id}" class="menu-nav-item wishlist"><img src="./images/heart-solid.svg" alt="" class="nav-item-icon">My Wishlist</a>
                                <a href="ViewedProductServlet?customerID=${sessionScope.acc.customer_id}" class="menu-nav-item viewed-product"><img src="./images/eye-solid.svg" alt="" class="nav-item-icon"/>Viewed Product</a>
                                <a href="myfeedback?customerID=${sessionScope.acc.customer_id}&page=1&filter=''" class="menu-nav-item my-feedback"><img src="./images/comment-solid.svg" class="nav-item-icon"/>My Feedback</a>
                                <a href="logout" class="menu-nav-item logout"><img src="./images/right-to-bracket-solid.svg" alt="" class="nav-item-icon"/>Log-out</a>
                            </div>
                        </div>

                        <!-- User profile information -->
                        <div class="col-sm-8 user-profile-info">
                            <div class="user-profile-desc">
                                <h3 class="text-center">User Information</h3>
                                <form id="myForm" action="customerInfo?id=${userInfo.customer_id}" method="post" enctype="multipart/form-data" class="edit-form row" onsubmit="checkUpdate(event)">
                                    <div class="col-sm-5 user-profile-image">
                                        <img src="${userInfo.avatar}" alt="" class="user-img" />
                                        <input type="file" name="avatar" id="avatar" />
                                    </div>
                                    <div class="col-sm-7">
                                        <label for="fullname">Full Name</label>
                                        <input type="text" name="fullname" id="fullname" value="${userInfo.full_name}"/>
                                        <label for="address">Address</label>
                                        <input type="text" name="address" id="address" value="${userInfo.address}"/>

                                        <label for="phone">Phone number</label>
                                        <input type="text" name="phone" id="phone" value="${userInfo.phone_number}"/>
                                        <span></span>

                                        <label for="email">Your Email</label>
                                        <input type="email" name="email" id="email" value="${userInfo.email}" readonly />

                                        <label for="Gender">Gender</label>
                                        <div class="d-flex">
                                            <input type="radio" name="gender" id="male" value="true" ${userInfo.gender ? 'checked' : ''}>
                                            <label for="male" style="margin-right: 10px;">Male</label>

                                            <input type="radio" name="gender" id="female" value="false" ${!userInfo.gender ? 'checked' : ''}>
                                            <label for="female">Female</label>
                                        </div>
                                    </div>
                                    <input type="submit" value="Submit" />
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- Include footer.jsp -->
        <%@include file="COMP/footer.jsp"%>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
