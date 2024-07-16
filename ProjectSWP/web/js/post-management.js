$('#postList').on('click', '.viewBtn', function () {
    var postID = $(this).data('id');
    console.log("View button clicked, postID:", postID);

    // AJAX request to fetch post details
    $.ajax({
        url: 'MKTPostDetail',
        method: 'GET',
        data: {postID: postID},
        success: function (post) {
            $('#modalViewPostID').text(post.postID);
            console.log('Post ID:', post.postID); // Log the post ID
            $('#modalViewTitle').text(post.title);
            $('#modalViewProduct').html('<a href="productdetails?id=' + post.product.productID + '">' + post.product.title + '</a>');
            
            console.log('Title:', post.product); // Log the title
            $('#modalViewAuthor').text(post.staff);
            console.log('Author:', post.staff); // Log the author
            $('#modalViewContent').text(post.content);
            console.log('Content:', post.content); // Log the content
            $('#modalViewStatus').text(post.status ? 'Shown' : 'Hidden');
            console.log('Status:', post.status ? 'Shown' : 'Hidden'); // Log the status
            $('#modalViewFeature').text(post.feature ? 'True' : 'False');
            $('#modalViewUpdatedDate').text(post.updatedDate);
            console.log('Updated Date:', post.updatedDate); // Log the updated date
            var link = $('#modalViewImageLinks');
            link.empty();
            link.append('<img src="' + post.thumbnailLink + '" alt="Post Image" class="img-thumbnail" style="width: 100px; margin: 5px;">');
            console.log('Thumbnail Link:', post.thumbnailLink); // Log the thumbnail link

            var categoriesContainer = $('#modalViewCategories');
            categoriesContainer.empty(); // Clear previous images
            if (post.categories) {
                post.categories.forEach(function (cate) {
                    categoriesContainer.append(cate.name);
                    console.log('Category:', cate.name); // Log each category name
                });
            }
            console.log(categoriesContainer);
            console.log(post.postID);
            // Show the modal
            $('#postDetailModal').modal('show');
        },
        error: function (xhr, status, error) {
            alert('Error fetching post details');
        }
    });
});



// AJAX request to fetch post to edit
$('#postList').on('click', '.editBtn', function () {
    var postID = $(this).data('id');
    console.log("View button clicked, postID:", postID);

    // AJAX request to fetch post details
    $.ajax({
        url: 'MKTPostDetail',
        method: 'GET',
        data: {postID: postID},
        success: function (post) {
            $('#editPostID').val(post.postID);
            $('#editTitle').val(post.title);
            $('#editAuthor').val(post.staff);
            $('#editContent').val(post.content);
            $('#editStatus').val(post.status ? 'true' : 'false');
            $('#editFeature').val(post.feature ? 'true' : 'false');
            console.log('Post Status:', post.status);
            console.log('Post Feature:', post.feature);
            $('#editThumbnailLink').val(post.thumbnailLink);
            $('#editCategories').val(post.categories.map(c => c.name).join(', '));

            // Show the modal
            $('#postEditModal').modal('show');
        },
        error: function (xhr, status, error) {
            alert('Error fetching post details');
        }
    });
});
//AJAX to handle Edit form
$('#editPostForm').on('submit', function (e) {
    e.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
        url: 'MKTEditPost',
        method: 'POST',
        data: formData,
        success: function (response) {
            alert('Post updated successfully!');
            $('#postEditModal').modal('hide');
            console.log("Form Data: ", formData);
            loadResult('mktpostlist');
        },
        error: function (xhr, status, error) {
            alert('Error updating post details');
            console.log("Form Data: ", formData);
        }
    });
});
//show the modal
document.getElementById('addPostBtn').addEventListener('click', function () {
    $('#postAddModal').modal('show');
});
//AJAX to handle Add form
$('#postAddForm').on('submit', function (event) {
    event.preventDefault(); // Prevent the default form submission

    // Get the value of the modalImageLinks input
    var imageLinks = $('#modalImageLinks').val().trim();

    // Define the allowed extensions
    var allowedExtensions = ['.png', '.jpeg', '.jpg', '.webp'];

    // Function to check if the URL ends with one of the allowed extensions
    function hasValidExtension(url) {
        return allowedExtensions.some(function (extension) {
            return url.toLowerCase().endsWith(extension);
        });
    }

    // Check if the imageLinks is not empty and has a valid extension
    if (imageLinks && !hasValidExtension(imageLinks)) {
        alert('Invalid image URL. Only .png, .jpeg, .jpg, .webp extensions are allowed.');
        return;
    }

    var formData = $(this).serialize();

    $.ajax({
        type: 'POST',
        url: 'MKTAddPost',
        data: formData,
        success: function (response) {
            // Handle success
            alert('Post added successfully!');
            $('#postAddModal').modal('hide');
            console.log("Form Data: ", formData);
            loadResult('mktpostlist');
        },
        error: function (xhr, status, error) {
            // Handle error
            alert('An error occurred: ' + error);
        }
    });
});

//Show the add category modal
document.getElementById('addCategoryBtn').addEventListener('click', function () {
    $('#categoryAddModal').modal('show');
});

//AJAX to handle Add Category form
$('#categoryAddForm').on('submit', function (e) {
    e.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
        url: 'MKTAddCategory',
        method: 'POST',
        data: formData,
        success: function (response) {
            alert('Category added successfully!');
            $('#categoryAddModal').modal('hide');
            console.log("Form Data: ", formData);
            location.reload();
        },
        error: function (xhr, status, error) {
            alert('Error adding category details');
            console.log("Form Data: ", formData);
        }
    });
});

$(document).ready(function () {
    $('.sort-btn').on('click', function () {
        var sortField = $(this).data('sort');
        var sortOrder = $(this).data('order');
        var newOrder = sortOrder === 'asc' ? 'desc' : 'asc';
        $(this).data('order', newOrder);

        sortTable(sortField, newOrder);
    });
    function getColumnIndex(field) {
        switch (field) {
            case 'postID':
                return 0;
            case 'thumbnail':
                return 1;
            case 'title':
                return 2;
            case 'category':
                return 3;
            case 'author':
                return 4;
            case 'status':
                return 5;
            case 'feature':
                return 6;
            default:
                return 0;
        }
    }
    function sortTable(field, order) {
        var rows = $('#postList tr').get();
        rows.sort(function (a, b) {
            var A, B;
            if (field === 'status') {
                A = $(a).find('input.statusSwitch').is(':checked') ? 'shown' : 'hidden';
                B = $(b).find('input.statusSwitch').is(':checked') ? 'shown' : 'hidden';
            } else if (field === 'feature') {
                A = $(a).find('input.featureSwitch').is(':checked') ? 'true' : 'false';
                B = $(b).find('input.featureSwitch').is(':checked') ? 'true' : 'false';
            } else {
                A = $(a).children('td').eq(getColumnIndex(field)).text().toUpperCase();
                B = $(b).children('td').eq(getColumnIndex(field)).text().toUpperCase();
            }

            if (field === 'postID') {
                A = parseInt(A, 10);
                B = parseInt(B, 10);
            }

            if (order === 'asc') {
                return (A < B) ? -1 : (A > B) ? 1 : 0;
            } else {
                return (A > B) ? -1 : (A < B) ? 1 : 0;
            }
        });

        $.each(rows, function (index, row) {
            $('#postList').append(row);
        });
    }
    function filterResults() {
        var searchValue = $('#filterInput').val().toLowerCase();
        var statusValue = $('#statusFilter').val();
        var visibleRows = 0;

        $('#postList tr').filter(function () {
            var textMatch = $(this).text().toLowerCase().indexOf(searchValue) > -1;
            var statusMatch = (statusValue === 'all') ||
                    (statusValue === 'shown' && $(this).find('.statusSwitch').is(':checked')) ||
                    (statusValue === 'hidden' && !$(this).find('.statusSwitch').is(':checked'));
            var shouldDisplay = textMatch && statusMatch;
            $(this).toggle(shouldDisplay);

            if (shouldDisplay)
                visibleRows++;
        });

        $('#resultCount').text('Number of results: ' + visibleRows);
    }


    // Initial count
    filterResults();

    // Filter functionality
    $('#filterInput').on('keyup', filterResults);
    $('#statusFilter').on('change', filterResults);

    // Status switch button click
    $('.statusSwitch').change(function () {
        var postID = $(this).data('id');
        var status = $(this).is(':checked') ? 'true' : 'false'; // Send status as "true" or "false"
        $.ajax({
            url: 'updatePostServlet',
            method: 'POST',
            data: {postID: postID, status: status},
            success: function (response) {
                filterResults(); // Re-filter results after status change
                console.log(status);
            },
            error: function () {
                alert('Error updating status');
            }
        });
    });

    $('.featureSwitch').change(function () {
        var postID = $(this).data('id');
        var feature = $(this).is(':checked') ? 'true' : 'false'; // Send status as "true" or "false"
        $.ajax({
            url: 'updatePostServlet',
            method: 'POST',
            data: {postID: postID, feature: feature},
            success: function (response) {
                filterResults(); // Re-filter results after status change
                console.log(feature);
            },
            error: function () {
                alert('Error updating status');
            }
        });
    });

});
function loadResult(url) {
    console.log('Loading orders via AJAX:', url);
    $.ajax({
        url: url,
        method: 'GET',
        dataType: 'html',
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        },
        success: function (response) {
            var newRows = $(response).find('#postList tr');
            $('#postList').html(newRows);

            // Apply filtering logic
            var searchValue = $('#filterInput').val().toLowerCase();
            var statusValue = $('#statusFilter').val();
            var visibleRows = 0;

            $('#postList tr').filter(function () {
                var textMatch = $(this).text().toLowerCase().indexOf(searchValue) > -1;
                var statusMatch = (statusValue === 'all') ||
                        (statusValue === 'shown' && $(this).find('.statusSwitch').is(':checked')) ||
                        (statusValue === 'hidden' && !$(this).find('.statusSwitch').is(':checked'));
                var shouldDisplay = textMatch && statusMatch;
                $(this).toggle(shouldDisplay);

                if (shouldDisplay) {
                    visibleRows++;
                }
            });

            $('#resultCount').text('Number of results: ' + visibleRows);
            console.log('Result loaded and filtered successfully. Number of results:', visibleRows);
        },
        error: function (xhr, status, error) {
            console.error('Error loading orders: ', status, error);
        }
    });
}

function applySort(sortBy) {
    var searchParams = new URLSearchParams(window.location.search);
    searchParams.set('category', sortBy);
    var url = 'mktpostlist?' + searchParams.toString();
    loadResult(url); // Call loadOrders function with the constructed URL
}