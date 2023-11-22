# api_upload_flutter



# Server code : 

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

