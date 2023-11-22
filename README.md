# api_upload_flutter

##php server code : 

# Image Upload

This code allows you to upload an image to the `image` directory.

```php
<?php

$file_path = "image/";

$file_path = $file_path . basename( $_FILES['file']['name']);
if(move_uploaded_file($_FILES['file']['tmp_name'], $file_path)) {
    echo "success";
} else{
    echo "fail";
}

?>


The code first defines a variable `$file_path` that stores the path to the `image` directory. Then, it concatenates the filename of the uploaded file to the `$file_path` variable to create the full path to the uploaded file. Finally, it uses the `move_uploaded_file()` function to move the uploaded file from its temporary location to the specified path. If the upload is successful, it prints "success"; otherwise, it prints "fail".
