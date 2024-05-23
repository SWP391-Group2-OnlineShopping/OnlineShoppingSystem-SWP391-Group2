                       <div class="container">
        <div class="">
            <div class="col-md-12">
                <h2 class="section-title">Recent Blogs</h2>
            </div>
            <div class="col-md-12">
                <a href="blog.jsp" class="">View All Posts</a>
            </div>
        </div>
        <!-- Start Blog Testimonial Slider -->
        <div class="testimonial-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-12 ">
                        <div class="testimonial-slider-wrap text-center">
                            <%
                               PostDAO postDAO = new PostDAO();
                               List<Posts> blogPosts = postDAO.getMostRecentBlogs();  // Use the correct method to fetch the posts
                               request.setAttribute("blogPosts", blogPosts);
                               StaffDAO staffDAO = new StaffDAO();
                            %>

                            <div class="testimonial-slider">
                                <c:forEach var="post" items="${blogPosts}" varStatus="status">
                                    <% 
                                        int staffId = ((Posts)pageContext.getAttribute("post")).getStaffID();
                                        String staffName = staffDAO.getStaffById(staffId).getUsername();
                    
                                        // Get the first image for the post
                                        Images postImage = postDAO.getPostImage(((Posts)pageContext.getAttribute("post")).getPostID());
                                        String imageUrl = (postImage != null) ? postImage.getLink() : "images/post-2.jpg";
                                    %>
                                    <!-- TODO: cap nhat link blog detail -->
                                    <c:if test="${status.index % 3 == 0}">
                                        <div class="testimonial-item">
                                            <div class="row">
                                            </c:if>
                                            <div class="col-12 col-sm-6 col-md-4 mb-4">
                                                <div class="card h-100">
                                                    <a href="#" class="post-thumbnail"><img src="<%= imageUrl %>" alt="Image" class="card-img-top"></a>
                                                    <div class="card-body">
                                                        <h3 ><a href="#" class="title-link" >${post.title}</a></h3>
                                                        <div class="card-text">
                                                            <span class="d-block text-muted">by <%= staffName %></span> 
                                                            <span class="text-muted">on ${post.updatedDate}</span>
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
