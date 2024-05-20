<%-- 
    Document   : productdetails
    Created on : 20 May 2024, 11:58:37
    Author     : dumspicy
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta name="author" content="Untree.co" />
        <link rel="shortcut icon" href="favicon.png" />

        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
            rel="stylesheet"
            />
        <link href="css/product-details.css" rel="stylesheet" />
        <link href="css/style.css" rel="stylesheet" />
        <title>JSP Page</title>
    </head>
    <body>
        <!--========== Include header ========-->
        <%@include file="./COMP/header.jsp" %>

        <!-- ======= Start Search Box ======== -->
        <div class="search-box_area">
            <div class="container">
                <div class="row"></div>
            </div>
        </div>
        <!-- ======= End Search Box ======== -->

        <!-- ======= Start product detail image ======= -->
        <div class="product-details-top pt-5">
            <div class="container">
                <div class="row product-details_inner py-3">
                    <div class="col-lg-6 product-details-image">
                        <img
                            src="./images/sneaker.png"
                            alt=""
                            class="product-image"
                            id="main_image"
                            />
                        <div class="row sub-image-list mt-3">
                            <c:forEach begin="1" end="6">
                                <div class="col-lg-2 sub-image-item">
                                    <img
                                        src="./images/couch.png"
                                        alt="alt"
                                        id="sub-image"
                                        onclick="changeImage('sub-image')"
                                        style="width: 100%"
                                        />
                                </div>
                            </c:forEach>
                        </div>
                        -->
                    </div>

                    <div class="col-lg-5 offset-lg-1">
                        <div class="product-details_text">
                            <h3 class="product-name mb-3">Nike Air Jordan</h3>
                            <h3
                                class="product-salePrice fw-light text-decoration-line-through fs-4 d-inline"
                                >
                                100$
                            </h3>
                            <h2 class="product-listPrice d-inline ms-5 mb-3">50$</h2>
                            <p class="product-brief">
                                Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ut
                                omnis impedit earum ea vero adipisci unde, qui corrupti
                                temporibus fuga minus quasi. Veniam est magni illo dicta
                                accusantium praesentium alias.
                            </p>
                            <form class="add-to-cart-form" action="OrderStuff" method="get">
                                <label for="size" class="me-3">Size:</label>
                                <input type="radio" name="size" id="size" /> 40
                                <input type="radio" name="size" id="size" /> 41
                                <input type="radio" name="size" id="size" /> 42
                                <input type="radio" name="size" id="size" /> 43 <br /><br />

                                <label for="color" class="me-3">Color: </label>
                                <input type="radio" name="color" id="color" />
                                <input type="radio" name="color" id="color" />
                                <input type="radio" name="color" id="color" />
                                <input type="radio" name="color" id="color" />

                                <br /><br />
                                <label for="quantity" class="me-3">Quantity: </label>
                                <input
                                    type="text"
                                    id="quantity"
                                    name="quantity"
                                    value="1"
                                    readonly
                                    class="amount-input"
                                    />
                                <br /><br />
                                <button
                                    type="button"
                                    class="quantity-btn minus"
                                    onclick="decreaseQuantity()"
                                    >
                                    <img src="./minus-solid.svg" alt="" class="idBtn" />
                                </button>
                                <button
                                    type="button"
                                    class="quantity-btn plus"
                                    onclick="increaseQuantity()"
                                    >
                                    <img src="./plus-solid.svg" alt="" class="idBtn" />
                                </button>
                                <br /><br />
                                <button type="submit" class="add-to-cart-btn">
                                    Thêm vào giỏ hàng
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ====== End Product detail Image ====== -->

        <!-- ====== Start Recommended Product ======== -->
        <div class="rec-product-area pt-3">
            <div class="container">
                <div class="row rec-product-inner p-3">
                    <h3 class="rec-product-title p-3">Lastest Product</h3>
                    <c:forEach begin="1" end="4">
                        <!-- Item 1 -->
                        <div class="col-lg-3 item items-1">
                            <a href="" class="items-link"
                               ><img
                                    src="./images/sneaker.png"
                                    alt=""
                                    class="product-image mt-3"
                                    />
                                <h3 class="product-title">Nike Jordan</h3>
                                <p class="price">100$</p></a
                            >
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- ====== End Recommended Product =========== -->

        <!-- ====== Start Product description ========= -->
        <div class="product-desc-area pt-3">
            <div class="container">
                <div class="row product-desc-inner">
                    <div class="col-lg-12 product-desc">
                        <h2 class="product-desc-title m-3 p-3">Product Description</h2>
                        <p class="desc p-3">
                            &bull; Lorem ipsum dolor sit amet consectetur adipisicing elit.
                            Impedit quidem minima consectetur fuga exercitationem error dolore
                            minus expedita laudantium cumque sit in sapiente, provident
                            veritatis optio quos? Perferendis, obcaecati. Eos. Minus,
                            consectetur enim voluptatum officia amet exercitationem
                            architecto. Error repudiandae, perspiciatis amet aliquam placeat
                            consequatur, debitis corrupti quae officiis ea ducimus commodi
                            possimus in obcaecati modi, minus aperiam. Delectus, esse.
                            Aspernatur assumenda reprehenderit sint velit deserunt ducimus
                            facere, accusantium voluptatibus ipsum rem excepturi unde vero
                            sunt ratione eligendi perferendis perspiciatis, molestias dolorem
                            in neque. Animi maiores quis voluptatum quod nesciunt. Dolore ea
                            quis consequatur tempora? Quidem iure nisi voluptatibus a
                            quibusdam? Suscipit hic corrupti sint, voluptate nobis saepe,
                            soluta sunt repudiandae debitis reiciendis aliquam, atque tempora.
                            Eum voluptates possimus ipsam! &nbsp;&nbsp;&bull; Lorem ipsum
                            dolor sit amet consectetur adipisicing elit. Eaque vero odio hic
                            possimus similique ea pariatur nobis, architecto ad reprehenderit
                            est animi commodi placeat consequuntur facere nostrum error
                            excepturi quisquam. Adipisci maiores earum eveniet sed illo quidem
                            neque incidunt saepe vero non eum, distinctio tempora iusto
                            aliquid laborum? Laboriosam, libero earum atque perferendis
                            voluptates unde dicta obcaecati blanditiis ex eligendi. Odio
                            dolores voluptas ut, consequuntur ipsum cupiditate dignissimos,
                            illum facilis veniam ipsam ipsa dicta? Sint in unde quos, autem
                            neque pariatur assumenda rem ipsam architecto ad laborum
                            reprehenderit voluptatem minima. Officia eaque qui amet sunt
                            exercitationem suscipit tempora molestiae animi! Similique fugiat
                            tempora amet ipsam autem aperiam totam velit? Ipsam sunt enim
                            vitae ullam vel odio soluta ducimus animi harum.
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <!-- ======= End Product description ========= -->

        <!--========== Include footer ========-->
        <%@include file="./COMP/footer.jsp" %>
        <script>
            function increaseQuantity() {
                var quantityField = document.getElementById("quantity");
                var quantity = parseInt(quantityField.value);
                quantityField.value = quantity + 1;
            }

            function decreaseQuantity() {
                var quantityField = document.getElementById("quantity");
                var quantity = parseInt(quantityField.value);
                if (quantity > 1) {
                    quantityField.value = quantity - 1;
                }
            }

            function changeImage(id) {
                let imagePath = document.getElementById(id).getAttribute("src");
                document.getElementById("main_image").setAttribute("src", imagePath);
            }
        </script>
    </body>
</html>
