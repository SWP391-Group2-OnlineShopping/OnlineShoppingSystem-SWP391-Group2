$(document).ready(function () {
    // Initialize DataTables with hidden columns for numeric sorting
     $.fn.dataTable.ext.order['dom-checkbox'] = function (settings, col) {
        return this.api().column(col, { order: 'index' }).nodes().map(function (td, i) {
            return $('input', td).prop('checked') ? 1 : 0;
        });
    };

    var table = $('#postTable').DataTable({
        "autoWidth": false,
        "columnDefs": [
            {"orderable": true, "targets": [0, 2, 4, 5]}, // Enable sorting on ID, Title, Author, Status
            {"orderable": false, "targets": [1, 3, 6 ,7]}, // Disable sorting on Thumbnail, Category, and Actions
            {"width": "150px", "targets": 3},
            {"orderDataType": "dom-checkbox", "targets": [8, 9]} // Custom sort for Status and Feature
        ],
        "order": [[0, "asc"]], // Default sort by ID
        "columns": [
            null, null, null, null,
            {"orderData": 11},
            {"orderData": 12},
            null, null,
            {"orderDataType": "dom-checkbox"}, // Custom sort for Status
            {"orderDataType": "dom-checkbox"}, // Custom sort for Feature
            null, null, null
        ]
    });

    // Initialize Select2 for category filter
    table.columns().every(function () {
        var column = this;
        if (column.index() == 3) {
            var select = $('<select multiple="multiple" class="form-control"><option value=""></option></select>')
                    .appendTo($(column.header()).empty())
                    .on('change', function () {
                        var vals = $(this).val();
                        var searchStr = '';
                        if (vals) {
                            searchStr = vals.join('|');
                        }
                        column.search(searchStr, true, false).draw();
                    });
            column.data().unique().sort().each(function (d, j) {
                select.append('<option value="' + d + '">' + d + '</option>');
            });
            $(select).select2({
                placeholder: 'Category',
                allowClear: false,
                width: 'resolve',
                dropdownAutoWidth: true
            }).on('select2:unselecting', function (e) {
                $(this).data('unselecting', true);
            }).on('select2:open', function (e) {
                if ($(this).data('unselecting')) {
                    $(this).select2('close');
                    $(this).removeData('unselecting');
                }
            });
        }
    });

    // Handle dynamic checkbox change events
    $(document).on('change', 'input[id^="status-"]', function () {
        var checkbox = $(this);
        var postId = checkbox.attr('id').split('-')[1];
        var status = checkbox.is(':checked') ? 'active' : 'inactive';
        console.log('Sending:', {postID: postId, status: status});
        $.ajax({
            url: 'updatePostStatus',
            type: 'POST',
            data: {
                postID: postId,
                status: status
            },
            success: function (response) {
                console.log('Response:', response);
                if (!response.updated) {
                    checkbox.prop('checked', status === 'inactive');
                }
            },
            error: function (error) {
                console.log('Error:', error);
                checkbox.prop('checked', status === 'inactive');
            }
        });
    });

    // Load categories
    $.ajax({
        url: 'getCategories',
        method: 'GET',
        success: function (response) {
            response.forEach(function (category) {
                $('#category').append(new Option(category.name, category.postCL));
            });
        },
        error: function () {
            alert('Error loading categories');
        }
    });

    // Show the modal when the button is clicked
    $('#addPostBtn').click(function () {
        $('#addPostModal').modal('show');
    });

    // Validate input fields in real-time
    function validateField(field, errorField, validationFn) {
        $(field).on('input change', function () {
            if (!validationFn($(this).val())) {
                $(errorField).show();
            } else {
                $(errorField).hide();
            }
        });
    }

    // Validation functions
    const isNotEmpty = value => value.trim() !== '';
    const isGreaterThanZero = value => parseFloat(value) > 0;
    const isValidSize = value => parseInt(value) >= 35 && parseInt(value) <= 48;

    // Real-time validations
     validateField('#title', '#titleError', isNotEmpty);
                validateField('#salePrice', '#salePriceError', isGreaterThanZero);
                validateField('#listPrice', '#listPriceError', isGreaterThanZero);
                validateField('#description', '#descriptionError', isNotEmpty);
                validateField('#briefInformation', '#briefInformationError', isNotEmpty);
                validateField('#thumbnail', '#thumbnailError', isNotEmpty);
                validateField('#size', '#sizeError', isValidSize);
                validateField('#quantities', '#quantitiesError', isGreaterThanZero);
                validateField('#category', '#categoryError', isNotEmpty);

    // Handle adding image details for add modal
    $('#addImageDetail').click(function () {
        var imageLink = $('#imageDetail').val();
        var newImageDetail = $('<div class="input-group mb-3">')
                .append($('<input type="text" class="form-control" name="imageDetails[]" readonly>').val(imageLink))
                .append($('<div class="input-group-append">')
                        .append($('<button class="btn btn-outline-secondary remove-image" type="button">Remove</button>')));

        $('#addImageDetailsContainer').append(newImageDetail);
        $('#imageDetail').val('');

        // Update hidden input field for image details
        var imageDetails = $('#addImageDetailsContainer input[name="imageDetails[]"]').map(function () {
            return $(this).val();
        }).get().join(', ');
        $('#imageDetails').val(imageDetails);
    });

    // Handle removing image details
    $(document).on('click', '.remove-image', function () {
        $(this).closest('.input-group').remove();

        // Update hidden input field for image details
        var imageDetails = $('#addImageDetailsContainer input[name="imageDetails[]"]').map(function () {
            return $(this).val();
        }).get().join(', ');
        $('#imageDetails').val(imageDetails);
    });

    // Handle form submission for Add Post Form
    $('#addPostForm').submit(function (e) {
        e.preventDefault();
        let isValid = true;

        // Check if any error messages are visible
        $('.error').each(function () {
            if ($(this).is(':visible')) {
                isValid = false;
            }
        });

        console.log('Form validation state for post:', isValid);
        if (isValid) {
            var formData = $(this).serialize();
            console.log('Submitting form data for post:', formData);

            $.ajax({
                url: 'AddPost',
                method: 'POST',
                data: formData,
                success: function (response) {
                    console.log('Post Response:', response);
                    if (response.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Post added successfully',
                            showConfirmButton: false,
                            timer: 1500,
                            position: 'center'
                        }).then(() => {
                            $('#addPostModal').modal('hide');
                            location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error adding post',
                            text: response.message,
                            position: 'center'
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Something went wrong!',
                        position: 'center'
                    });
                }
            });
        }
    });

    // Handle adding image details for edit modal
    $('#addEditImageDetail').click(function () {
        var imageLink = $('#editImageDetail').val();
        var newImageDetail = $('<div class="input-group mb-3">')
                .append($('<input type="text" class="form-control" name="imageDetails[]" readonly>').val(imageLink))
                .append($('<div class="input-group-append">')
                        .append($('<button class="btn btn-outline-secondary remove-image" type="button">Remove</button>')));

        $('#editImageDetailsContainer').append(newImageDetail);
        $('#editImageDetail').val('');

        // Update hidden input field for image details
        var imageDetails = $('#editImageDetailsContainer input[name="imageDetails[]"]').map(function () {
            return $(this).val();
        }).get().join(', ');
        $('#editImageDetails').val(imageDetails);
    });

    // Handle removing image details for edit modal
    $(document).on('click', '.remove-image', function () {
        $(this).closest('.input-group').remove();

        // Update hidden input field for image details
        var imageDetails = $('#editImageDetailsContainer input[name="imageDetails[]"]').map(function () {
            return $(this).val();
        }).get().join(', ');
        $('#editImageDetails').val(imageDetails);
    });

    // Handle form submission for Edit Post Form
    $('#editPostForm').submit(function (e) {
        e.preventDefault();
        let isValid = true;

        // Check if any error messages are visible
        $('.error').each(function () {
            if ($(this).is(':visible')) {
                isValid = false;
            }
        });

        console.log('Form validation state for post:', isValid);
        if (isValid) {
            var formData = $(this).serialize();
            console.log('Submitting form data for post:', formData);

            $.ajax({
                url: 'updatePost',
                method: 'POST',
                data: formData,
                success: function (response) {
                    console.log('Post Response:', response);
                    if (response.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Post updated successfully',
                            showConfirmButton: false,
                            timer: 1500,
                            position: 'center'
                        }).then(() => {
                            $('#editPostModal').modal('hide');
                            location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error updating post',
                            text: response.message,
                            position: 'center'
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Something went wrong!',
                        position: 'center'
                    });
                }
            });
        }
    });

    // Show Add Post Modal
    $('#addPostBtn').click(function () {
        $('#addPostModal').modal('show');
    });

    // Show Add Brand Modal
    $('#addBrandBtn').click(function () {
        $('#addBrandModal').modal('show');
    });
    // Handle form submission for Add Brand Form
                $('#addBrandForm').submit(function (e) {
                    e.preventDefault();
                    let isValid = true;
                    // Check if any error messages are visible
                    $('.error').each(function () {
                        if ($(this).is(':visible')) {
                            isValid = false;
                        }
                    });
                    console.log('Form validation state for brand:', isValid); // Log the validation state
                    if (isValid) {
                        var formData = $(this).serialize();
                        console.log('Submitting form data for brand:', formData); // Log the form data
                        $.ajax({
                            url: 'AddBrand', // Ensure this URL is correct
                            method: 'POST',
                            data: formData,
                            success: function (response) {
                                console.log('Brand Response:', response); // Log the response
                                if (response.status === 'success') {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Brand added successfully',
                                        showConfirmButton: false,
                                        timer: 1500,
                                        position: 'center'
                                    }).then(() => {
                                        $('#addBrandModal').modal('hide');
                                        location.reload(); // Reload the page to see the new brand
                                    });
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Error adding brand',
                                        text: response.message,
                                        position: 'center'
                                    });
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Oops...',
                                    text: 'Something went wrong!',
                                    position: 'center'
                                });
                            }
                        });
                           }
                });

    // Handle view post details
    $(document).on('click', '.viewBtn', function () {
        const postId = $(this).data('id');
        $.ajax({
            url: 'getPostDetails',
            type: 'GET',
            data: {postId: postId},
            dataType: 'json',
            success: function (post) {
                $('#viewPostId').val(post.postID);
                $('#viewTitle').val(post.title);
                $('#viewSalePrice').val(post.salePrice);
                $('#viewListPrice').val(post.listPrice);
                $('#viewDescription').val(post.description);
                $('#viewBriefInformation').val(post.briefInformation);
                $('#viewSize').val(post.size);
                $('#viewCategory').val(post.category);
                $('#viewStatus').prop('checked', post.status);
                $('#viewFeature').prop('checked', post.feature);

                // Display Thumbnail image
                const thumbnailContainer = $('#viewThumbnailContainer');
                thumbnailContainer.empty();
                if (post.thumbnailLink) {
                    const imgElement = $('<img>').attr('src', post.thumbnailLink).css({
                        'max-width': '100%', 'height': 'auto', 'display': 'block', 'margin-bottom': '10px'
                    });
                    imgElement.on('error', function () {
                        $(this).replaceWith($('<div>').text("This post doesn't have a thumbnail image").css({'color': 'red'}));
                    });
                    thumbnailContainer.append(imgElement);
                } else {
                    thumbnailContainer.append($('<div>').text("This post doesn't have a thumbnail image").css({'color': 'red'}));
                }

                // Display attached images
                const imageDetailsContainer = $('#viewImageDetailsContainer');
                imageDetailsContainer.empty();
                if (post.imageDetails) {
                    const imageUrls = post.imageDetails.split(', ');
                    imageUrls.forEach(url => {
                        const imgElement = $('<img>').attr('src', url).css({
                            'max-width': '100%', 'height': 'auto', 'display': 'block', 'margin-bottom': '10px'
                        });
                        imgElement.on('error', function () {
                            $(this).replaceWith($('<div>').text("This post doesn't have an image").css({'color': 'red'}));
                        });
                        imageDetailsContainer.append(imgElement);
                    });
                } else {
                    imageDetailsContainer.append($('<div>').text("This post doesn't have any images").css({'color': 'red'}));
                }

                $('#viewPostModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch post details:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
    });

    // Handle edit post details
    $(document).on('click', '.editBtn', function () {
        const postId = $(this).data('id');
        $.ajax({
            url: 'getPostDetails',
            type: 'GET',
            data: {postId: postId},
            dataType: 'json',
            success: function (post) {
                $('#editPostId').val(post.postID);
                $('#editTitle').val(post.title);
                $('#editSalePrice').val(post.salePrice);
                $('#editListPrice').val(post.listPrice);
                $('#editDescription').val(post.description);
                $('#editBriefInformation').val(post.briefInformation);
                $('#editThumbnailLink').val(post.thumbnailLink);
                $('#editStatus').prop('checked', post.status);
                $('#editFeature').prop('checked', post.feature);
                $('#editSize').val(post.size);
                $('#editQuantitiesSizes').val(post.quantitiesSizes);

                // Display Thumbnail image
                const thumbnailContainer = $('#editThumbnailContainer');
                thumbnailContainer.empty();
                if (post.thumbnailLink) {
                    const imgElement = $('<img>').attr('src', post.thumbnailLink).css({
                        'max-width': '100%', 'height': 'auto', 'display': 'block', 'margin-bottom': '10px'
                    });
                    imgElement.on('error', function () {
                        $(this).replaceWith($('<div>').text("This post doesn't have a thumbnail image").css({'color': 'red'}));
                    });
                    thumbnailContainer.append(imgElement);
                } else {
                    thumbnailContainer.append($('<div>').text("This post doesn't have a thumbnail image").css({'color': 'red'}));
                }

                // Display attached images
                const imageDetailsContainer = $('#editImageDetailsContainer');
                imageDetailsContainer.empty();
                if (post.imageDetails) {
                    const imageUrls = post.imageDetails.split(', ');
                    imageUrls.forEach(url => {
                        const imgElement = $('<img>').attr('src', url).css({
                            'max-width': '100%', 'height': 'auto', 'display': 'block', 'margin-bottom': '10px'
                        });
                        imgElement.on('error', function () {
                            $(this).replaceWith($('<div>').text("This post doesn't have an image").css({'color': 'red'}));
                        });
                        imageDetailsContainer.append(imgElement);
                    });
                } else {
                    imageDetailsContainer.append($('<div>').text("This post doesn't have any images").css({'color': 'red'}));
                }

                // Load categories and set selected category
                loadCategories(post.category);

                $('#editPostModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch post details:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
    });

    function loadCategories(selectedCategory) {
        $.ajax({
            url: 'getCategories',
            method: 'GET',
            success: function (response) {
                var categorySelect = $('#editCategory');
                categorySelect.empty();
                response.forEach(function (category) {
                    var option = $('<option>').val(category.postCL).text(category.name);
                    if (category.name === selectedCategory) {
                        option.attr('selected', 'selected');
                    }
                    categorySelect.append(option);
                });
            },
            error: function () {
                alert('Error loading categories');
            }
        });
    }

    $('#addEditImageDetail').click(function () {
        var imageLink = $('#editImageDetail').val();
        if (imageLink.trim() !== "") { // Ensure the input is not empty
            var newImageDetail = $('<div class="input-group mb-3">')
                    .append($('<input type="text" class="form-control" name="imageDetails[]" readonly>').val(imageLink))
                    .append($('<div class="input-group-append">')
                            .append($('<button class="btn btn-outline-secondary remove-image" type="button">Remove</button>')));

            $('#editImageDetailsContainer').append(newImageDetail);
            $('#editImageDetail').val('');

            // Update hidden input field for image details
            updateImageDetails();
        }
    });

    $(document).on('click', '.remove-image', function () {
        $(this).closest('.input-group').remove();
        // Update hidden input field for image details
        updateImageDetails();
    });

    function updateImageDetails() {
        var imageDetails = $('#editImageDetailsContainer input[name="imageDetails[]"]').map(function () {
            return $(this).val();
        }).get().join(', ');
        $('#editImageDetails').val(imageDetails);
    }

    $('#updatePostBtn').on('click', function () {
        // Cập nhật các trường hidden trước khi gửi form
        var imageDetails = $('#editImageDetailsContainer input[name="imageDetails[]"]').map(function () {
            return $(this).val();
        }).get().join(', ');
        $('#editImageDetails').val(imageDetails);

        // Serialize form data và gửi bằng AJAX
        const formData = $('#editPostForm').serialize();
        $.ajax({
            url: 'updatePost',
            type: 'POST',
            data: formData,
            success: function (response) {
                if (response.status === 'success') {
                    Swal.fire({
                        icon: 'success',
                        title: 'Post updated successfully',
                        showConfirmButton: false,
                        timer: 1500,
                        position: 'center'
                    }).then(() => {
                        $('#editPostModal').modal('hide');
                        location.reload();
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: response.message,
                        position: 'center'
                    });
                }
            },
            error: function (xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Something went wrong!',
                    position: 'center'
                });
                console.error('Failed to update post:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
    });

    // Delete post
    $(document).on('click', '.deleteBtn', function () {
        var postId = $(this).closest('tr').find('td:first').text();
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'deletePost',
                    type: 'POST',
                    data: {
                        postID: postId
                    },
                    success: function (response) {
                        if (response.deleted) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Your post has been deleted',
                                showConfirmButton: false,
                                timer: 1500,
                                position: 'center'
                            }).then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Something went wrong!',
                                position: 'center'
                            });
                        }
                    },
                    error: function (error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'Something went wrong!',
                            position: 'center'
                        });
                    }
                });
            }
        });
    });
});


