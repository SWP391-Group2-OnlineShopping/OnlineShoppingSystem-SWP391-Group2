<%-- 
    Document   : shop
    Created on : May 10, 2024, 3:29:04 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <title>Furni Free Bootstrap 5 Template for Furniture and Interior Design Websites by Untree.co </title>
    </head>

    <body>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>

        <%@ include file="COMP\hero.jsp" %>



       <div class="container1">
        <div class="row">
            <!-- Filter Panel -->
            <div class="col-md-3">
                <div class="filter-panel">
                    <h3>Shop > All Products</h3>
                    <div class="categories">
                        <h4>Product Categories</h4>
                        <label><input type="checkbox" name="men"> Men</label>
                        <label><input type="checkbox" name="women"> Women</label>
                        <label><input type="checkbox" name="jewelry"> Jewelry</label>
                        <label><input type="checkbox" name="electronics"> Electronics</label>
                    </div>
                    <div class="price-filter">
                        <h4>Filter by Price</h4>
                        <input type="range" min="0" max="1000" value="500" class="slider" id="priceRange">
                        <p>Price: $<span id="priceValue">500</span></p>
                    </div>
                </div>
            </div>

            <!-- Product List -->
            <div class="col-md-9">
                <div class="product-list">
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                   <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                    <div class="product">
                        <img src="images/sneaker.png" alt="Backpack">
                        <h3>Ryder Backpack</h3>
                        <p>$59.99</p>
                    </div>
                </div>
            </div>
        </div>
    </div>


        <!-- Include Header/Navigation -->
        <%@ include file="COMP\footer.jsp" %>	


        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script>
    const priceRange = document.getElementById('priceRange');
    const priceValue = document.getElementById('priceValue');
    priceRange.oninput = function() {
        priceValue.textContent = this.value;
    }
</script>
    </body>

</html>
