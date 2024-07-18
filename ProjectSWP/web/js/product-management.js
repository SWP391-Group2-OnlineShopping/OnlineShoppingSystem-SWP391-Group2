$(document).ready(function () {
    // Initialize DataTables with hidden columns for numeric sorting
    $.fn.dataTable.ext.order['dom-checkbox'] = function (settings, col) {
        return this.api().column(col, {order: 'index'}).nodes().map(function (td, i) {
            return $('input', td).prop('checked') ? 1 : 0;
        });
    };

    var table = $('#productTable').DataTable({
        "autoWidth": false,
        "columnDefs": [
            {"orderable": true, "targets": [0, 2, 4, 5, 6, 8, 9]}, // Enable sorting on ID, Title, List Price, Sale Price, Size, Status, and Feature
            {"orderable": false, "targets": [1, 3, 7, 10]}, // Disable sorting on Thumbnail, Category, Quantities(size), and Actions
            {"orderData": [11], "targets": [4]}, // Sort List Price by hidden numeric column
            {"orderData": [12], "targets": [5]}, // Sort Sale Price by hidden numeric column
            {"visible": false, "targets": [11, 12]}, // Hidden columns for numeric sorting
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
            null, null, null, null // Thêm một phần tử null để khớp với cột mới
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
        var productId = checkbox.attr('id').split('-')[1];
        var status = checkbox.is(':checked') ? 'active' : 'inactive';
        console.log('Sending:', {productID: productId, status: status});
        $.ajax({
            url: 'updateProductStatus',
            type: 'POST',
            data: {
                productID: productId,
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
                $('#category').append(new Option(category.name, category.productCL));
            });
        },
        error: function () {
            alert('Error loading categories');
        }
    });

    // Show the modal when the button is clicked
    $('#addProductBtn').click(function () {
        $('#addProductModal').modal('show');
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
    const isSalePriceValid = value => {
        const salePrice = parseFloat(value);
        const importPrice = parseFloat($('#editImportPrice').val());
        const listPrice = parseFloat($('#editListPrice').val());
        return salePrice > importPrice && salePrice < listPrice;
    };
    const isListPriceValid = value => {
        const listPrice = parseFloat(value);
        const importPrice = parseFloat($('#editImportPrice').val());
        return listPrice > importPrice;
    };
    // Real-time validations
    validateField('#editTitle', '#titleError', isNotEmpty);
    validateField('#editSalePrice', '#salePriceError', isSalePriceValid);
    validateField('#editListPrice', '#listPriceError', isListPriceValid);
    validateField('#editDescription', '#descriptionError', isNotEmpty);
    validateField('#editBriefInformation', '#briefInformationError', isNotEmpty);
    validateField('#editThumbnailLink', '#thumbnailError', isNotEmpty);
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

    // Handle form submission for Add Product Form
    $('#addProductForm').submit(function (e) {
        e.preventDefault();
        let isValid = true;

        // Check if any error messages are visible
        $('.error').each(function () {
            if ($(this).is(':visible')) {
                isValid = false;
            }
        });

        console.log('Form validation state for product:', isValid);
        if (isValid) {
            var formData = $(this).serialize();
            console.log('Submitting form data for product:', formData);

            $.ajax({
                url: 'AddProduct',
                method: 'POST',
                data: formData,
                success: function (response) {
                    console.log('Product Response:', response);
                    if (response.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Product added successfully',
                            showConfirmButton: false,
                            timer: 1500,
                            position: 'center'
                        }).then(() => {
                            $('#addProductModal').modal('hide');
                            location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error adding product',
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

    // Handle form submission for Edit Product Form
    $('#editProductForm').submit(function (e) {
        e.preventDefault();
        let isValid = true;

        // Check if any error messages are visible
        $('.error').each(function () {
            if ($(this).is(':visible')) {
                isValid = false;
            }
        });

        console.log('Form validation state for product:', isValid);
        if (isValid) {
            var formData = $(this).serialize();
            console.log('Submitting form data for product:', formData);

            $.ajax({
                url: 'updateProduct',
                method: 'POST',
                data: formData,
                success: function (response) {
                    console.log('Product Response:', response);
                    if (response.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Product updated successfully',
                            showConfirmButton: false,
                            timer: 1500,
                            position: 'center'
                        }).then(() => {
                            $('#editProductModal').modal('hide');
                            location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error updating product',
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

    // Show Add Product Modal
    $('#addProductBtn').click(function () {
        $('#addProductModal').modal('show');
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

    // Handle view product details
    $(document).on('click', '.viewBtn', function () {
        const productId = $(this).data('id');
        $.ajax({
            url: 'getProductDetails',
            type: 'GET',
            data: {productId: productId},
            dataType: 'json',
            success: function (product) {
                $('#viewProductId').val(product.productID);
                $('#viewTitle').val(product.title);
                $('#viewImportPrice').val(product.importPrice);
                $('#viewSalePrice').val(product.salePrice);
                $('#viewListPrice').val(product.listPrice);
                $('#viewDescription').val(product.description);
                $('#viewBriefInformation').val(product.briefInformation);
                $('#viewSize').val(product.size);
                $('#viewCategory').val(product.category);
                $('#viewStatus').prop('checked', product.status);
                $('#viewFeature').prop('checked', product.feature);
                $('#viewHold').val(product.holdSizes);

                // Display Thumbnail image
                const thumbnailContainer = $('#viewThumbnailContainer');
                thumbnailContainer.empty();
                if (product.thumbnailLink) {
                    const imgElement = $('<img>').attr('src', product.thumbnailLink).css({
                        'max-width': '100%', 'height': 'auto', 'display': 'block', 'margin-bottom': '10px'
                    });
                    imgElement.on('error', function () {
                        $(this).replaceWith($('<div>').text("This product doesn't have a thumbnail image").css({'color': 'red'}));
                    });
                    thumbnailContainer.append(imgElement);
                } else {
                    thumbnailContainer.append($('<div>').text("This product doesn't have a thumbnail image").css({'color': 'red'}));
                }

                // Display attached images
                const imageDetailsContainer = $('#viewImageDetailsContainer');
                imageDetailsContainer.empty();
                if (product.imageDetails) {
                    const imageUrls = product.imageDetails.split(', ');
                    imageUrls.forEach(url => {
                        const imgElement = $('<img>').attr('src', url).css({
                            'max-width': '100%', 'height': 'auto', 'display': 'block', 'margin-bottom': '10px'
                        });
                        imgElement.on('error', function () {
                            $(this).replaceWith($('<div>').text("This product doesn't have an image").css({'color': 'red'}));
                        });
                        imageDetailsContainer.append(imgElement);
                    });
                } else {
                    imageDetailsContainer.append($('<div>').text("This product doesn't have any images").css({'color': 'red'}));
                }

                $('#viewProductModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch product details:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
    });
    function checkFormValidity() {
        const isFormValid = isNotEmpty($('#editTitle').val()) &&
                isSalePriceValid($('#editSalePrice').val()) &&
                isListPriceValid($('#editListPrice').val()) &&
                isNotEmpty($('#editDescription').val()) &&
                isNotEmpty($('#editBriefInformation').val());

        $('#editStatus').prop('disabled', !isFormValid);
    }

    // Handle edit product details
    $(document).on('click', '.editBtn', function () {
        const productId = $(this).data('id');
        $.ajax({
            url: 'getProductDetails',
            type: 'GET',
            data: {productId: productId},
            dataType: 'json',
            success: function (product) {
                $('#editProductId').val(product.productID);
                $('#editTitle').val(product.title);
                $('#editImportPrice').val(product.importPrice);
                $('#editSalePrice').val(product.salePrice);
                $('#editListPrice').val(product.listPrice);
                $('#editDescription').val(product.description);
                $('#editBriefInformation').val(product.briefInformation);
                $('#editThumbnailLink').val(product.thumbnailLink);
                $('#editStatus').prop('checked', product.status);
                $('#editFeature').prop('checked', product.feature);
                $('#editSize').val(product.size);
                $('#editQuantitiesSizes').val(product.quantitiesSizes);

                // Display Thumbnail image
                const thumbnailContainer = $('#editThumbnailContainer');
                thumbnailContainer.empty();
                if (product.thumbnailLink) {
                    const imgElement = $('<img>').attr('src', product.thumbnailLink).css({
                        'max-width': '100%', 'height': 'auto', 'display': 'block', 'margin-bottom': '10px'
                    });
                    imgElement.on('error', function () {
                        $(this).replaceWith($('<div>').text("This product doesn't have a thumbnail image").css({'color': 'red'}));
                    });
                    thumbnailContainer.append(imgElement);
                } else {
                    thumbnailContainer.append($('<div>').text("This product doesn't have a thumbnail image").css({'color': 'red'}));
                }

                // Display attached images
                const imageDetailsContainer = $('#editImageDetailsContainer');
                imageDetailsContainer.empty();
                if (product.imageDetails) {
                    const imageUrls = product.imageDetails.split(', ');
                    imageUrls.forEach(url => {
                        const imgElement = $('<img>').attr('src', url).css({
                            'max-width': '100%', 'height': 'auto', 'display': 'block', 'margin-bottom': '10px'
                        });
                        imgElement.on('error', function () {
                            $(this).replaceWith($('<div>').text("This product doesn't have an image").css({'color': 'red'}));
                        });
                        imageDetailsContainer.append(imgElement);
                    });
                } else {
                    imageDetailsContainer.append($('<div>').text("This product doesn't have any images").css({'color': 'red'}));
                }
                                 loadCategories(product.category);

                $('#editProductModal').modal('show');
                checkFormValidity(); 
            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch product details:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
    });

// Handle form submission for updating product
    $('#editProductForm').on('submit', function (e) {
        const salePrice = $('#editSalePrice').val();
        const listPrice = $('#editListPrice').val();

        let isValid = true;

        if (!isSalePriceValid(salePrice)) {
            $('#salePriceError').show();
            isValid = false;
        } else {
            $('#salePriceError').hide();
        }

        if (!isListPriceValid(listPrice)) {
            $('#listPriceError').show();
            isValid = false;
        } else {
            $('#listPriceError').hide();
        }

        if (!isValid) {
            e.preventDefault();
            alert('Please fix the errors before submitting the form.');
        }
    });

    function loadCategories(selectedCategory) {
        $.ajax({
            url: 'getCategories',
            method: 'GET',
            success: function (response) {
                var categorySelect = $('#editCategory');
                categorySelect.empty();
                response.forEach(function (category) {
                    var option = $('<option>').val(category.productCL).text(category.name);
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

    $('#updateProductBtn').on('click', function () {
        // Cập nhật các trường hidden trước khi gửi form
        var imageDetails = $('#editImageDetailsContainer input[name="imageDetails[]"]').map(function () {
            return $(this).val();
        }).get().join(', ');
        $('#editImageDetails').val(imageDetails);

        // Serialize form data và gửi bằng AJAX
        const formData = $('#editProductForm').serialize();
        $.ajax({
            url: 'updateProduct',
            type: 'POST',
            data: formData,
            success: function (response) {
                if (response.status === 'success') {
                    Swal.fire({
                        icon: 'success',
                        title: 'Product updated successfully',
                        showConfirmButton: false,
                        timer: 1500,
                        position: 'center'
                    }).then(() => {
                        $('#editProductModal').modal('hide');
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
                console.error('Failed to update product:', error);
                console.error('Response text:', xhr.responseText);
            }
        });
    });

    // Delete product
   $(document).on('click', '.deleteBtn', function () {
    var productId = $(this).data('id');
    var quantity = parseInt($(`#quantity-${productId}`).text().trim());

    // Debugging output to verify quantity value
    console.log("Product ID: " + productId);
    console.log("Quantity: " + quantity);

    if (quantity > 0) {
        Swal.fire({
            icon: 'error',
            title: 'Cannot delete product',
            text: 'Product quantity must be zero to delete.',
            position: 'center'
        });
        return;
    }

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
                url: 'deleteProduct',
                type: 'POST',
                data: {
                    productID: productId
                },
                success: function (response) {
                    if (response.deleted) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Your product has been deleted',
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