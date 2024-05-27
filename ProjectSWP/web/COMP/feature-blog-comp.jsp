                       <div class="container">
        <div class="">
            <div class="col-md-12">
                <h2 class="section-title">Recent Blogs</h2>
            </div>
            <div class="col-md-12">
                <a href="blog" class="">View All Posts</a>
            </div>
        </div>
        <!-- Start Blog Testimonial Slider -->
        <div class="testimonial-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-12 ">
                        <div class="testimonial-slider-wrap text-center">
                            <%
                               BlogDAO postDAO = new BlogDAO();
                               List<Posts> blogPosts = postDAO.getAllPosts();  // Use the correct method to fetch the posts
                               request.setAttribute("blogPosts", blogPosts);
                               StaffDAO staffDAO = new StaffDAO();
                            %>

                            <div class="testimonial-slider">
                                <c:forEach var="p" items="${blogPosts}" varStatus="status" begin="0" end="5">
                                    <c:if test="${status.index % 3 == 0}">
                                        <div class="testimonial-item">
                                            <div class="row">
                                            </c:if>
                                            <div class="col-12 col-sm-6 col-md-4 mb-4">
                                                <div class="card h-100">
                                                    <a href="blogdetail?id=${p.postID}" class="post-thumbnail"><img src=${p.thumbnailLink} alt="Image" class="card-img-top"></a>
                                                    <div class="card-body">
                                                        <h3><a href="blogdetail?id=${p.postID}">${p.title}</a></h3>
                                                        <div class="card-text">
                                                            <span class="d-block text-muted">by ${p.staff}</span> 
                                                            <span class="text-muted">on ${p.updatedDate}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${status.index % 3 == 2 || status.index == blogPosts.size() - 1}">
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Blog Testimonial Slider -->